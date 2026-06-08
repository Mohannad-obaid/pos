import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBright,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStoreProfile(),
            SizedBox(height: 24.h),
            _buildSettingsGroup(
              title: 'المتجر',
              items: [
                _SettingsItem(title: 'اسم المتجر'),
                _SettingsItem(title: 'العملة', value: '₪ شيكل'),
                _SettingsItem(title: 'لغة التطبيق', value: 'العربية', showBorder: false),
              ],
            ),
            SizedBox(height: 24.h),
            _buildSettingsGroup(
              title: 'الأمان',
              items: [
                _SettingsItem(title: 'قفل PIN', isToggle: true, toggleValue: true),
                _SettingsItem(title: 'تغيير PIN'),
                _SettingsItem(title: 'القفل التلقائي بعد', value: 'فوراً', showBorder: false),
              ],
            ),
            SizedBox(height: 24.h),
            _buildAppModeSection(),
            SizedBox(height: 24.h),
            _buildSettingsGroup(
              title: 'النسخ الاحتياطي',
              items: [
                _SettingsItem(title: 'تكرار النسخ', value: 'يدوي'),
                _SettingsItem(title: 'مكان النسخ التلقائي', value: 'التنزيلات', showBorder: false),
              ],
              bottomWidget: Padding(
                padding: EdgeInsets.all(16.w),
                child: Center(
                  child: Text('نسخ الآن', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            _buildSettingsGroup(
              title: 'حول التطبيق',
              items: [
                _SettingsItem(title: 'الإصدار', value: '1.0.0', showChevron: false),
                _SettingsItem(title: 'مسح جميع البيانات', titleColor: AppColors.error, showChevron: false, showBorder: false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surfaceBright,
      elevation: 0,
      centerTitle: true,
      title: Text('الإعدادات', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.storefront, color: AppColors.primary),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildStoreProfile() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.primaryContainer,
            child: Text('مت', style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('متجر محمد', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                Text('اضغط للتعديل', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.outline),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({required String title, required List<_SettingsItem> items, Widget? bottomWidget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Column(
            children: [
              ...items.map((item) => _buildItemTile(item)),
              if (bottomWidget != null) bottomWidget,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemTile(_SettingsItem item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: item.showBorder ? Border(bottom: BorderSide(color: AppColors.outlineVariant.withOpacity(0.5))) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.title, style: TextStyle(fontSize: 16.sp, color: item.titleColor ?? AppColors.onSurface)),
          Row(
            children: [
              if (item.value != null)
                Text(item.value!, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              if (item.isToggle)
                SizedBox(
                  height: 24.h,
                  child: Switch(
                    value: item.toggleValue,
                    activeColor: AppColors.primaryContainer,
                    onChanged: (val) {},
                  ),
                ),
              if (item.showChevron && !item.isToggle) ...[
                SizedBox(width: 8.w),
                Icon(Icons.arrow_forward_ios, size: 14.sp, color: AppColors.outline),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppModeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text('وضع التطبيق', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        ),
        _modeCard('بسيط', 'تتبع الديون فقط', Icons.bolt, false),
        SizedBox(height: 12.h),
        _modeCard('متقدم', 'POS + منتجات + فواتير', Icons.storefront, false),
        SizedBox(height: 12.h),
        _modeCard('هجين', 'الاثنان معاً', Icons.sync, true),
      ],
    );
  }

  Widget _modeCard(String title, String subtitle, IconData icon, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryContainer.withOpacity(0.05) : AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainer,
            child: Icon(icon, color: isSelected ? Colors.white : AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: isSelected ? AppColors.primary : AppColors.onSurface)),
                Text(subtitle, style: TextStyle(fontSize: 12.sp, color: isSelected ? AppColors.primary.withOpacity(0.8) : AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryContainer : Colors.transparent,
              shape: BoxShape.circle,
              border: isSelected ? null : Border.all(color: AppColors.outlineVariant, width: 2),
            ),
            child: isSelected ? Icon(Icons.check, size: 16.sp, color: Colors.white) : null,
          ),
        ],
      ),
    );
  }
}

class _SettingsItem {
  final String title;
  final String? value;
  final bool showChevron;
  final bool showBorder;
  final bool isToggle;
  final bool toggleValue;
  final Color? titleColor;

  _SettingsItem({
    required this.title,
    this.value,
    this.showChevron = true,
    this.showBorder = true,
    this.isToggle = false,
    this.toggleValue = false,
    this.titleColor,
  });
}