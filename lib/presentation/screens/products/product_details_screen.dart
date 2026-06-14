import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart'; // مسار قاعدة البيانات الحقيقية
import '../../../providers/repository_providers.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final int productId; // استقبال معرف المنتج الحقيقي عند فتح الشاشة

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // جلب بيانات المنتج الحقيقية من قاعدة البيانات عبر الـ Provider الخاص بك
    final productAsync = ref.watch(productByIdProvider(productId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('حدث خطأ في تحميل المنتج: $err')),
        data: (product) {
          if (product == null) {
            return const Center(child: Text('المنتج غير موجود في قاعدة البيانات'));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                _buildHeroSection(product),
                SizedBox(height: 24.h),
                _buildBarcodeSection(context, product.barcode),
                SizedBox(height: 24.h),
                _buildInventoryStats(product),
                SizedBox(height: 24.h),
               // _buildActionButtons(context, ref, product),
                SizedBox(height: 32.h),
                _buildHistorySection(context, ref, product.id),
                SizedBox(height: 80.h), // مساحة أمان للـ BottomNavBar
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant, height: 1.0),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.onSurfaceVariant),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'تفاصيل المنتج',
        style: TextStyle(
            color: AppColors.onSurface,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppColors.onSurfaceVariant),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeroSection(Product product) {
    return Column(
      children: [
        // Container(
        //   width: double.infinity,
        //   height: 250.h,
        //   decoration: BoxDecoration(
        //     color: AppColors.surfaceContainerLowest,
        //     borderRadius: BorderRadius.circular(12.r),
        //     border: Border.all(color: AppColors.outlineVariant),
        //   ),
        //   child: Center(
        //     child: Icon(Icons.inventory_2_outlined, size: 80.sp, color: AppColors.outlineVariant),
        //   ),
        // ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            product.category, // تصنيف المنتج الحقيقي
            style: TextStyle(
                color: AppColors.onSecondaryFixedVariant,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          product.name, // اسم المنتج الحقيقي
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface),
        ),
        SizedBox(height: 4.h),
        Text(
          '₪${product.price.toStringAsFixed(2)}', // السعر الحقيقي
          style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildBarcodeSection(BuildContext context, String barcode) {
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
              Text(
                'الباركود',
                style: TextStyle(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              ),
              TextButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: barcode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم نسخ الباركود إلى الحافظة')),
                  );
                },
                icon: const Icon(Icons.copy, size: 16, color: AppColors.primary),
                label: const Text(
                  'نسخ',
                  style: TextStyle(color: AppColors.primary, fontSize: 14),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                30,
                    (index) => Container(
                  width: (index % 4 == 0) ? 4.0.w : (index % 3 == 0) ? 2.0.w : 1.0.w,
                  margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                  color: AppColors.onSurface.withOpacity(0.8),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            barcode, // رقم الباركود الحقيقي
            style: TextStyle(
                letterSpacing: 4.0,
                fontSize: 14.sp,
                fontFamily: 'monospace',
                color: AppColors.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryStats(Product product) {
    return Row(
      children: [
        Expanded(child: _buildStatCard('المخزون الحالي', product.trackStock ? '${product.stockQuantity} قطعة' : 'غير متتبع')),
        SizedBox(width: 8.w),
        Expanded(child: _buildStatCard('السعر', '₪${product.price}')), // مثال افتراضي للتكلفة //(product.price * 0.7).toStringAsFixed(2)}')
        SizedBox(width: 8.w),
        Expanded(child: _buildStatCard('تاريخ الإضافة', '12 مايو 2026', isSmallValue: true)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, {bool isSmallValue = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
                fontSize: isSmallValue ? 13.sp : 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, Product product) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // توجيه لشاشة التعديل لاحقاً
            },
            icon: const Icon(Icons.edit, size: 18),
            label: const Text('تعديل المنتج'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.outline),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // تنفيذ عملية الحذف عبر الـ Repository أو الـ Controller لاحقاً
            },
            icon: const Icon(Icons.delete, size: 18),
            label: const Text('حذف'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: BorderSide(color: AppColors.error.withOpacity(0.3)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context, WidgetRef ref, int productId) {
    // استدعاء السجل الحقيقي من قاعدة البيانات
    final historyAsync = ref.watch(productSalesHistoryProvider(productId));

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'سجل الحركة',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('عرض الكل', style: TextStyle(color: AppColors.primary)),
            )
          ],
        ),
        SizedBox(height: 16.h),

        historyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('خطأ في جلب السجل', style: TextStyle(color: AppColors.error))),
          data: (sales) {
            if (sales.isEmpty) {
              return Center(
                child: Text('لا توجد حركات سابقة لهذا المنتج', style: TextStyle(color: AppColors.outline)),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sales.length > 5 ? 5 : sales.length, // عرض آخر 5 حركات كحد أقصى هنا
              itemBuilder: (context, index) {
                final sale = sales[index];

                // تنسيق التاريخ ليطابق تصميمك بدقة
                final months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
                final String dateStr = "${sale.date.day} ${months[sale.date.month - 1]} ${sale.date.year}";

                // تحديد نوع الحركة بناءً على حالة الفاتورة
                final bool isCancelled = sale.status == 'ملغاة' || sale.status == 'Cancelled' || sale.status == 'cancelled';

                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _buildHistoryItem(
                    icon: isCancelled ? Icons.assignment_return : Icons.shopping_cart,
                    iconColor: isCancelled ? AppColors.outline : AppColors.primary,
                    title: isCancelled ? 'فاتورة ملغاة (استرجاع)' : 'عملية بيع',
                    date: dateStr,
                    amount: isCancelled ? '+${sale.quantity}' : '-${sale.quantity}',
                    amountColor: isCancelled ? AppColors.secondary : AppColors.onSurface,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

// دالة التصميم الخاصة بك (لم يتم المساس بها نهائياً)
  Widget _buildHistoryItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String date,
    required String amount,
    required Color amountColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface)),
                  Text(date, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: amountColor),
          )
        ],
      ),
    );
  }

  // Widget _buildHistorySection() {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'سجل الحركة',
  //             style: TextStyle(
  //                 fontSize: 20.sp,
  //                 fontWeight: FontWeight.w600,
  //                 color: AppColors.onSurface),
  //           ),
  //           TextButton(
  //             onPressed: () {},
  //             child: const Text('عرض الكل', style: TextStyle(color: AppColors.primary)),
  //           )
  //         ],
  //       ),
  //       SizedBox(height: 16.h),
  //       _buildHistoryItem(
  //         icon: Icons.add_box,
  //         iconColor: AppColors.secondary,
  //         title: 'إضافة مخزون',
  //         date: '15 مايو 2026',
  //         amount: '+12',
  //         amountColor: AppColors.secondary,
  //       ),
  //       SizedBox(height: 8.h),
  //       _buildHistoryItem(
  //         icon: Icons.shopping_cart,
  //         iconColor: AppColors.primary,
  //         title: 'عملية بيع',
  //         date: '14 مايو 2026',
  //         amount: '-2',
  //         amountColor: AppColors.onSurface,
  //       ),
  //       SizedBox(height: 8.h),
  //       _buildHistoryItem(
  //         icon: Icons.shopping_cart,
  //         iconColor: AppColors.primary,
  //         title: 'عملية بيع',
  //         date: '14 مايو 2026',
  //         amount: '-1',
  //         amountColor: AppColors.onSurface,
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildHistoryItem({
  //   required IconData icon,
  //   required Color iconColor,
  //   required String title,
  //   required String date,
  //   required String amount,
  //   required Color amountColor,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.all(16.w),
  //     decoration: BoxDecoration(
  //       color: AppColors.surfaceContainerLowest,
  //       borderRadius: BorderRadius.circular(12.r),
  //       border: Border.all(color: AppColors.outlineVariant),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               width: 40.w,
  //               height: 40.w,
  //               decoration: BoxDecoration(
  //                 color: iconColor.withOpacity(0.1),
  //                 shape: BoxShape.circle,
  //               ),
  //               child: Icon(icon, color: iconColor, size: 20.sp),
  //             ),
  //             SizedBox(width: 16.w),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(title,
  //                     style: TextStyle(
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.w600,
  //                         color: AppColors.onSurface)),
  //                 Text(date, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
  //               ],
  //             ),
  //           ],
  //         ),
  //         Text(
  //           amount,
  //           style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: amountColor),
  //         )
  //       ],
  //     ),
  //   );
  // }
}