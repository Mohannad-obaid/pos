import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import 'home/home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("العملاء")), // واجهة العملاء
    const Center(child: Text("المنتجات")), // واجهة المنتجات
    const Center(child: Text("الفواتير")), // واجهة الفواتير
    const Center(child: Text("المزيد")), // واجهة الإعدادات
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          border: Border(
            top: BorderSide(color: AppColors.outlineVariant, width: 1.h),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: AppColors.surfaceContainerLowest,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.onSurfaceVariant,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          elevation: 0,
          items: [
            _buildNavItem(Icons.home_filled, 'الرئيسية', 0),
            _buildNavItem(Icons.people_outline, 'العملاء', 1),
            _buildNavItem(Icons.inventory_2_outlined, 'المنتجات', 2),
            _buildNavItem(Icons.receipt_long_outlined, 'الفواتير', 3),
            _buildNavItem(Icons.more_horiz, 'المزيد', 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.secondaryContainer : AppColors.onSurfaceVariant,
          size: 24.sp,
        ),
      ),
      label: label,
    );
  }
}