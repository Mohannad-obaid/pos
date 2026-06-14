// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../config/routes/navigation_service.dart';
// import '../../../../core/enums/app_enums.dart';
// import '../../../../service/security_service.dart';
// import '../../lock/pin_lock_screen.dart';
//
// class AppLockWrapper extends ConsumerStatefulWidget {
//   final Widget child;
//   const AppLockWrapper({super.key, required this.child});
//
//   @override
//   ConsumerState<AppLockWrapper> createState() => _AppLockWrapperState();
// }
//
// class _AppLockWrapperState extends ConsumerState<AppLockWrapper> with WidgetsBindingObserver {
//   DateTime? _backgroundTimestamp;
//   bool _isLocked = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     // الفحص عند فتح التطبيق لأول مرة
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkInitialLock();
//     });
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   Future<void> _checkInitialLock() async {
//     final security = ref.read(securityServiceProvider);
//     final pin = await security.getPin();
//     if (pin != null) {
//       _showLockScreen();
//     }
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     final security = ref.read(securityServiceProvider);
//     final pin = await security.getPin();
//
//     if (pin == null) return; // لا يوجد قفل
//
//     if (state == AppLifecycleState.paused) {
//       _backgroundTimestamp = DateTime.now();
//     } else if (state == AppLifecycleState.resumed) {
//       if (_backgroundTimestamp != null && !_isLocked) {
//         final timeoutMinutes = await security.getAutoLockTimeout();
//         final difference = DateTime.now().difference(_backgroundTimestamp!);
//
//         if (difference.inMinutes >= timeoutMinutes) {
//           _showLockScreen();
//         }
//       }
//     }
//   }
//
//   void _showLockScreen() async {
//     if (_isLocked) return;
//
//     setState(() => _isLocked = true);
//
//     // التعديل السحري هنا: استخدام navigatorKey.currentState للوصول للـ Navigator من أي مكان
//     final result = await NavigationService.navigatorKey.currentState?.push(
//       MaterialPageRoute(
//         builder: (context) => const PinLockScreen(initialMode: PinMode.unlock),
//       ),
//     );
//
//     if (result == true) {
//       setState(() {
//         _isLocked = false;
//         _backgroundTimestamp = null;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/navigation_service.dart';
import '../../../../core/enums/app_enums.dart';
import '../../../../service/security_service.dart';
import '../../lock/pin_lock_screen.dart';

class AppLockWrapper extends ConsumerStatefulWidget {
  final Widget child;
  const AppLockWrapper({super.key, required this.child});

  @override
  ConsumerState<AppLockWrapper> createState() => _AppLockWrapperState();
}

class _AppLockWrapperState extends ConsumerState<AppLockWrapper> with WidgetsBindingObserver {
  DateTime? _backgroundTimestamp;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // 💡 تم حذف الفحص الأولي من هنا لأن شاشة الـ Splash هي من ستتولى فحص القفل عند فتح التطبيق من الصفر
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // هذه الدالة تراقب حركة التطبيق (خلفية / أمامية)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final security = ref.read(securityServiceProvider);
    final pin = await security.getPin();

    if (pin == null) return; // لا يوجد قفل مفعل

    if (state == AppLifecycleState.paused) {
      // التطبيق نزل للخلفية -> سجل الوقت
      _backgroundTimestamp = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      // التطبيق رجع للشاشة -> احسب الوقت واقفل إذا لزم الأمر
      if (_backgroundTimestamp != null && !_isLocked) {
        final timeoutMinutes = await security.getAutoLockTimeout();
        final difference = DateTime.now().difference(_backgroundTimestamp!);

        if (difference.inMinutes >= timeoutMinutes) {
          _showLockScreen();
        }
      }
    }
  }

  void _showLockScreen() async {
    if (_isLocked) return;

    setState(() => _isLocked = true);

    // استخدام navigatorKey.currentState للوصول للـ Navigator من أي مكان
    final result = await NavigationService.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const PinLockScreen(initialMode: PinMode.unlock),
      ),
    );

    if (result == true) {
      setState(() {
        _isLocked = false;
        _backgroundTimestamp = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}