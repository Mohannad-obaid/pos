import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  bool _trackStock = true;
  int _quantity = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 120.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBasicInfoSection(),
                SizedBox(height: 16.h),
                _buildBarcodeSection(),
                SizedBox(height: 16.h),
                _buildCategorySection(),
                SizedBox(height: 16.h),
                _buildStockSection(),
              ],
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('إضافة منتج', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('حفظ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'اسم المنتج *',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
              errorText: 'مطلوب', // محاكاة لحالة الخطأ
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'السعر *',
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text('₪', style: TextStyle(fontSize: 20.sp, color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الباركود', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'أدخل أو امسح الباركود',
                    prefixIcon: Icon(Icons.qr_code, color: AppColors.outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimaryContainer,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                ),
                onPressed: () {},
                icon: Icon(Icons.qr_code_scanner, size: 20.sp),
                label: Text('مسح', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('التصنيف', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
          SizedBox(height: 12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _categoryChip('مشروبات', isSelected: true),
                _categoryChip('معلبات'),
                _categoryChip('مخبوزات'),
                _categoryChip('ألبان'),
                ActionChip(
                  label: Text('إضافة', style: TextStyle(color: AppColors.primary)),
                  avatar: Icon(Icons.add, color: AppColors.primary, size: 16.sp),
                  backgroundColor: Colors.transparent,
                  side: BorderSide(color: AppColors.primary, style: BorderStyle.solid),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryChip(String label, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.onSurfaceVariant),
        backgroundColor: Colors.transparent,
        side: BorderSide(color: isSelected ? AppColors.primary : AppColors.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        onSelected: (val) {},
      ),
    );
  }

  Widget _buildStockSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('تتبع المخزون', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
              Switch(
                value: _trackStock,
                activeColor: AppColors.primary,
                onChanged: (val) => setState(() => _trackStock = val),
              ),
            ],
          ),
          if (_trackStock) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(child: Text('الكمية الحالية', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant))),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => setState(() { if (_quantity > 0) _quantity--; }),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Text('$_quantity', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.9),
          border: Border(top: BorderSide(color: AppColors.outlineVariant)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                ),
                onPressed: () {},
                child: Text('حفظ المنتج', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8.h),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('إلغاء', style: TextStyle(fontSize: 16.sp, color: AppColors.onSurfaceVariant)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}