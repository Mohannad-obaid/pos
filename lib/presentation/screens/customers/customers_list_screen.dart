import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: AppColors.onPrimary, size: 28.sp),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilters(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 100.h),
              children: [
                _buildCustomerTile('أحمد الحمدان', '0599123456', 'أح', AppColors.errorContainer, AppColors.error, '₪850', 'مديون'),
                _buildCustomerTile('منى ريان', '0599789012', 'مر', AppColors.secondaryContainer, AppColors.secondary, '₪0', 'مسوّى'),
                _buildCustomerTile('يوسف مصطفى', '0598112233', 'يم', const Color(0xFFDAE2FD), const Color(0xFF4D556B), '₪2,100', 'تحذير'),
                _buildCustomerTile('سارة خالد', '0597334455', 'سخ', AppColors.errorContainer, AppColors.error, '₪320', 'مديون'),
                _buildCustomerTile('خالد عمر', '0599009988', 'خع', AppColors.secondaryContainer, AppColors.secondary, '₪0', 'مسوّى'),
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
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        'الزبائن',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add, color: AppColors.primary, size: 24.sp),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'ابحث بالاسم أو الهاتف...',
            hintStyle: TextStyle(color: AppColors.outline, fontSize: 16.sp),
            prefixIcon: Icon(Icons.search, color: AppColors.onSurfaceVariant, size: 20.sp),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _buildFilterChip('الكل', isSelected: true),
          SizedBox(width: 8.w),
          _buildFilterChip('مديونون'),
          SizedBox(width: 8.w),
          _buildFilterChip('مسددون'),
          SizedBox(width: 8.w),
          _buildFilterChip('تحذير'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20.r),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
            ),
          ),
          if (isSelected) ...[
            SizedBox(width: 4.w),
            Icon(Icons.check, color: AppColors.onPrimary, size: 16.sp),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomerTile(String name, String phone, String initials, Color avatarBg, Color statusColor, String amount, String statusText) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 21.r,
                backgroundColor: avatarBg,
                child: Text(
                  initials,
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: statusColor),
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  Text(phone, style: TextStyle(fontSize: 13.sp, color: AppColors.outline)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: statusColor)),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: statusColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}