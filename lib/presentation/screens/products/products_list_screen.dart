import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 100.h),
              children: [
                _buildProductItem(
                  title: 'كولا 330ml',
                  category: 'مشروبات',
                  barcode: '4580123456',
                  price: '₪5.50',
                  icon: Icons.inventory_2_outlined,
                  isAvailable: true,
                ),
                _buildProductItem(
                  title: 'خبز تنور',
                  category: 'مخبوزات',
                  barcode: '7890123456',
                  price: '₪3.00',
                  icon: Icons.bakery_dining_outlined,
                  isAvailable: true,
                ),
                _buildProductItem(
                  title: 'ماء 1.5L',
                  category: 'مشروبات',
                  barcode: '1234567890',
                  price: '₪2.50',
                  icon: Icons.water_drop_outlined,
                  isAvailable: true,
                ),
                _buildProductItem(
                  title: 'شيبس',
                  category: 'أخرى',
                  barcode: '9876543210',
                  price: '₪4.00',
                  icon: Icons.fastfood_outlined,
                  isAvailable: true,
                ),
                _buildProductItem(
                  title: 'حليب',
                  category: 'أخرى',
                  barcode: '5432109876',
                  price: '₪8.00',
                  icon: Icons.egg_alt_outlined,
                  isAvailable: false,
                ),
              ],
            ),
          ),
        ],
      ),
      // زر مسح الباركود العائم
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: SizedBox(
          width: 250.w,
          height: 48.h,
          child: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: AppColors.primary,
            elevation: 4,
            icon: Icon(Icons.qr_code_scanner, color: AppColors.onPrimary),
            label: Text('مسح باركود', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onPrimary)),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        'المنتجات',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColors.onSurfaceVariant),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.add, color: AppColors.primary),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ابحث عن منتج أو باركود...',
                  hintStyle: TextStyle(fontSize: 16.sp, color: AppColors.outline),
                  prefixIcon: Icon(Icons.search, color: AppColors.outline),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Filter Chips
          SizedBox(
            height: 36.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _buildFilterChip('الكل', isSelected: true),
                _buildFilterChip('مشروبات'),
                _buildFilterChip('معلبات'),
                _buildFilterChip('مخبوزات'),
                _buildFilterChip('أخرى'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildProductItem({
    required String title,
    required String category,
    required String barcode,
    required String price,
    required IconData icon,
    required bool isAvailable,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          // Icon Box
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: AppColors.outline, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface), overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(category, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColors.onSecondaryContainer)),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.qr_code, size: 14.sp, color: AppColors.outline),
                    SizedBox(width: 4.w),
                    Text(barcode, style: TextStyle(fontSize: 14.sp, color: AppColors.outline, letterSpacing: 1.1)),
                  ],
                ),
              ],
            ),
          ),
          // Price and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.primary)),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(isAvailable ? 'متوفر' : 'نفد', style: TextStyle(fontSize: 11.sp, color: AppColors.onSurfaceVariant)),
                  SizedBox(width: 4.w),
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: isAvailable ? const Color(0xFF10B981) : AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Icon(Icons.more_vert, color: AppColors.outline, size: 20.sp),
        ],
      ),
    );
  }
}