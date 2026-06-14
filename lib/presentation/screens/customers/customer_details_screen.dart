import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/routes/navigation_service.dart';
import '../../../config/routes/route_arguments.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart';
import '../../../providers/repository_providers.dart';

// --- كلاس مساعد لدمج الفواتير والدفعات في قائمة واحدة ---
enum TransactionType { invoice, payment }

class CustomerTransaction {
  final int id;
  final DateTime date;
  final double amount;
  final TransactionType type;
  final String title;
  final String subtitle;
  final String status;

  CustomerTransaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.status,
  });
}
// --------------------------------------------------------

class CustomerDetailsScreen extends ConsumerWidget {
  final int customerId;

  const CustomerDetailsScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerAsync = ref.watch(customerByIdProvider(customerId));

    // جلب كلا السجلين (الفواتير والدفعات)
    final invoicesAsync = ref.watch(invoicesByCustomerIdProvider(customerId));
    final paymentsAsync = ref.watch(paymentsByCustomerIdProvider(customerId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: customerAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('خطأ في تحميل العميل: $err')),
        data: (customer) {
          if (customer == null) return const Center(child: Text('العميل غير موجود'));

          // التحقق من حالة التحميل للسجلين
          final isTransactionsLoading = (invoicesAsync.isLoading && !invoicesAsync.hasValue) ||
              (paymentsAsync.isLoading && !paymentsAsync.hasValue);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderProfile(customer),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'سجل المعاملات',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                  ),
                ),
                SizedBox(height: 16.h),

