// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/theme/app_colors.dart';
//
// class ReportsScreen extends StatelessWidget {
//   const ReportsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 100.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             SizedBox(height: 24.h),
//             _buildMetricsGrid(),
//             SizedBox(height: 24.h),
//             _buildTrendChart(),
//             SizedBox(height: 24.h),
//             _buildTopDebtors(),
//             SizedBox(height: 24.h),
//             _buildPaymentVsDebtChart(),
//             SizedBox(height: 32.h),
//             _buildExportButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: AppColors.surface,
//       elevation: 0,
//       title: Text('DaynPay', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
//       leading: IconButton(
//         icon: Icon(Icons.menu, color: AppColors.onSurfaceVariant),
//         onPressed: () {},
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.notifications_none, color: AppColors.onSurfaceVariant),
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
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text('التقارير', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//           decoration: BoxDecoration(
//             color: AppColors.surfaceContainerLowest,
//             borderRadius: BorderRadius.circular(20.r),
//             border: Border.all(color: AppColors.outlineVariant),
//           ),
//           child: Row(
//             children: [
//               Text('هذا الشهر', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
//               SizedBox(width: 4.w),
//               Icon(Icons.expand_more, size: 16.sp),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMetricsGrid() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       childAspectRatio: 1.3,
//       mainAxisSpacing: 16.h,
//       crossAxisSpacing: 16.w,
//       children: [
//         _metricCard('إجمالي المبيعات', '₪3,240', '+12%', Icons.trending_up, AppColors.secondary),
//         _metricCard('المدفوعات المُحصَّلة', '₪2,100', '+8%', Icons.trending_up, AppColors.secondary),
//         _metricCard('الديون الجديدة', '₪840', '-3%', Icons.trending_down, AppColors.error),
//         _metricCard('عدد الفواتير', '47', 'فاتورة مُصدرة', null, AppColors.onSurfaceVariant),
//       ],
//     );
//   }
//
//   Widget _metricCard(String title, String value, String subtitle, IconData? icon, Color subtitleColor) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(value, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
//               Row(
//                 children: [
//                   if (icon != null) Icon(icon, size: 14.sp, color: subtitleColor),
//                   SizedBox(width: 2.w),
//                   Text(subtitle, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: subtitleColor)),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrendChart() {
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('اتجاه الديون (آخر 7 أيام)', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//           SizedBox(height: 24.h),
//           SizedBox(
//             height: 160.h,
//             width: double.infinity,
//             child: Stack(
//               children: [
//                 CustomPaint(
//                   size: Size.infinite,
//                   painter: _LineChartPainter(),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 140.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: ['أحد', 'اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت']
//                           .map((day) => Text(day, style: TextStyle(fontSize: 10.sp, color: AppColors.outline)))
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTopDebtors() {
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('أكبر المديونين', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//               Text('عرض الكل', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           _debtorRow('أحمد المحمود', '₪450', 0.85),
//           _debtorRow('سارة جابر', '₪320', 0.60),
//           _debtorRow('عمر يوسف', '₪190', 0.35),
//           _debtorRow('محمد علي', '₪115', 0.20, isInitials: true, initials: 'م.ع'),
//         ],
//       ),
//     );
//   }
//
//   Widget _debtorRow(String name, String amount, double percent, {bool isInitials = false, String initials = ''}) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 16.h),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20.r,
//             backgroundColor: isInitials ? AppColors.primaryFixed : Colors.grey.shade200,
//             child: isInitials
//                 ? Text(initials, style: TextStyle(color: AppColors.onPrimaryFixed, fontWeight: FontWeight.bold))
//                 : const Icon(Icons.person, color: Colors.grey),
//           ),
//           SizedBox(width: 16.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
//                     Text(amount, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.error)),
//                   ],
//                 ),
//                 SizedBox(height: 8.h),
//                 LinearProgressIndicator(
//                   value: percent,
//                   backgroundColor: AppColors.surfaceContainerLow,
//                   valueColor: AlwaysStoppedAnimation<Color>(AppColors.error),
//                   minHeight: 6.h,
//                   borderRadius: BorderRadius.circular(4.r),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPaymentVsDebtChart() {
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('مقارنة المدفوعات والديون', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//               Row(
//                 children: [
//                   _legendItem('مدفوعات', AppColors.secondary),
//                   SizedBox(width: 8.w),
//                   _legendItem('ديون', AppColors.error),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 24.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               _barGroup('الأسبوع 1', 60, 30),
//               _barGroup('الأسبوع 2', 80, 45),
//               _barGroup('الأسبوع 3', 40, 90),
//               _barGroup('الأسبوع 4', 70, 25),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _legendItem(String label, Color color) {
//     return Row(
//       children: [
//         Container(width: 12.w, height: 12.w, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2.r))),
//         SizedBox(width: 4.w),
//         Text(label, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
//       ],
//     );
//   }
//
//   Widget _barGroup(String label, double paymentHeight, double debtHeight) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 120.h,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Container(width: 16.w, height: (paymentHeight / 100) * 120.h, decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)))),
//               SizedBox(width: 4.w),
//               Container(width: 16.w, height: (debtHeight / 100) * 120.h, decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)))),
//             ],
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Text(label, style: TextStyle(fontSize: 10.sp, color: AppColors.outline)),
//       ],
//     );
//   }
//
//   Widget _buildExportButton() {
//     return Center(
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: AppColors.primary,
//           side: const BorderSide(color: AppColors.primary),
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//         ),
//         onPressed: () {},
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('تصدير التقرير', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//             SizedBox(width: 16.w),
//             Container(width: 1, height: 20.h, color: AppColors.outlineVariant),
//             SizedBox(width: 16.w),
//             Icon(Icons.picture_as_pdf, color: AppColors.error),
//             SizedBox(width: 8.w),
//             Icon(Icons.chat, color: AppColors.secondary),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Custom Painter لنمذجة الرسم البياني الخطي
// class _LineChartPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paintLine = Paint()
//       ..color = AppColors.primaryContainer
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke;
//
//     final path = Path();
//     path.moveTo(0, size.height * 0.8);
//     path.quadraticBezierTo(size.width * 0.1, size.height * 0.7, size.width * 0.2, size.height * 0.75);
//     path.quadraticBezierTo(size.width * 0.4, size.height * 0.5, size.width * 0.6, size.height * 0.6);
//     path.quadraticBezierTo(size.width * 0.8, size.height * 0.3, size.width, size.height * 0.4);
//
//     // Gradient Fill
//     final fillPath = Path.from(path);
//     fillPath.lineTo(size.width, size.height);
//     fillPath.lineTo(0, size.height);
//     fillPath.close();
//
//     final gradient = LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [AppColors.primaryContainer.withOpacity(0.15), AppColors.primaryContainer.withOpacity(0.0)],
//     );
//
//     canvas.drawPath(fillPath, Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
//     canvas.drawPath(path, paintLine);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart';
import '../../../providers/customer_controller.dart';
import '../../../providers/repository_providers.dart' hide customersListProvider;

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. جلب البيانات من قاعدة البيانات
    final invoices = ref.watch(invoicesListProvider).valueOrNull ?? [];
    final payments = ref.watch(paymentsListProvider).valueOrNull ?? [];
    final customers = ref.watch(customersListProvider).valueOrNull ?? [];

    final now = DateTime.now();

    // ---------------------------------------------------------
    // أ. حساب إحصائيات "هذا الشهر" (الشبكة العلوية)
    // ---------------------------------------------------------
    double totalSales = 0.0;
    double totalPayments = 0.0;
    double newDebts = 0.0;
    int invoicesCount = 0;

    for (var inv in invoices) {
      if (inv.date.month == now.month && inv.date.year == now.year) {
        totalSales += inv.totalAmount;
        invoicesCount++;
        if (inv.status == 'دين' || inv.status == 'Debt' || inv.status == 'آجل') {
          newDebts += inv.totalAmount;
        }
      }
    }

    for (var pay in payments) {
      if (pay.date.month == now.month && pay.date.year == now.year) {
        totalPayments += pay.amount;
      }
    }

    // ---------------------------------------------------------
    // ب. حساب اتجاه الديون لآخر 7 أيام (للرسم الخطي)
    // ---------------------------------------------------------
    List<double> last7DaysDebt = List.filled(7, 0.0);
    List<String> last7DaysNames = [];
    const daysAr = ['اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت', 'أحد'];

    for (int i = 0; i < 7; i++) {
      DateTime d = now.subtract(Duration(days: 6 - i));
      last7DaysNames.add(daysAr[d.weekday - 1]);

      double dayDebt = invoices
          .where((inv) => inv.date.year == d.year && inv.date.month == d.month && inv.date.day == d.day && (inv.status == 'دين' || inv.status == 'Debt'))
          .fold(0.0, (sum, inv) => sum + inv.totalAmount);
      last7DaysDebt[i] = dayDebt;
    }

    // ---------------------------------------------------------
    // ج. ترتيب أكبر المديونين
    // ---------------------------------------------------------
    final debtors = customers.where((c) => c.totalDebt > 0).toList()
      ..sort((a, b) => b.totalDebt.compareTo(a.totalDebt));
    final topDebtors = debtors.take(4).toList();
    final maxDebt = topDebtors.isNotEmpty ? topDebtors.first.totalDebt : 1.0; // لتجنب القسمة على صفر

    // ---------------------------------------------------------
    // د. حساب بيانات الأعمدة للأسابيع الـ 4 في هذا الشهر
    // ---------------------------------------------------------
    List<double> weeklyPayments = [0, 0, 0, 0];
    List<double> weeklyDebts = [0, 0, 0, 0];

    for (var pay in payments.where((p) => p.date.month == now.month && p.date.year == now.year)) {
      int week = (pay.date.day - 1) ~/ 7;
      if (week > 3) week = 3;
      weeklyPayments[week] += pay.amount;
    }

    for (var inv in invoices.where((i) => i.date.month == now.month && i.date.year == now.year && (i.status == 'دين' || i.status == 'Debt'))) {
      int week = (inv.date.day - 1) ~/ 7;
      if (week > 3) week = 3;
      weeklyDebts[week] += inv.totalAmount;
    }

    // إيجاد أعلى قيمة في الأسابيع لضبط نسبة ارتفاع الأعمدة
    double maxWeeklyAmount = 1.0;
    for (int i = 0; i < 4; i++) {
      if (weeklyPayments[i] > maxWeeklyAmount) maxWeeklyAmount = weeklyPayments[i];
      if (weeklyDebts[i] > maxWeeklyAmount) maxWeeklyAmount = weeklyDebts[i];
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 24.h),
            // الشبكة مع البيانات الديناميكية
            _buildMetricsGrid(totalSales, totalPayments, newDebts, invoicesCount),
            SizedBox(height: 24.h),
            // الرسم البياني الخطي
            _buildTrendChart(last7DaysDebt, last7DaysNames),
            SizedBox(height: 24.h),
            // أكبر المديونين
            _buildTopDebtors(topDebtors, maxDebt),
            SizedBox(height: 24.h),
            // رسم الأعمدة مقارنة الديون والمدفوعات
            _buildPaymentVsDebtChart(weeklyPayments, weeklyDebts, maxWeeklyAmount),
            SizedBox(height: 32.h),
            _buildExportButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('التقارير', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Row(
            children: [
              Text('هذا الشهر', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
              SizedBox(width: 4.w),
              Icon(Icons.expand_more, size: 16.sp),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(double totalSales, double totalPayments, double newDebts, int invoicesCount) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.3,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      children: [
        _metricCard('إجمالي المبيعات', '₪${totalSales.toStringAsFixed(0)}', 'لهذا الشهر', Icons.trending_up, AppColors.secondary),
        _metricCard('المدفوعات المُحصَّلة', '₪${totalPayments.toStringAsFixed(0)}', 'لهذا الشهر', Icons.trending_up, AppColors.secondary),
        _metricCard('الديون الجديدة', '₪${newDebts.toStringAsFixed(0)}', 'لهذا الشهر', Icons.trending_down, AppColors.error),
        _metricCard('عدد الفواتير', '$invoicesCount', 'فاتورة مُصدرة', null, AppColors.onSurfaceVariant),
      ],
    );
  }

  Widget _metricCard(String title, String value, String subtitle, IconData? icon, Color subtitleColor) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold), textDirection: TextDirection.ltr),
              Row(
                children: [
                  if (icon != null) Icon(icon, size: 14.sp, color: subtitleColor),
                  SizedBox(width: 2.w),
                  Text(subtitle, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: subtitleColor)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart(List<double> data, List<String> days) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('اتجاه الديون (آخر 7 أيام)', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
          SizedBox(height: 24.h),
          SizedBox(
            height: 160.h,
            width: double.infinity,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size.infinite,
                  painter: _DynamicLineChartPainter(dataPoints: data),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 140.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: days.map((day) => Text(day, style: TextStyle(fontSize: 10.sp, color: AppColors.outline))).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopDebtors(List<Customer> topDebtors, double maxDebt) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('أكبر المديونين', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
              Text('عرض الكل', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 16.h),
          if (topDebtors.isEmpty)
            Center(child: Padding(padding: EdgeInsets.all(16.h), child: Text('لا توجد ديون مسجلة', style: TextStyle(color: AppColors.outline))))
          else
            ...topDebtors.map((customer) {
              final percent = customer.totalDebt / maxDebt;

              // استخراج أول حرفين للاسم في الأيقونة
              final nameParts = customer.name.trim().split(' ');
              String initials = nameParts.first.isNotEmpty ? nameParts.first.substring(0, 1) : '';
              if (nameParts.length > 1 && nameParts[1].isNotEmpty) {
                initials += '.${nameParts[1].substring(0, 1)}';
              }

              return _debtorRow(
                customer.name,
                '₪${customer.totalDebt.toStringAsFixed(0)}',
                percent,
                isInitials: true,
                initials: initials,
              );
            }),
        ],
      ),
    );
  }

  Widget _debtorRow(String name, String amount, double percent, {bool isInitials = false, String initials = ''}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: isInitials ? AppColors.primaryFixed : Colors.grey.shade200,
            child: isInitials
                ? Text(initials, style: TextStyle(color: AppColors.onPrimaryFixed, fontWeight: FontWeight.bold, fontSize: 12.sp))
                : const Icon(Icons.person, color: Colors.grey),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    Text(amount, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.error), textDirection: TextDirection.ltr),
                  ],
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: percent.clamp(0.0, 1.0), // لضمان أن القيمة لا تتجاوز 1.0
                  backgroundColor: AppColors.surfaceContainerLow,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.error),
                  minHeight: 6.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentVsDebtChart(List<double> payments, List<double> debts, double maxAmount) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('مقارنة المدفوعات والديون', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
              Row(
                children: [
                  _legendItem('مدفوعات', AppColors.secondary),
                  SizedBox(width: 8.w),
                  _legendItem('ديون', AppColors.error),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _barGroup('الأسبوع 1', _getPercent(payments[0], maxAmount), _getPercent(debts[0], maxAmount)),
              _barGroup('الأسبوع 2', _getPercent(payments[1], maxAmount), _getPercent(debts[1], maxAmount)),
              _barGroup('الأسبوع 3', _getPercent(payments[2], maxAmount), _getPercent(debts[2], maxAmount)),
              _barGroup('الأسبوع 4', _getPercent(payments[3], maxAmount), _getPercent(debts[3], maxAmount)),
            ],
          ),
        ],
      ),
    );
  }

  double _getPercent(double value, double max) {
    if (max == 0) return 0;
    return (value / max) * 100;
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 12.w, height: 12.w, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2.r))),
        SizedBox(width: 4.w),
        Text(label, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
      ],
    );
  }

  Widget _barGroup(String label, double paymentPercent, double debtPercent) {
    return Column(
      children: [
        SizedBox(
          height: 120.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(width: 16.w, height: (paymentPercent / 100) * 120.h, decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)))),
              SizedBox(width: 4.w),
              Container(width: 16.w, height: (debtPercent / 100) * 120.h, decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)))),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(label, style: TextStyle(fontSize: 10.sp, color: AppColors.outline)),
      ],
    );
  }

  Widget _buildExportButton() {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('تصدير التقرير', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(width: 16.w),
            Container(width: 1, height: 20.h, color: AppColors.outlineVariant),
            SizedBox(width: 16.w),
            Icon(Icons.picture_as_pdf, color: AppColors.error),
            SizedBox(width: 8.w),
            Icon(Icons.chat, color: AppColors.secondary),
          ],
        ),
      ),
    );
  }
}

