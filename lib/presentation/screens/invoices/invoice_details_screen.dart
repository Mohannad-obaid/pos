// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/theme/app_colors.dart';
//
// class InvoiceDetailsScreen extends StatelessWidget {
//   const InvoiceDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: _buildAppBar(context),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 100.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _buildStatusBadge(),
//             SizedBox(height: 24.h),
//             _buildCustomerCard(),
//             SizedBox(height: 16.h),
//             _buildMetaInfoGrid(),
//             SizedBox(height: 24.h),
//             _buildDigitalReceipt(),
//             SizedBox(height: 24.h),
//             _buildActionButtons(),
//           ],
//         ),
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
//       title: Text('#INV-0047', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.share_outlined, color: AppColors.onSurface),
//           onPressed: () {},
//         ),
//       ],
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1.0),
//         child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
//       ),
//     );
//   }
//
//   Widget _buildStatusBadge() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
//       decoration: BoxDecoration(
//         color: AppColors.errorContainer,
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20.sp),
//           SizedBox(width: 8.w),
//           Text('دين', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.error)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCustomerCard() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 24.r,
//                 backgroundColor: AppColors.primaryContainer.withOpacity(0.1),
//                 child: Icon(Icons.person, color: AppColors.primary), // Placeholder
//               ),
//               SizedBox(width: 16.w),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('يوسف مصطفى', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
//                   Text('059-XXXXXXX', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
//                 ],
//               ),
//             ],
//           ),
//           InkWell(
//             onTap: () {},
//             child: Row(
//               children: [
//                 Text('عرض الملف', style: TextStyle(fontSize: 12.sp, color: AppColors.primary, fontWeight: FontWeight.bold)),
//                 Icon(Icons.arrow_forward_ios, size: 12.sp, color: AppColors.primary),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMetaInfoGrid() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       childAspectRatio: 2.5,
//       mainAxisSpacing: 12.h,
//       crossAxisSpacing: 12.w,
//       children: [
//         _metaInfoBox('التاريخ', '٠١ يونيو ٢٠٢٥'),
//         _metaInfoBox('الوقت', '١٤:٣٢'),
//         _metaInfoBox('وسيلة الدفع', 'دين'),
//         _metaInfoBox('المتجر', 'متجر محمد'),
//       ],
//     );
//   }
//
//   Widget _metaInfoBox(String title, String value) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLow,
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(title, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant.withOpacity(0.7))),
//           Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDigitalReceipt() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.outlineVariant),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const _DashedLine(),
//           SizedBox(height: 16.h),
//           Text('المنتجات', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
//           SizedBox(height: 16.h),
//           _receiptItem('كولا 330ml', '3 × ₪5.50', '₪16.50'),
//           _receiptItem('خبز تنور', '1 × ₪3.00', '₪3.00'),
//           _receiptItem('شيبس', '2 × ₪4.00', '₪8.00'),
//           _receiptItem('ماء 1.5L', '1 × ₪2.50', '₪2.50'),
//           SizedBox(height: 16.h),
//           const _DashedLine(),
//           SizedBox(height: 16.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('المجموع الفرعي', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
//               Text('₪30.00', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('الضريبة (0%)', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
//               Text('₪0.00', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           const _DashedLine(),
//           SizedBox(height: 16.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('الإجمالي', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
//               Text('₪ 30.00', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primaryContainer)),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           const _DashedLine(),
//         ],
//       ),
//     );
//   }
//
//   Widget _receiptItem(String name, String qtyAndPrice, String total) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 12.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
//               Text(qtyAndPrice, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
//             ],
//           ),
//           Text(total, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButtons() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       mainAxisSpacing: 12.h,
//       crossAxisSpacing: 12.w,
//       childAspectRatio: 3,
//       children: [
//         _actionBtn(Icons.print_outlined, 'طباعة', AppColors.onSurface, AppColors.surfaceContainerHigh),
//         _actionBtn(Icons.share_outlined, 'مشاركة', AppColors.onSurface, AppColors.surfaceContainerHigh),
//         _actionBtn(Icons.content_copy_outlined, 'نسخ', AppColors.onSurface, AppColors.surfaceContainerHigh),
//         _actionBtn(Icons.cancel_outlined, 'إلغاء الفاتورة', AppColors.error, AppColors.errorContainer.withOpacity(0.2)),
//       ],
//     );
//   }
//
//   Widget _actionBtn(IconData icon, String label, Color textColor, Color bgColor) {
//     return InkWell(
//       onTap: () {},
//       borderRadius: BorderRadius.circular(12.r),
//       child: Container(
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: textColor, size: 20.sp),
//             SizedBox(width: 8.w),
//             Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: textColor)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ويدجت الخط المتقطع للإيصال
// class _DashedLine extends StatelessWidget {
//   const _DashedLine();
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         final boxWidth = constraints.constrainWidth();
//         const dashWidth = 6.0;
//         const dashHeight = 1.0;
//         final dashCount = (boxWidth / (2 * dashWidth)).floor();
//         return Flex(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           direction: Axis.horizontal,
//           children: List.generate(dashCount, (_) {
//             return SizedBox(
//               width: dashWidth,
//               height: dashHeight,
//               child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.outlineVariant)),
//             );
//           }),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart'; // مسار قاعدة البيانات
import '../../../providers/invoice_controller.dart';
import '../../../providers/repository_providers.dart';

