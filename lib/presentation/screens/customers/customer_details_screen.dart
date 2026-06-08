import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderProfile(),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'سجل المعاملات',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
              ),
            ),
            SizedBox(height: 16.h),
            _buildTransactionTimeline(),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF0F7FF),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: AppColors.onSurfaceVariant, size: 24.sp),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeaderProfile() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF0F7FF),
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.primary,
            child: Text('YM', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          SizedBox(height: 8.h),
          Text('يوسف مصطفى', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('0598112233', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              SizedBox(width: 4.w),
              Icon(Icons.copy, size: 14.sp, color: AppColors.outline),
            ],
          ),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [BoxShadow(color: AppColors.error.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
            ),
            child: Text('₪ 1,250 مستحق', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          SizedBox(height: 32.h),
          _buildActionRow(),
        ],
      ),
    );
  }

  Widget _buildActionRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _actionButton(Icons.add, '+ دين', AppColors.error),
          SizedBox(width: 16.w),
          _actionButton(Icons.receipt_outlined, 'فاتورة', AppColors.primary),
          SizedBox(width: 16.w),
          _actionButton(Icons.payments_outlined, 'دفعة', AppColors.secondary),
          SizedBox(width: 16.w),
          _actionButton(Icons.description_outlined, 'كشف', const Color(0xFF4D556B)),
          SizedBox(width: 16.w),
          _actionButton(Icons.chat_outlined, 'واتساب', const Color(0xFF25D366)),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color iconColor) {
    return Container(
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
    );
  }

  Widget _buildTransactionTimeline() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('اليوم', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.outline)),
          SizedBox(height: 8.h),
          _timelineItem(Icons.add, AppColors.error, 'إضافة دين', 'رصيد افتتاحي', '+₪400', '10:30 ص', 'الرصيد: ₪1,250', isLast: true),
          SizedBox(height: 16.h),
          Text('أمس', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.outline)),
          SizedBox(height: 8.h),
          _timelineItem(Icons.arrow_upward, AppColors.secondary, 'تسجيل دفعة', 'دفعة نقدية', '-₪200', '04:15 م', 'الرصيد: ₪850'),
          _timelineItem(Icons.receipt, AppColors.primary, 'فاتورة جديدة', 'بضاعة منوعة', '₪300', '11:00 ص', 'الرصيد: ₪1,050', isLast: true),
        ],
      ),
    );
  }

  Widget _timelineItem(IconData icon, Color color, String title, String subtitle, String amount, String time, String balance, {bool isLast = false}) {
    return IntrinsicHeight(
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
                if (!isLast) Expanded(child: Container(width: 1.w, color: AppColors.outlineVariant.withValues(alpha: 0.5))),
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
                          Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                          Text(subtitle, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(amount, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: color == AppColors.primary ? AppColors.onSurface : color)),
                          Text(time, style: TextStyle(fontSize: 11.sp, color: AppColors.outline)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(balance, style: TextStyle(fontSize: 12.sp, color: AppColors.outline)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}