import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class PaymentsHistoryScreen extends StatelessWidget {
  const PaymentsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: TabBarView(
          children: [
            _buildHistoryTab(),
            _buildNewPaymentTab(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
      title: Text('DaynPay', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppColors.onSurfaceVariant),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: AppColors.onSurfaceVariant),
          onPressed: () {},
        ),
      ],
      bottom: TabBar(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.onSurfaceVariant,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3.h,
        labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'سجل الدفعات'),
          Tab(text: 'تسجيل دفعة جديدة'),
        ],
      ),
    );
  }

  // --- التبويب الأول: سجل الدفعات ---
  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 100.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [BoxShadow(color: AppColors.secondary.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₪ 450 مُحصَّل اليوم', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                  Icon(Icons.analytics_outlined, color: Colors.white, size: 28.sp),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                _paymentTile('يوسف مصطفى', 'ي', 'اليوم، 10:15 ص • نقداً', '+₪ 200', 'دفعة الحساب'),
                _paymentTile('أحمد الحمدان', 'أ', 'اليوم، 09:30 ص • تحويل', '+₪ 50', '-'),
                _paymentTile('سارة خالد', 'س', 'أمس، 04:20 م • نقداً', '+₪ 120', 'قسط شهري'),
                _paymentTile('منى ريان', 'م', '12 يونيو، 11:00 ص • تحويل', '+₪ 80', 'دفعة جزئية'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentTile(String name, String initial, String details, String amount, String note) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.secondaryContainer,
                child: Text(initial, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.secondary)),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  Text(details, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.secondary)),
              Text(note, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }

  // --- التبويب الثاني: تسجيل دفعة جديدة ---
  Widget _buildNewPaymentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Warning Banner
          Container(
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.only(bottom: 24.h),
            decoration: BoxDecoration(
              color: AppColors.errorContainer,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20.sp),
                SizedBox(width: 8.w),
                Text('المبلغ يتجاوز الدين الحالي (₪350)', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurface)),
              ],
            ),
          ),

          // Customer Selector
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
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
                      child: Text('ي', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 12.w),
                    Text('يوسف مصطفى', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.onSurfaceVariant),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Amount Input
          Text('قيمة الدفعة', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.primary, width: 2.h))),
            child: Row(
              children: [
                Text('₪', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: '400',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Date Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('تاريخ الدفعة', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Row(
                  children: [
                    Text('اليوم', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    SizedBox(width: 8.w),
                    Icon(Icons.calendar_today, size: 16.sp, color: AppColors.onSurfaceVariant),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Method Selector
          Text('طريقة الدفع', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _paymentMethodBtn('نقداً', Icons.check, true)),
              SizedBox(width: 8.w),
              Expanded(child: _paymentMethodBtn('تحويل بنكي', null, false)),
              SizedBox(width: 8.w),
              Expanded(child: _paymentMethodBtn('دفع إلكتروني', null, false)),
            ],
          ),
          SizedBox(height: 24.h),

          // Note Field
          Text('ملاحظة (اختياري)', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
          SizedBox(height: 8.h),
          TextField(
            decoration: InputDecoration(
              hintText: 'اكتب ملاحظة هنا...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: AppColors.outlineVariant)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: AppColors.outlineVariant)),
            ),
          ),
          SizedBox(height: 32.h),

          // Save Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 56.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            onPressed: () {},
            icon: Icon(Icons.save_outlined),
            label: Text('سجّل الدفعة', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodBtn(String label, IconData? icon, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondaryContainer : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: isSelected ? AppColors.secondary : AppColors.outlineVariant),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16.sp, color: AppColors.onSecondaryContainer),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.onSecondaryContainer : AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}