class InvoiceDetailsScreen extends ConsumerWidget {
  final int invoiceId; // نستقبل رقم الفاتورة عند فتح الشاشة

  const InvoiceDetailsScreen({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. جلب بيانات الفاتورة الأساسية
    final invoiceAsync = ref.watch(invoiceByIdProvider(invoiceId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context, invoiceId),
      body: invoiceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('خطأ في تحميل الفاتورة: $err')),
        data: (invoice) {
          if (invoice == null)
            return const Center(child: Text('الفاتورة غير موجودة'));

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 24.h,
              bottom: 100.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildStatusBadge(invoice.status),
                SizedBox(height: 24.h),
                // 2. تمرير customerId لجلب بيانات العميل
                _buildCustomerCard(ref, invoice.customerId),
                SizedBox(height: 16.h),
                _buildMetaInfoGrid(invoice),
                SizedBox(height: 24.h),
                // 3. تمرير الفاتورة لجلب وبناء الإيصال الرقمي (المنتجات)
                _buildDigitalReceipt(ref, invoice),
                SizedBox(height: 24.h),
                _buildActionButtons(context, ref, invoice),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, int id) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        '#INV-${id.toString().padLeft(4, '0')}',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share_outlined, color: AppColors.onSurface),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.outlineVariant.withOpacity(0.5),
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    // تحديد الألوان والنصوص بناءً على حالة الفاتورة الحقيقية بنفس تنسيقك
    Color bgColor = AppColors.errorContainer;
    Color textColor = AppColors.error;
    IconData icon = Icons.warning_amber_rounded;
    String statusText = status;

    if (status == 'نقد' || status == 'Cash') {
      bgColor = AppColors.secondary.withOpacity(0.15);
      textColor = AppColors.secondary;
      icon = Icons.check_circle_outline;
      statusText = 'نقد';
    } else if (status == 'ملغاة' || status == 'Cancelled') {
      bgColor = AppColors.surfaceContainerHigh;
      textColor = AppColors.outline;
      icon = Icons.cancel_outlined;
      statusText = 'ملغاة';
    } else {
      statusText = 'دين';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(WidgetRef ref, int? customerId) {
    if (customerId == null) {
      // حالة زبون نقدي (بدون حساب مسجل)
      return _customerContainer(
        name: 'زبون نقدي',
        phone: 'غير مسجل',
        showProfileLink: false,
      );
    }

    // جلب بيانات العميل الحقيقي
    final customerAsync = ref.watch(customerByIdProvider(customerId));

    return customerAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => _customerContainer(
        name: 'عميل غير معروف',
        phone: '-',
        showProfileLink: false,
      ),
      data: (customer) {
        if (customer == null)
          return _customerContainer(
            name: 'زبون نقدي',
            phone: 'غير مسجل',
            showProfileLink: false,
          );
        return _customerContainer(
          name: customer.name,
          phone: customer.phone ?? 'لا يوجد رقم',
          showProfileLink: true,
        );
      },
    );
  }

  // نفس تصميمك تماماً تم فصله في دالة مساعدة لتسهيل الاستخدام
  Widget _customerContainer({
    required String name,
    required String phone,
    required bool showProfileLink,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
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
                backgroundColor: AppColors.primaryContainer.withOpacity(0.1),
                child: Icon(Icons.person, color: AppColors.primary),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  Text(
                    phone,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (showProfileLink)
            InkWell(
              onTap: () {
                // TODO: توجيه لملف العميل
              },
              child: Row(
                children: [
                  Text(
                    'عرض الملف',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMetaInfoGrid(Invoice invoice) {
    // تنسيق التاريخ والوقت
    final dateStr =
        "${invoice.date.year}/${invoice.date.month.toString().padLeft(2, '0')}/${invoice.date.day.toString().padLeft(2, '0')}";
    final timeStr =
        "${invoice.date.hour.toString().padLeft(2, '0')}:${invoice.date.minute.toString().padLeft(2, '0')}";
    final statusStr = (invoice.status == 'Cash' || invoice.status == 'نقد')
        ? 'نقد'
        : 'دين';

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      children: [
        _metaInfoBox('التاريخ', dateStr),
        _metaInfoBox('الوقت', timeStr),
        _metaInfoBox('وسيلة الدفع', statusStr),
        _metaInfoBox('المتجر', 'متجرك'), // يمكن ربطه بإعدادات المتجر لاحقاً
      ],
    );
  }

  Widget _metaInfoBox(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalReceipt(WidgetRef ref, Invoice invoice) {
    // جلب عناصر الفاتورة (المنتجات المشتراة)
    final itemsAsync = ref.watch(invoiceItemsProvider(invoice.id));

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DashedLine(),
          SizedBox(height: 16.h),
          Text(
            'المنتجات',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16.h),

          // عرض المنتجات ديناميكياً
          itemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('حدث خطأ في جلب المنتجات'),
            data: (items) {
              if (items.isEmpty)
                return const Text('لا يوجد منتجات في هذه الفاتورة');
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _DynamicReceiptItem(item: items[index]);
                },
              );
            },
          ),

          SizedBox(height: 16.h),
          const _DashedLine(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المجموع الفرعي',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                '₪${invoice.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الضريبة (0%)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                '₪0.00',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const _DashedLine(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ملاحظات',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                ' ${invoice.note ?? 'لا توجد ملاحظات'}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const _DashedLine(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                '₪ ${invoice.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryContainer,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const _DashedLine(),

        ],
      ),
    );
  }
// 1. تحديث دالة استدعاء الأزرار لتستقبل المتغيرات
  Widget _buildActionButtons(BuildContext context, WidgetRef ref, Invoice invoice) {
    // التحقق مما إذا كانت الفاتورة ملغاة مسبقاً لتعطيل زر الإلغاء
    final isCancelled = invoice.status == 'cancelled';

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 3,
      children: [
        _actionBtn(Icons.print_outlined, 'طباعة', AppColors.onSurface, AppColors.surfaceContainerHigh, () {
          // كود الطباعة
        }),
        _actionBtn(Icons.share_outlined, 'مشاركة', AppColors.onSurface, AppColors.surfaceContainerHigh, () {
          // كود المشاركة
        }),
        _actionBtn(Icons.content_copy_outlined, 'نسخ', AppColors.onSurface, AppColors.surfaceContainerHigh, () {
          // كود النسخ
        }),

        // زر الإلغاء الديناميكي
        _actionBtn(
          Icons.cancel_outlined,
          isCancelled ? 'تم الإلغاء' : 'إلغاء الفاتورة',
          isCancelled ? AppColors.outline : AppColors.error,
          isCancelled ? AppColors.surfaceContainerHigh : AppColors.errorContainer.withOpacity(0.2),
              () {
            if (isCancelled) {
              // إظهار رسالة إذا كانت الفاتورة ملغاة بالفعل
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('هذه الفاتورة ملغاة بالفعل')),
              );
              return;
            }
            // استدعاء نافذة التحذير
            _showCancelWarningDialog(context, ref, invoice);
          },
        ),
      ],
    );
  }

  // 2. تحديث تصميم الزر ليستقبل دالة onTap
  Widget _actionBtn(IconData icon, String label, Color textColor, Color bgColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20.sp),
            SizedBox(width: 8.w),
            Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: textColor)),
          ],
        ),
      ),
    );
  }

  // 3. تصميم نافذة التحذير (Dialog)
  void _showCancelWarningDialog(BuildContext context, WidgetRef ref, Invoice invoice) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 28.sp),
              SizedBox(width: 8.w),
              Text('تأكيد الإلغاء', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.error)),
            ],
          ),
          content: Text(
            'هل أنت متأكد من إلغاء هذه الفاتورة؟\nسيتم استرجاع كميات المنتجات للمخزن وخصم المبلغ من حساب العميل أو الصندوق.',
            style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext), // إغلاق النافذة بدون فعل شيء
              child: Text('تراجع', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              onPressed: () async {
                // 1. إغلاق النافذة
                Navigator.pop(dialogContext);

                // 2. استدعاء الـ Controller لتنفيذ عملية الإلغاء
                // تأكد من عمل import لملف invoice_controller.dart في أعلى الشاشة
                final success = await ref.read(invoiceControllerProvider.notifier).cancelInvoice(invoice.id);

                // 3. إظهار رسالة بناءً على النتيجة
                if (success) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم إلغاء الفاتورة بنجاح'),
                        backgroundColor: Colors.green, // لون أخضر للنجاح
                      ),
                    );
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('حدث خطأ أثناء الإلغاء'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                }
              },
              child: Text('نعم، قم بالإلغاء', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

}

// ---------------------------------------------------------------------------
// ويدجت إضافي لجلب اسم المنتج الحقيقي لكل عنصر في الفاتورة باستخدام تصميك
// ---------------------------------------------------------------------------
class _DynamicReceiptItem extends ConsumerWidget {
  final InvoiceItem item;

  const _DynamicReceiptItem({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // جلب بيانات المنتج من المعرف للحصول على اسمه
    final productAsync = ref.watch(productByIdProvider(item.productId));
    final String productName =
        productAsync.valueOrNull?.name ?? 'منتج غير معروف';
    final double itemTotal = item.quantity * item.priceAtSale;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                '${item.quantity} × ₪${item.priceAtSale.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Text(
            '₪${itemTotal.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ويدجت الخط المتقطع للإيصال
class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: AppColors.outlineVariant),
              ),
            );
          }),
        );
      },
    );
  }
}


