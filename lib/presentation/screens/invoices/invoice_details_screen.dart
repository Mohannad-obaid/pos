import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildStatusBadge(),
            SizedBox(height: 24.h),
            _buildCustomerCard(),
            SizedBox(height: 16.h),
            _buildMetaInfoGrid(),
            SizedBox(height: 24.h),
            _buildDigitalReceipt(),
            SizedBox(height: 24.h),
            _buildActionButtons(),
          ],
        ),
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
      title: Text('#INV-0047', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
      actions: [
        IconButton(
          icon: Icon(Icons.share_outlined, color: AppColors.onSurface),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20.sp),
          SizedBox(width: 8.w),
          Text('دين', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.error)),
        ],
      ),
    );
  }

  Widget _buildCustomerCard() {
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
                child: Icon(Icons.person, color: AppColors.primary), // Placeholder
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('يوسف مصطفى', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                  Text('059-XXXXXXX', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text('عرض الملف', style: TextStyle(fontSize: 12.sp, color: AppColors.primary, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_forward_ios, size: 12.sp, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaInfoGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      children: [
        _metaInfoBox('التاريخ', '٠١ يونيو ٢٠٢٥'),
        _metaInfoBox('الوقت', '١٤:٣٢'),
        _metaInfoBox('وسيلة الدفع', 'دين'),
        _metaInfoBox('المتجر', 'متجر محمد'),
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
          Text(title, style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant.withOpacity(0.7))),
          Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
        ],
      ),
    );
  }

  Widget _buildDigitalReceipt() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _DashedLine(),
          SizedBox(height: 16.h),
          Text('المنتجات', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
          SizedBox(height: 16.h),
          _receiptItem('كولا 330ml', '3 × ₪5.50', '₪16.50'),
          _receiptItem('خبز تنور', '1 × ₪3.00', '₪3.00'),
          _receiptItem('شيبس', '2 × ₪4.00', '₪8.00'),
          _receiptItem('ماء 1.5L', '1 × ₪2.50', '₪2.50'),
          SizedBox(height: 16.h),
          const _DashedLine(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('المجموع الفرعي', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              Text('₪30.00', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الضريبة (0%)', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              Text('₪0.00', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
            ],
          ),
          SizedBox(height: 16.h),
          const _DashedLine(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الإجمالي', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              Text('₪ 30.00', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primaryContainer)),
            ],
          ),
          SizedBox(height: 16.h),
          const _DashedLine(),
        ],
      ),
    );
  }

  Widget _receiptItem(String name, String qtyAndPrice, String total) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
              Text(qtyAndPrice, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
            ],
          ),
          Text(total, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 3,
      children: [
        _actionBtn(Icons.print_outlined, 'طباعة', AppColors.onSurface, AppColors.surfaceContainerHigh),
        _actionBtn(Icons.share_outlined, 'مشاركة', AppColors.onSurface, AppColors.surfaceContainerHigh),
        _actionBtn(Icons.content_copy_outlined, 'نسخ', AppColors.onSurface, AppColors.surfaceContainerHigh),
        _actionBtn(Icons.cancel_outlined, 'إلغاء الفاتورة', AppColors.error, AppColors.errorContainer.withOpacity(0.2)),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, Color textColor, Color bgColor) {
    return InkWell(
      onTap: () {},
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
              child: const DecoratedBox(decoration: BoxDecoration(color: AppColors.outlineVariant)),
            );
          }),
        );
      },
    );
  }
}