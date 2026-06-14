// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/theme/app_colors.dart';
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});
//
//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   bool _trackStock = true;
//   int _quantity = 12;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: _buildAppBar(context),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 120.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildBasicInfoSection(),
//                 SizedBox(height: 16.h),
//                 _buildBarcodeSection(),
//                 SizedBox(height: 16.h),
//                 _buildCategorySection(),
//                 SizedBox(height: 16.h),
//                 _buildStockSection(),
//               ],
//             ),
//           ),
//           _buildBottomActions(),
//         ],
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppColors.surface,
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: Text('إضافة منتج', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
//       actions: [
//         TextButton(
//           onPressed: () {},
//           child: Text('حفظ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
//         ),
//       ],
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1.0),
//         child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
//       ),
//     );
//   }
//
//   Widget _buildBasicInfoSection() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Column(
//         children: [
//           TextFormField(
//             decoration: InputDecoration(
//               labelText: 'اسم المنتج *',
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
//               errorText: 'مطلوب', // محاكاة لحالة الخطأ
//             ),
//           ),
//           SizedBox(height: 16.h),
//           TextFormField(
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: 'السعر *',
//               prefixIcon: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//                 child: Text('₪', style: TextStyle(fontSize: 20.sp, color: AppColors.primary, fontWeight: FontWeight.bold)),
//               ),
//               prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBarcodeSection() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('الباركود', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//           SizedBox(height: 8.h),
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'أدخل أو امسح الباركود',
//                     prefixIcon: Icon(Icons.qr_code, color: AppColors.outline),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8.w),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryContainer,
//                   foregroundColor: AppColors.onPrimaryContainer,
//                   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
//                 ),
//                 onPressed: () {},
//                 icon: Icon(Icons.qr_code_scanner, size: 20.sp),
//                 label: Text('مسح', style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategorySection() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('التصنيف', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//           SizedBox(height: 12.h),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 _categoryChip('مشروبات', isSelected: true),
//                 _categoryChip('معلبات'),
//                 _categoryChip('مخبوزات'),
//                 _categoryChip('ألبان'),
//                 ActionChip(
//                   label: Text('إضافة', style: TextStyle(color: AppColors.primary)),
//                   avatar: Icon(Icons.add, color: AppColors.primary, size: 16.sp),
//                   backgroundColor: Colors.transparent,
//                   side: BorderSide(color: AppColors.primary, style: BorderStyle.solid),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _categoryChip(String label, {bool isSelected = false}) {
//     return Container(
//       margin: EdgeInsets.only(left: 8.w),
//       child: ChoiceChip(
//         label: Text(label),
//         selected: isSelected,
//         selectedColor: AppColors.primary,
//         labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.onSurfaceVariant),
//         backgroundColor: Colors.transparent,
//         side: BorderSide(color: isSelected ? AppColors.primary : AppColors.outlineVariant),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//         onSelected: (val) {},
//       ),
//     );
//   }
//
//   Widget _buildStockSection() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('تتبع المخزون', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
//               Switch(
//                 value: _trackStock,
//                 activeColor: AppColors.primary,
//                 onChanged: (val) => setState(() => _trackStock = val),
//               ),
//             ],
//           ),
//           if (_trackStock) ...[
//             SizedBox(height: 16.h),
//             Row(
//               children: [
//                 Expanded(child: Text('الكمية الحالية', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant))),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.outlineVariant),
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.remove),
//                         onPressed: () => setState(() { if (_quantity > 0) _quantity--; }),
//                       ),
//                       SizedBox(
//                         width: 40.w,
//                         child: Text('$_quantity', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.add),
//                         onPressed: () => setState(() => _quantity++),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomActions() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: AppColors.surface.withOpacity(0.9),
//           border: Border(top: BorderSide(color: AppColors.outlineVariant)),
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: Colors.white,
//                   minimumSize: Size(double.infinity, 50.h),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
//                 ),
//                 onPressed: () {},
//                 child: Text('حفظ المنتج', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//               ),
//               SizedBox(height: 8.h),
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('إلغاء', style: TextStyle(fontSize: 16.sp, color: AppColors.onSurfaceVariant)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/presentation/screens/products/scanner_screen.dart';
import '../../../config/routes/navigation_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/product_controller.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  // 1. مفتاح النموذج للتحقق من صحة البيانات (Validation)
  final _formKey = GlobalKey<FormState>();

  // 2. متحكمات النصوص لإدخال البيانات
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _barcodeController = TextEditingController();

  // 3. متغيرات الحالة
  bool _trackStock = true;
  int _quantity = 12;
  String _selectedCategory = 'مشروبات';

  // قائمة مؤقتة للتصنيفات
  final List<String> _categories = ['مشروبات', 'معلبات', 'مخبوزات', 'ألبان','مسليات','حاجات', 'أخرى'];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  // 4. دالة الحفظ المرتبطة بقاعدة البيانات
  Future<void> _saveProduct() async {
    // التأكد من أن جميع الحقول المطلوبة ممتلئة بشكل صحيح
    if (_formKey.currentState!.validate()) {
      final success = await ref.read(productControllerProvider.notifier).addProduct(
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        barcode: _barcodeController.text.trim(),
        category: _selectedCategory,
        trackStock: _trackStock,
        stockQuantity: _trackStock ? _quantity : 0,
      );

      if (success && mounted) {
        NavigationService.showSnackBar('تم حفظ المنتج بنجاح!', type: SnackBarType.success);
        NavigationService.goBack(); // العودة إلى قائمة المنتجات بعد الحفظ
      } else if (!success && mounted) {
        NavigationService.showSnackBar('فشل الحفظ، قد يكون الباركود مكرراً', type: SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // مراقبة حالة التحميل لمنع الضغط المزدوج
    final isLoading = ref.watch(productControllerProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(isLoading),
      body: Stack(
        children: [
          Form(
            key: _formKey, // ربط النموذج
            child: SingleChildScrollView(
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
          ),
          _buildBottomActions(isLoading),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isLoading) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
        onPressed: () => NavigationService.goBack(),
      ),
      title: Text('إضافة منتج', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
      actions: [
        TextButton(
          onPressed: isLoading ? null : _saveProduct,
          child: isLoading
              ? SizedBox(width: 20.w, height: 20.w, child: const CircularProgressIndicator(strokeWidth: 2))
              : Text('حفظ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
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
            controller: _nameController,
            validator: (val) => val == null || val.isEmpty ? 'اسم المنتج مطلوب' : null,
            decoration: InputDecoration(
              labelText: 'اسم المنتج *',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _priceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (val) {
              if (val == null || val.isEmpty) return 'السعر مطلوب';
              if (double.tryParse(val) == null) return 'أدخل سعراً صحيحاً';
              return null;
            },
            decoration: InputDecoration(
              labelText: 'السعر *',
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text('₪', style: TextStyle(fontSize: 20.sp, color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
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
                  controller: _barcodeController,
                  validator: (val) => val == null || val.isEmpty ? 'الباركود مطلوب' : null,
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
                // --- التعديل يبدأ من هنا ---
                onPressed: () async {
                  // فتح شاشة الكاميرا وانتظار نتيجة المسح
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScannerScreen()),
                  );

                  // إذا عاد برقم (لم يضغط المستخدم زر الرجوع بدون مسح)
                  if (result != null && result is String) {
                    setState(() {
                      _barcodeController.text = result; // كتابة الرقم في الحقل
                    });
                  }
                },
                // --- التعديل ينتهي هنا ---
                icon: Icon(Icons.qr_code_scanner, size: 20.sp),
                label: const Text('مسح', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildBarcodeSection() {
  //   return Container(
  //     padding: EdgeInsets.all(16.w),
  //     decoration: BoxDecoration(
  //       color: AppColors.surfaceContainerLowest,
  //       borderRadius: BorderRadius.circular(12.r),
  //       border: Border.all(color: AppColors.outlineVariant),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('الباركود', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
  //         SizedBox(height: 8.h),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: TextFormField(
  //                 controller: _barcodeController,
  //                 validator: (val) => val == null || val.isEmpty ? 'الباركود مطلوب' : null,
  //                 decoration: InputDecoration(
  //                   hintText: 'أدخل أو امسح الباركود',
  //                   prefixIcon: Icon(Icons.qr_code, color: AppColors.outline),
  //                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(width: 8.w),
  //             ElevatedButton.icon(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: AppColors.primaryContainer,
  //                 foregroundColor: AppColors.onPrimaryContainer,
  //                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  //               ),
  //               onPressed: () {
  //                 // TODO: تفعيل الكاميرا لاحقاً لمسح الباركود
  //               },
  //               icon: Icon(Icons.qr_code_scanner, size: 20.sp),
  //               label: const Text('مسح', style: TextStyle(fontWeight: FontWeight.bold)),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
                ..._categories.map((cat) => _categoryChip(
                  label: cat,
                  isSelected: _selectedCategory == cat,
                  onSelected: (val) {
                    if (val) setState(() => _selectedCategory = cat);
                  },
                )),
                ActionChip(
                  label: Text('إضافة', style: TextStyle(color: AppColors.primary)),
                  avatar: Icon(Icons.add, color: AppColors.primary, size: 16.sp),
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: AppColors.primary, style: BorderStyle.solid),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  onPressed: () {
                    // فتح نافذة لإضافة تصنيف جديد
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryChip({required String label, required bool isSelected, required Function(bool) onSelected}) {
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
        onSelected: onSelected,
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
                        icon: const Icon(Icons.remove),
                        onPressed: () => setState(() { if (_quantity > 0) _quantity--; }),
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Text('$_quantity', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
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

  Widget _buildBottomActions(bool isLoading) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.9),
          border: Border(top: BorderSide(color: AppColors.outlineVariant)),
        ),
        child: SafeArea(
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                  ),
                  onPressed: isLoading ? null : _saveProduct,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('حفظ المنتج', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () => NavigationService.goBack(),
                  child: Text('إلغاء', style: TextStyle(fontSize: 16.sp, color: AppColors.onSurfaceVariant)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}