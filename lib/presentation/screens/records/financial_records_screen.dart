import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/routes/navigation_service.dart';
import '../../../config/routes/route_arguments.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart';
import '../../../providers/repository_providers.dart';

// =====================================================================
// الشاشة الرئيسية التي تحتوي على الـ TabController
// =====================================================================
class FinancialRecordsScreen extends StatelessWidget {
  const FinancialRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // نغلف الشاشة بـ DefaultTabController ونجعل عدد التابات 2
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // TODO: إجراء الإضافة
        //   },
        //   backgroundColor: AppColors.primary,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        //   child: Icon(Icons.add, color: Colors.white, size: 28.sp),
        // ),
        body: Column(
          children: [
            _buildCustomTabBar(),
            // عرض المحتوى بناءً على التاب المحدد
            const Expanded(
              child: TabBarView(
                children: [
                  InvoicesTabWidget(), // ويدجت الفواتير المستقل
                  PaymentsTabWidget(), // ويدجت الدفعات المستقل
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_forward, color: AppColors.primary, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'السجلات المالية',
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColors.onSurfaceVariant, size: 24.sp),
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.outlineVariant),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Text('هذا الشهر', style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                  SizedBox(width: 4.w),
                  Icon(Icons.expand_more, size: 16.sp, color: AppColors.onSurfaceVariant),
                ],
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  // تخصيص الـ TabBar ليظهر كـ Segmented Control
  Widget _buildCustomTabBar() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent, // إخفاء الخط السفلي الافتراضي
          indicator: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          unselectedLabelColor: AppColors.onSurfaceVariant,
          tabs: const [
            Tab(text: 'الفواتير'),
            Tab(text: 'سجل الدفعات'),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//                       ويدجت الفواتير (مستقل)
// =====================================================================
class InvoicesTabWidget extends ConsumerStatefulWidget {
  const InvoicesTabWidget({super.key});

  @override
  ConsumerState<InvoicesTabWidget> createState() => _InvoicesTabWidgetState();
}

class _InvoicesTabWidgetState extends ConsumerState<InvoicesTabWidget> {
  int _invoiceFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final invoicesAsync = ref.watch(invoicesListProvider);

    return invoicesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('حدث خطأ: $err')),
      data: (allInvoices) {
        final int totalCount = allInvoices.length;
        final double totalCash = allInvoices.where((i) => i.status == 'نقد' || i.status == 'cash').fold(0.0, (sum, i) => sum + i.totalAmount);
        final double totalDebt = allInvoices.where((i) => i.status == 'debt').fold(0.0, (sum, i) => sum + i.totalAmount);

        final filteredInvoices = allInvoices.where((invoice) {
          if (_invoiceFilterIndex == 0) return true;
          if (_invoiceFilterIndex == 1) return invoice.status == 'نقد' || invoice.status == 'cash';
          if (_invoiceFilterIndex == 2) return invoice.status == 'debt';
          if (_invoiceFilterIndex == 3) return invoice.status == 'ملغاة' || invoice.status == 'cancelled';
          return true;
        }).toList();

        return Column(
          children: [
            _buildInvoiceSummary(totalCount, totalCash, totalDebt),
            _buildInvoiceFilters(),
            Expanded(
              child: filteredInvoices.isEmpty
                  ? Center(child: Text('لا توجد فواتير', style: TextStyle(color: AppColors.outline)))
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: filteredInvoices.length,
                itemBuilder: (context, index) => _RealInvoiceCard(invoice: filteredInvoices[index]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInvoiceSummary(int count, double cash, double debt) {
    return SizedBox(
      height: 80.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _summaryCard('الإجمالي', '$count فاتورة', AppColors.primary),
          SizedBox(width: 8.w),
          _summaryCard('نقد', '₪${cash.toStringAsFixed(0)}', AppColors.secondary),
          SizedBox(width: 8.w),
          _summaryCard('آجل', '₪${debt.toStringAsFixed(0)}', AppColors.error),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String value, Color valueColor) {
    return Container(
      width: 110.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
          SizedBox(height: 4.h),
          Text(value , style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: valueColor),),
        ],
      ),
    );
  }

  Widget _buildInvoiceFilters() {
    return SizedBox(
      height: 60.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        children: [
          GestureDetector(onTap: () => setState(() => _invoiceFilterIndex = 0), child: _filterChip('الكل', _invoiceFilterIndex == 0)),
          GestureDetector(onTap: () => setState(() => _invoiceFilterIndex = 1), child: _filterChip('نقد', _invoiceFilterIndex == 1)),
          GestureDetector(onTap: () => setState(() => _invoiceFilterIndex = 2), child: _filterChip('آجل/دين', _invoiceFilterIndex == 2)),
          GestureDetector(onTap: () => setState(() => _invoiceFilterIndex = 3), child: _filterChip('ملغاة', _invoiceFilterIndex == 3)),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20.r),
        border: isSelected ? null : Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}

// =====================================================================
//                       ويدجت الدفعات (مستقل)
// =====================================================================
class PaymentsTabWidget extends ConsumerWidget {
  const PaymentsTabWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(paymentsListProvider);

    return paymentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('حدث خطأ: $err')),
      data: (payments) {
        final sortedPayments = List<Payment>.from(payments)..sort((a, b) => b.date.compareTo(a.date));

        final now = DateTime.now();
        double todayTotal = 0;
        for (var p in sortedPayments) {
          if (p.date.year == now.year && p.date.month == now.month && p.date.day == now.day) {
            todayTotal += p.amount;
          }
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₪ ${todayTotal.toStringAsFixed(0)} مُحصَّل اليوم', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                    Icon(Icons.analytics, color: Colors.white, size: 24.sp),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: sortedPayments.isEmpty
                  ? Center(child: Text('لا توجد دفعات مسجلة', style: TextStyle(color: AppColors.outline)))
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: sortedPayments.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _RealPaymentCard(payment: sortedPayments[index]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// =====================================================================
//                       مكونات البطاقات المشتركة
// =====================================================================

class _RealInvoiceCard extends ConsumerWidget {
  final Invoice invoice;
  const _RealInvoiceCard({required this.invoice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String customerName = 'زبون نقدي';
    if (invoice.customerId != null) {
      final customerData = ref.watch(customerByIdProvider(invoice.customerId!));
      if (customerData is AsyncData && customerData.value != null) {
        customerName = customerData.value!.name;
      }
    }

    final String formattedId = 'INV-${invoice.id.toString().padLeft(4, '0')}#';
    final String formattedAmount = '₪${invoice.totalAmount.toStringAsFixed(2)}';

    final now = DateTime.now();
    final date = invoice.date;
    String dateStr;
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      dateStr = 'اليوم، ${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'م' : 'ص'}';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      dateStr = 'أمس، ${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'م' : 'ص'}';
    } else {
      dateStr = '${date.day}/${date.month}/${date.year}';
    }

    String statusText = invoice.status;
    Color statusColor = AppColors.outline;
    Color bgColor = AppColors.surfaceContainerLowest;

    if (statusText == 'نقد' || statusText == 'cash') {
      statusText = 'نقد';
      statusColor = AppColors.secondary;
      bgColor = AppColors.secondaryContainer.withOpacity(0.3);
    } else if (statusText == 'دين' || statusText == 'آجل' || statusText == 'debt') {
      statusText = 'دين';
      statusColor = AppColors.error;
      bgColor = AppColors.errorContainer.withOpacity(0.3);
    }

    return InkWell(
      onTap: () => NavigationService.navigateTo(
        AppRoutes.invoicesDetails,
        arguments: InvoiceDetailsArgs(invoiceId: invoice.id),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -16.w, top: -16.h, bottom: -16.h,
              child: Container(width: 4.w, color: statusColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formattedId, style: TextStyle(fontSize: 14.sp, color: AppColors.outline, fontFamily: 'monospace')),
                    Text(dateStr, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(customerName, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    Text(formattedAmount, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.primary), textDirection: TextDirection.ltr),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('منتجات', style: TextStyle(fontSize: 13.sp, color: AppColors.onSurfaceVariant)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12.r)),
                      child: Row(
                        children: [
                          Text(statusText, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: statusColor)),
                          SizedBox(width: 4.w),
                          Icon(statusText == 'نقد' ? Icons.check : Icons.warning_amber_rounded, size: 14.sp, color: statusColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class _RealPaymentCard extends ConsumerWidget {
  final Payment payment;
  const _RealPaymentCard({required this.payment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerAsync = ref.watch(customerByIdProvider(payment.customerId));
    final String customerName = customerAsync.valueOrNull?.name ?? 'جاري التحميل...';
    final String initial = customerName.isNotEmpty ? customerName.substring(0, 1) : '؟';

    final now = DateTime.now();
    final date = payment.date;
    String dateStr;
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      dateStr = 'اليوم، ${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'م' : 'ص'}';
    } else {
      dateStr = '${date.day}/${date.month}، ${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'م' : 'ص'}';
    }

    final String subtitle = payment.method == 'نقد' ? 'دفعة نقدية' : (payment.method == 'تحويل' ? '-' : 'دفعة الحساب');

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(color: AppColors.secondaryContainer.withOpacity(0.5), shape: BoxShape.circle),
                child: Center(
                  child: Text(initial, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customerName, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  SizedBox(height: 2.h),
                  Text('$dateStr • ${payment.method}', style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('+₪ ${payment.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.secondary), textDirection: TextDirection.ltr),
              SizedBox(height: 2.h),
              Text(subtitle, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}