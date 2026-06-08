import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class QuickDebtEntryScreen extends StatefulWidget {
  const QuickDebtEntryScreen({super.key});

  @override
  State<QuickDebtEntryScreen> createState() => _QuickDebtEntryScreenState();
}

class _QuickDebtEntryScreenState extends State<QuickDebtEntryScreen> {
  String _amount = "0";

  void _onKeyTap(String value) {
    setState(() {
      if (value == "C") {
        _amount = "0";
      } else if (value == ".") {
        if (!_amount.contains(".")) {
          _amount += ".";
        }
      } else {
        if (_amount == "0") {
          _amount = value;
        } else {
          _amount += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainerLowest,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildRecentCustomers(),
                  SizedBox(height: 24.h),
                  _buildCustomerSelector(),
                  SizedBox(height: 24.h),
                  _buildAmountDisplay(),
                  SizedBox(height: 12.h),
                  _buildSuggestionChip(),
                  SizedBox(height: 32.h),
                  _buildNumpad(),
                  SizedBox(height: 24.h),
                  _buildNoteField(),
                ],
              ),
            ),
          ),
          _buildSaveButton(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: AppColors.primary, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        'دين سريع',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildRecentCustomers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'العملاء الأخيرون',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 36.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _recentCustomerChip('أحمد'),
              _recentCustomerChip('ياسين'),
              _recentCustomerChip('منى'),
              _recentCustomerChip('سارة'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recentCustomerChip(String name) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      child: ActionChip(
        label: Text(name, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurface)),
        backgroundColor: AppColors.surfaceContainerLow,
        side: BorderSide(color: AppColors.outlineVariant, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        onPressed: () {},
      ),
    );
  }

  Widget _buildCustomerSelector() {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: AppColors.primaryFixed,
                child: Text('أ', style: TextStyle(color: AppColors.onPrimaryFixed, fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ),
              SizedBox(width: 12.w),
              Text('أحمد الحمدان', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
            ],
          ),
          Icon(Icons.expand_more, color: AppColors.onSurfaceVariant),
        ],
      ),
    );
  }

  Widget _buildAmountDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('₪', style: TextStyle(fontSize: 32.sp, color: AppColors.primary, fontWeight: FontWeight.w500)),
        SizedBox(width: 8.w),
        Container(
          constraints: BoxConstraints(minWidth: 120.w),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.primaryContainer, width: 2.h)),
          ),
          child: Text(
            _amount,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionChip() {
    return GestureDetector(
      onTap: () {
        setState(() => _amount = "350");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E1),
          border: Border.all(color: const Color(0xFFFFD54F)),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          'آخر مرة: ₪350 — اضغط للاستخدام',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF795548)),
        ),
      ),
    );
  }

  Widget _buildNumpad() {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'C', '0', '.'];
    return SizedBox(
      width: 320.w,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: keys.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemBuilder: (context, index) {
          final isClear = keys[index] == 'C';
          return InkWell(
            onTap: () => _onKeyTap(keys[index]),
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isClear ? AppColors.surfaceVariant : AppColors.surface,
                border: Border.all(color: AppColors.outlineVariant),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                keys[index],
                style: TextStyle(
                  fontSize: isClear ? 20.sp : 24.sp,
                  fontWeight: FontWeight.w600,
                  color: isClear ? AppColors.onSurfaceVariant : AppColors.onSurface,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoteField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'ملاحظة (اختياري)',
        prefixIcon: Icon(Icons.edit_note, color: AppColors.outlineVariant),
        filled: true,
        fillColor: AppColors.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: AppColors.onPrimaryContainer,
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 4,
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('حفظ الدين', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(width: 8.w),
            Icon(Icons.check_circle_outline, size: 24.sp),
          ],
        ),
      ),
    );
  }
}