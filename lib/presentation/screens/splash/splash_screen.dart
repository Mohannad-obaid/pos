import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/config/routes/navigation_service.dart';

import '../../../../config/routes/app_routes.dart'; // تأكد من مسار مساراتك
import '../../../../service/security_service.dart';
import '../../../core/enums/app_enums.dart';
import '../../../core/theme/app_colors.dart';
import '../lock/pin_lock_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSecurityAndNavigate();
  }

  // Future<void> _checkSecurityAndNavigate() async {
  //   // 1. يمكننا إضافة تأخير بسيط جداً (مثلاً ثانية ونصف) لكي يرى المستخدم شعار التطبيق
  //   await Future.delayed(const Duration(milliseconds: 1800));
  //
  //   // 2. فحص الأمان
  //   final security = ref.read(securityServiceProvider);
  //   final pin = await security.getPin();
  //
  //   if (!mounted) return;
  //
  //   if (pin != null) {
  //     // إذا كان هناك رمز مفعل، نوجهه لشاشة القفل أولاً
  //     // استخدمنا pushReplacement لكي لا يتمكن المستخدم من الرجوع لشاشة Splash
  //     final result = await Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const PinLockScreen(initialMode: PinMode.unlock),
  //       ),
  //     );
  //
  //     // بعد نجاح فتح القفل، نوجهه للشاشة الرئيسية
  //     if (result == true && mounted) {
  //       NavigationService.navigateAndRemoveUntil(AppRoutes.dashboard); //.pushReplacementNamed(context, );
  //     }
  //   } else {
  //     // إذا لم يكن هناك رمز مفعل، يذهب مباشرة للشاشة الرئيسية
  //     NavigationService.navigateAndRemoveUntil(AppRoutes.dashboard);
  //   }
  // }

  Future<void> _checkSecurityAndNavigate() async {
    // 1. تأخير بسيط جداً لكي يرى المستخدم شعار التطبيق
    await Future.delayed(const Duration(milliseconds: 1800));

    // 2. فحص الأمان
    final security = ref.read(securityServiceProvider);
    final pin = await security.getPin();

    if (!mounted) return;

    if (pin != null) {
      // 💡 التعديل هنا: استخدمنا push العادية بدلاً من pushReplacement
      // لكي تبقى شاشة الـ Splash في الخلفية وتستقبل النتيجة وتكمل التوجيه
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PinLockScreen(initialMode: PinMode.unlock),
        ),
      );

      // بعد نجاح فتح القفل وعمل pop، سيعود الكود للعمل هنا ويوجه للرئيسية
      if (result == true && mounted) {
        NavigationService.navigateAndRemoveUntil(AppRoutes.dashboard);
      }
    } else {
      // إذا لم يكن هناك رمز مفعل، يذهب مباشرة للشاشة الرئيسية
      NavigationService.navigateAndRemoveUntil(AppRoutes.dashboard);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF0F7FF), // نفس لون AppColors.background عندك
        child: Stack(
          children: [
// دوائر الخلفية
            Positioned(
              top: -60, right: -60,
              child: _buildCircle(220, 0.08),
            ),
            Positioned(
              top: -30, right: -30,
              child: _buildCircle(150, 0.12),
            ),
            Positioned(
              bottom: -80, left: -50,
              child: _buildCircle(280, 0.06),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
// الشعار
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 96.w, height: 96.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28.r),
                          border: Border.all(color: AppColors.primary
                              .withOpacity(0.15)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.12),
                              blurRadius: 32, offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(Icons.receipt_long, size: 48.sp,
                            color: AppColors.primary),
                      ),
                      Positioned(
                        top: -4, right: 0,
                        child: Container(
                          width: 20.w, height: 20.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFFF0F7FF), width: 2),
                          ),
                          child: Icon(Icons.check, size: 10.sp, color: Colors
                              .white),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                  Text('كاشير',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF0C447C),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text('CASHBOOK',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.primary,
                      letterSpacing: 3,
                    ),
                  ),

                  SizedBox(height: 48.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) =>
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: 6.w, height: 6.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withOpacity(0.2),
                          ),
                        ),
                    ),
                  ),

                  SizedBox(height: 56.h),

                  Wrap(
                    spacing: 8.w,
                    children: [
                      _buildChip(Icons.shopping_cart_outlined, 'نقطة بيع'),
                      _buildChip(Icons.people_outline, 'عملاء'),
                      _buildChip(Icons.book_outlined, 'ديون'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(double size, double opacity) {
    return Container(
      width: size.w, height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withOpacity(opacity)),
      ),
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 8, offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: AppColors.primary),
          SizedBox(width: 6.w),
          Text(label,
              style: TextStyle(fontSize: 12.sp, color: AppColors.primary)),
        ],
      ),
    );
  }
}
