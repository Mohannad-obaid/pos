import 'package:flutter/material.dart';

import 'app_routes.dart';

class NavigationService {
  // المفتاح العام الذي سيرتبط بـ MaterialApp
  // Global navigator key for navigation without context
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  // Get current context
  static BuildContext? get currentContext => navigatorKey.currentContext;

  // Get current navigator state
  static NavigatorState? get navigator => navigatorKey.currentState;


  // الانتقال إلى شاشة جديدة
  /// Navigate to a named route
  static Future<T?> navigateTo<T>(
      String routeName, {
        Object? arguments,
      }) async {
    return navigator?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  // استبدال الشاشة الحالية بشاشة جديدة (مثل من Splash إلى Home)
  /// Replace current route with a new route
  static Future<T?> navigateReplaceTo<T extends Object?>(
      String routeName, {
        Object? arguments,
      }) async {
    return navigator?.pushReplacementNamed<T, T>(
      routeName,
      arguments: arguments,
    );
  }

  // حذف كل الشاشات السابقة والانتقال لشاشة جديدة (مثل بعد تسجيل الخروج أو إتمام الطلب)
  /// Navigate and remove all previous routes
  static Future<T?> navigateAndRemoveUntil<T>(
      String routeName, {
        Object? arguments,
        bool removeAll = true,
      }) async {
    return navigator?.pushNamedAndRemoveUntil<T>(
      routeName,
      removeAll ? (route) => false : (route) => route.isFirst,
      arguments: arguments,
    );
  }

  // // العودة للخلف
  // static void goBack([dynamic result]) {
  //   if (navigatorKey.currentState!.canPop()) {
  //     navigatorKey.currentState!.pop(result);
  //   }
  // }

  /// Go back to previous screen
  static void goBack<T>([T? result]) {
    if (canGoBack()) {
      navigator?.pop<T>(result);
    }
  }

  /// Check if can go back
  static bool canGoBack() {
    return navigator?.canPop() ?? false;
  }

  /// Pop until specific route
  static void popUntil(String routeName) {
    navigator?.popUntil(
          (route) => route.settings.name == routeName,
    );
  }



  // ============= Error Navigation =============

  /// Navigate to under construction screen
  static Future<void> navigateToUnderConstruction({
    String? featureName,
  }) async {
    return navigateTo(
      AppRoutes.underConstruction,
      arguments: featureName,
    );
  }

  /// Navigate to 404 not found screen
  static Future<void> navigateToNotFound({
    String? attemptedRoute,
  }) async {
    return navigateTo(
      AppRoutes.notFound,
      arguments: attemptedRoute,
    );
  }

  /// Navigate to error screen
  static Future<void> navigateToError({
    String? errorMessage,
  }) async {
    return navigateTo(
      AppRoutes.error,
      arguments: errorMessage,
    );
  }

  // ============= Dialog Navigation =============

  /// Show dialog
  static Future<T?> showDialogWidget<T>(Widget dialog) async {
    return showDialog<T>(
      context: currentContext!,
      builder: (_) => dialog,
    );
  }

  /// Show bottom sheet
  static Future<T?> showBottomSheetWidget<T>(Widget bottomSheet) async {
    return showModalBottomSheet<T>(
      context: currentContext!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => bottomSheet,
    );
  }

  /// Show snackbar
  static void showSnackBar(
      String message, {
        SnackBarType type = SnackBarType.info,
        Duration duration = const Duration(seconds: 3),
      }) {
    final context = currentContext;
    if (context == null) return;

    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
        break;
      case SnackBarType.info:
        backgroundColor = Colors.blue;
        icon = Icons.info;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

/// SnackBar types
enum SnackBarType {
  success,
  error,
  warning,
  info,
}