import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

enum PaymentMethod { cash, debt }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.debt;

  @override
  Widget build(BuildContext context) {
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
          _buildConfirmButton(),
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
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: AppColors.onSurfaceVariant),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildOrderSummary() {
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
                child: Text('4 قطع', style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'كولا، خبز تنور، شيبس، عصير طبيعي...',
            style: TextStyle(fontSize: 13.sp, color: AppColors.outline, height: 1.5),
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.outlineVariant),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('الإجمالي', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
              Text('₪ 30.00', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
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
    return Column(
      key: const ValueKey('debt'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('اختر الزبون', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.primaryFixed,
                    child: Icon(Icons.person, color: AppColors.primaryFixedDim),
                  ),
                  SizedBox(width: 12.w),
                  Text('أحمد الحمدان', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                ],
              ),
              Icon(Icons.expand_more, color: AppColors.outline),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            _quickCustomerChip('ياسين'),
            _quickCustomerChip('منى'),
            _quickCustomerChip('سارة'),
            ActionChip(
              label: Text('+ زبون جديد', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14.sp)),
              backgroundColor: Colors.white,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }

  Widget _quickCustomerChip(String name) {
    return ActionChip(
      label: Text(name, style: TextStyle(fontSize: 14.sp)),
      backgroundColor: Colors.transparent,
      side: BorderSide(color: AppColors.outlineVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      onPressed: () {},
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
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: AppColors.outlineVariant)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide(color: AppColors.primary, width: 2)),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF22C55E).withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الباقي:', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF22C55E))),
              Text('₪ 0.00', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF22C55E))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: SafeArea(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF22C55E), // Custom Success Color
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            elevation: 4,
          ),
          onPressed: () {},
          child: Row(
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