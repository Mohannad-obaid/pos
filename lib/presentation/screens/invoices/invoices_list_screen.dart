import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class InvoicesListScreen extends StatelessWidget {
  const InvoicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          _buildSummaryStrip(),
          _buildFilterTabs(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              children: [
                _buildInvoiceCard('#INV-0047', 'يوسف مصطفى', '₪85.00', 'اليوم، 10:45 ص', 'دين', AppColors.error),
                _buildInvoiceCard('#INV-0046', 'أحمد الحمدان', '₪32.00', 'أمس، 09:20 م', 'نقد', AppColors.secondary),
                _buildInvoiceCard('#INV-0045', 'سارة خالد', '₪120.00', 'أمس، 04:15 م', 'دين', AppColors.error),
                _buildInvoiceCard('#INV-0044', 'منى ريان', '₪45.00', '12 أكتوبر، 11:00 ص', 'نقد', AppColors.secondary),
                _buildInvoiceCard('#INV-0043', 'خالد عمر', '₪28.00', '11 أكتوبر، 08:30 م', 'ملغاة', AppColors.outline),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
      title: Text('الفواتير', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
      leading: IconButton(
        icon: Icon(Icons.arrow_forward, color: AppColors.primary),
        onPressed: () {},
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
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
                  Icon(Icons.expand_more, size: 16.sp, color: AppColors.onSurfaceVariant),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.search, color: AppColors.onSurfaceVariant),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSummaryStrip() {
    return SizedBox(
      height: 80.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        children: [
          _summaryCard('الإجمالي', '18 فاتورة', AppColors.primary),
          SizedBox(width: 8.w),
          _summaryCard('نقد', '₪1,240', AppColors.secondary),
          SizedBox(width: 8.w),
          _summaryCard('آجل', '₪980', AppColors.error),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String value, Color valueColor) {
    return Container(
      width: 120.w,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
          Text(value, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: valueColor)),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SizedBox(
      height: 48.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        children: [
          _filterChip('الكل', true),
          _filterChip('نقد', false),
          _filterChip('آجل/دين', false),
          _filterChip('ملغاة', false),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20.r),
        border: isSelected ? null : Border.all(color: AppColors.outlineVariant),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(String id, String name, String amount, String date, String status, Color statusColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
        // لمحاكاة border-l-[3px] مع مراعاة أن التطبيق RTL سنستخدم border يمين
      ),
      child: Stack(
        children: [
          Positioned(
            right: -16.w, // إرجاعها لحافة الـ Container اليمنى
            top: -16.h,
            bottom: -16.h,
            child: Container(width: 3.w, color: statusColor),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(id, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
                  Text(date, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                  Text(amount, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('3 منتجات', style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Text(status, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: statusColor)),
                        SizedBox(width: 4.w),
                        Icon(status == 'نقد' ? Icons.check : status == 'دين' ? Icons.warning : Icons.close, size: 14.sp, color: statusColor),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}