// Custom Painter متصل بالبيانات لرسم المنحنى (Trend) بذكاء
class _DynamicLineChartPainter extends CustomPainter {
  final List<double> dataPoints;

  _DynamicLineChartPainter({required this.dataPoints});

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final paintLine = Paint()
      ..color = AppColors.primaryContainer
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double maxVal = dataPoints.reduce(math.max);
    if (maxVal == 0) maxVal = 1; // تفادي القسمة على صفر إذا لم تكن هناك ديون

    final path = Path();
    final stepX = size.width / (dataPoints.length - 1);

    // معادلة لحساب الـ Y، حيث 0 في الـ Canvas هي القمة، لذلك نعكسها
    double getY(double value) {
      return size.height * 0.8 - ((value / maxVal) * (size.height * 0.7));
    }

    path.moveTo(0, getY(dataPoints[0]));

    for (int i = 1; i < dataPoints.length; i++) {
      // رسم انحناء ناعم بين النقاط (Smooth curve)
      double prevX = (i - 1) * stepX;
      double prevY = getY(dataPoints[i - 1]);
      double currentX = i * stepX;
      double currentY = getY(dataPoints[i]);

      double cp1x = prevX + (currentX - prevX) / 2;
      double cp1y = prevY;
      double cp2x = prevX + (currentX - prevX) / 2;
      double cp2y = currentY;

      path.cubicTo(cp1x, cp1y, cp2x, cp2y, currentX, currentY);
    }

    // Gradient Fill (التعبئة المتدرجة للأسفل)
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.primaryContainer.withOpacity(0.2), AppColors.primaryContainer.withOpacity(0.0)],
    );

    canvas.drawPath(fillPath, Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true; // إعادة الرسم عند تغير البيانات
}