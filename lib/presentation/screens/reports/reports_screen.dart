import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            _buildMetricsGrid(),
            SizedBox(height: 24.h),
            _buildTrendChart(),
            SizedBox(height: 24.h),
            _buildTopDebtors(),
            SizedBox(height: 24.h),
            _buildPaymentVsDebtChart(),
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

  Widget _buildMetricsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.3,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      children: [
        _metricCard('إجمالي المبيعات', '₪3,240', '+12%', Icons.trending_up, AppColors.secondary),
        _metricCard('المدفوعات المُحصَّلة', '₪2,100', '+8%', Icons.trending_up, AppColors.secondary),
        _metricCard('الديون الجديدة', '₪840', '-3%', Icons.trending_down, AppColors.error),
        _metricCard('عدد الفواتير', '47', 'فاتورة مُصدرة', null, AppColors.onSurfaceVariant),
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
              Text(value, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
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

  Widget _buildTrendChart() {
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
                  painter: _LineChartPainter(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 140.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['أحد', 'اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت']
                          .map((day) => Text(day, style: TextStyle(fontSize: 10.sp, color: AppColors.outline)))
                          .toList(),
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

  Widget _buildTopDebtors() {
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
          _debtorRow('أحمد المحمود', '₪450', 0.85),
          _debtorRow('سارة جابر', '₪320', 0.60),
          _debtorRow('عمر يوسف', '₪190', 0.35),
          _debtorRow('محمد علي', '₪115', 0.20, isInitials: true, initials: 'م.ع'),
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
                ? Text(initials, style: TextStyle(color: AppColors.onPrimaryFixed, fontWeight: FontWeight.bold))
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
                    Text(amount, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.error)),
                  ],
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: percent,
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

  Widget _buildPaymentVsDebtChart() {
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
              _barGroup('الأسبوع 1', 60, 30),
              _barGroup('الأسبوع 2', 80, 45),
              _barGroup('الأسبوع 3', 40, 90),
              _barGroup('الأسبوع 4', 70, 25),
            ],
          ),
        ],
      ),
    );
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

  Widget _barGroup(String label, double paymentHeight, double debtHeight) {
    return Column(
      children: [
        SizedBox(
          height: 120.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(width: 16.w, height: (paymentHeight / 100) * 120.h, decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)))),
              SizedBox(width: 4.w),
              Container(width: 16.w, height: (debtHeight / 100) * 120.h, decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)))),
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

// Custom Painter لنمذجة الرسم البياني الخطي
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = AppColors.primaryContainer
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.7, size.width * 0.2, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.5, size.width * 0.6, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.3, size.width, size.height * 0.4);

    // Gradient Fill
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.primaryContainer.withOpacity(0.15), AppColors.primaryContainer.withOpacity(0.0)],
    );

    canvas.drawPath(fillPath, Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}