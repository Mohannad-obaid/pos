import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/providers/cart_provider.dart';
import 'package:pos/providers/checkout_controller.dart';
import 'package:pos/providers/repository_providers.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/routes/navigation_service.dart';
import '../../../core/theme/app_colors.dart';

enum PaymentMethod { cash, debt }

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.debt;
  Customer? _selectedCustomer; // لتخزين الزبون المختار للدين

  @override
  Widget build(BuildContext context) {
    // 1. مراقبة حالة عملية الدفع (للتحميل والأخطاء)
    final checkoutState = ref.watch(checkoutControllerProvider);
    final isLoading = checkoutState.isLoading;

    // 2. الاستماع للنجاح أو الفشل عبر ref.listen
    ref.listen(checkoutControllerProvider, (previous, next) {
      if (next is AsyncData && next.value == null) {
        // null تعني أن العملية نجحت بناءً على الكود الذي كتبناه
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تمت عملية الدفع بنجاح!'), backgroundColor: Colors.green),
        );
        NavigationService.navigateAndRemoveUntil(AppRoutes.dashboard); // العودة للرئيسية
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: ${next.error}'), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderSummary(),
                  SizedBox(height: 24.h),
                  _buildPaymentMethods(),
                  SizedBox(height: 24.h),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _selectedMethod == PaymentMethod.debt
                        ? _buildDebtSection()
                        : _buildCashSection(),
                  ),
                ],
              ),
            ),
          ),
          _buildConfirmButton(isLoading),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
      title: Text('الدفع', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildOrderSummary() {
    // 3. قراءة إجمالي السلة وعدد العناصر
    final totalAmount = ref.watch(cartTotalProvider);
    final itemsCount = ref.watch(cartItemsCountProvider);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ملخص الطلب', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text('$itemsCount قطع', style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.outlineVariant),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('الإجمالي', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
              Text('₪ ${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('اختر طريقة الدفع', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _methodCard(
                method: PaymentMethod.cash,
                icon: Icons.payments_outlined,
                label: 'نقداً',
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _methodCard(
                method: PaymentMethod.debt,
                icon: Icons.list_alt_outlined,
                label: 'دين',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _methodCard({required PaymentMethod method, required IconData icon, required String label}) {
    bool isSelected = _selectedMethod == method;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 100.h,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: Icon(Icons.check, color: Colors.white, size: 12.sp),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32.sp, color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant),
                SizedBox(height: 8.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebtSection() {
    // 4. جلب قائمة الزبائن لاختيارهم عند الدين
    final customersAsync = ref.watch(customersListProvider);

    return Column(
      key: const ValueKey('debt'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('اختر الزبون', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),

        customersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('خطأ في جلب الزبائن', style: TextStyle(color: AppColors.error)),
          data: (customers) {
            if (customers.isEmpty) {
              return Text('لا يوجد زبائن، قم بإضافة زبون أولاً.', style: TextStyle(color: AppColors.onSurfaceVariant));
            }

            // في تطبيق حقيقي يمكن استخدام Dropdown أو BottomSheet
            // هنا نستخدم قائمة أفقية للسرعة والمحاكاة
            return Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: customers.map((customer) {
                final isSelected = _selectedCustomer?.id == customer.id;
                return ChoiceChip(
                  label: Text(customer.name, style: TextStyle(fontSize: 14.sp)),
                  selected: isSelected,
                  selectedColor: AppColors.primaryContainer.withOpacity(0.2),
                  side: BorderSide(color: isSelected ? AppColors.primary : AppColors.outlineVariant),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCustomer = selected ? customer : null;
                    });
                  },
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCashSection() {
    return Column(
      key: const ValueKey('cash'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المبلغ المستلم ₪', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),
        TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: '0.00',
            suffixIcon: Icon(Icons.payments_outlined, color: AppColors.outline),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: AppColors.outlineVariant)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: AppColors.primary, width: 2)),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(bool isLoading) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: SafeArea(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF22C55E),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          ),
          onPressed: isLoading ? null : () async {
            // التحقق من اختيار العميل في حالة الدين
            if (_selectedMethod == PaymentMethod.debt && _selectedCustomer == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('الرجاء اختيار الزبون أولاً')),
              );
              return;
            }

            // 5. استدعاء الـ Controller لتنفيذ الدفع
            await ref.read(checkoutControllerProvider.notifier).processCheckout(
              isDebt: _selectedMethod == PaymentMethod.debt,
              customerId: _selectedCustomer?.id, // يمرر null في حالة الكاش
            );
          },
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تأكيد وإنهاء', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(width: 8.w),
              Icon(Icons.check_circle, size: 24.sp),
            ],
          ),
        ),
      ),
    );
  }
}