                // عرض المعاملات بعد دمجها
                if (isTransactionsLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  _buildCombinedTimeline(invoicesAsync.valueOrNull ?? [], paymentsAsync.valueOrNull ?? []),

                SizedBox(height: 100.h),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF0F7FF),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: AppColors.onSurfaceVariant, size: 24.sp),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeaderProfile(Customer customer) {
    final initials = customer.name.trim().split(' ').take(2).map((w) => w.isNotEmpty ? w[0].toUpperCase() : '').join();

    return Container(
      width: double.infinity,
      color: const Color(0xFFF0F7FF),
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.primary,
            child: Text(initials, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          SizedBox(height: 8.h),
          Text(customer.name,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(customer.phone ?? 'لا يوجد رقم',
                  style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              if (customer.phone != null) ...[
                SizedBox(width: 4.w),
                Icon(Icons.copy, size: 14.sp, color: AppColors.outline),
              ],
            ],
          ),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: customer.totalDebt > 0 ? AppColors.error : AppColors.secondary,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: (customer.totalDebt > 0 ? AppColors.error : AppColors.secondary).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Text(
              '₪ ${customer.totalDebt.toStringAsFixed(2)} مستحق',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(height: 32.h),
          _buildActionRow(customer.id),
        ],
      ),
    );
  }

  Widget _buildActionRow(int customerId) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _actionButton(Icons.add, '+ دين', AppColors.error),
          SizedBox(width: 16.w),
          _actionButton(Icons.receipt_outlined, 'فاتورة', AppColors.primary),
          SizedBox(width: 16.w),
          _actionButton(Icons.payments_outlined, 'دفعة', AppColors.secondary, onTap: () {
            NavigationService.navigateTo(AppRoutes.paymentEntry, arguments: PaymentEntryArgs(customerId: customerId));
          }),
          SizedBox(width: 16.w),
          _actionButton(Icons.description_outlined, 'كشف', const Color(0xFF4D556B)),
          SizedBox(width: 16.w),
          _actionButton(Icons.chat_outlined, 'واتساب', const Color(0xFF25D366)),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color iconColor, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 64.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 20.sp),
            SizedBox(height: 4.h),
            Text(label, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
          ],
        ),
      ),
    );
  }

  // ---- دمج وعرض السجل الزمني ----

  Widget _buildCombinedTimeline(List<Invoice> invoices, List<Payment> payments) {
    if (invoices.isEmpty && payments.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Text('لا يوجد سجل حركات لهذا العميل', style: TextStyle(fontSize: 14.sp, color: AppColors.outline)),
        ),
      );
    }

    // 1. تحويل الفواتير والدفعات إلى نوع واحد
    List<CustomerTransaction> allTransactions = [];

    // إضافة الفواتير
    allTransactions.addAll(invoices.map((inv) => CustomerTransaction(
      id: inv.id,
      date: inv.date,
      amount: inv.totalAmount,
      type: TransactionType.invoice,
      title: (inv.status == 'دين' || inv.status == 'Debt') ? 'إضافة دين' : 'فاتورة جديدة',
      subtitle: 'فاتورة #${inv.id}',
      status: inv.status,
    )));

    // إضافة الدفعات
    allTransactions.addAll(payments.map((pay) => CustomerTransaction(
      id: pay.id,
      date: pay.date,
      amount: pay.amount,
      type: TransactionType.payment,
      title: 'تسجيل دفعة',
      subtitle: 'سند قبض #${pay.id}',
      status: pay.method,
    )));

    // 2. ترتيب الحركات تنازلياً (من الأحدث للأقدم)
    allTransactions.sort((a, b) => b.date.compareTo(a.date));

    // 3. تجميع الحركات حسب التاريخ
    final Map<String, List<CustomerTransaction>> grouped = {};
    for (final transaction in allTransactions) {
      final dateKey = _formatDateGroup(transaction.date);
      grouped.putIfAbsent(dateKey, () => []).add(transaction);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: grouped.entries.map((entry) {
          final label = entry.key;
          final items = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.outline)),
              SizedBox(height: 8.h),
              ...items.asMap().entries.map((e) {
                final isLast = e.key == items.length - 1 && entry.key == grouped.keys.last;
                return _timelineItem(e.value, isLast: isLast);
              }),
              SizedBox(height: 16.h),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _timelineItem(CustomerTransaction transaction, {bool isLast = false}) {
    final IconData icon;
    final Color color;
    final String amountText;

    // تحديد اللون والأيقونة بناءً على نوع الحركة (دفعة أو فاتورة)
    if (transaction.type == TransactionType.payment) {
      icon = Icons.arrow_upward;
      color = AppColors.secondary; // لون أخضر للدفعات
      amountText = '-₪${transaction.amount.toStringAsFixed(2)}';
    } else {
      if (transaction.status == 'دين' || transaction.status == 'Debt') {
        icon = Icons.add;
        color = AppColors.error; // لون أحمر للدين
      } else {
        icon = Icons.receipt;
        color = AppColors.primary; // لون أزرق للفاتورة النقدية
      }
      amountText = '₪${transaction.amount.toStringAsFixed(2)}';
    }

    final time = transaction.date.toString().length >= 16
        ? transaction.date.toString().substring(11, 16)
        : '';

    return InkWell(
      onTap: () {
        // نفتح تفاصيل الفاتورة فقط إذا كانت الحركة عبارة عن فاتورة
        if (transaction.type == TransactionType.invoice) {
          NavigationService.navigateTo(
            AppRoutes.invoicesDetails,
            arguments: InvoiceDetailsArgs(invoiceId: transaction.id),
          );
        }
      },
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 24.w,
              child: Column(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    margin: EdgeInsets.only(top: 8.h),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
                  SizedBox(height: 4.h),
                  Icon(icon, size: 14.sp, color: color),
                  if (!isLast)
                    Expanded(
                      child: Container(width: 1.w, color: AppColors.outlineVariant.withOpacity(0.5)),
                    ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.outlineVariant, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(transaction.title,
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                            Text(transaction.subtitle,
                                style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(amountText,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: color == AppColors.primary ? AppColors.onSurface : color)),
                            Text(time, style: TextStyle(fontSize: 11.sp, color: AppColors.outline)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      transaction.type == TransactionType.payment
                          ? 'طريقة الدفع: ${transaction.status}'
                          : 'حالة الفاتورة: ${transaction.status}',
                      style: TextStyle(fontSize: 12.sp, color: AppColors.outline),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateGroup(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);

    if (d == today) return 'اليوم';
    if (d == today.subtract(const Duration(days: 1))) return 'أمس';
    return '${date.day}/${date.month}/${date.year}';
  }
}