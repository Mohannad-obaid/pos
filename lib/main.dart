import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pos/presentation/screens/settings/widgets/app_lock_wrapper.dart';
import 'core/theme/app_colors.dart';
import 'presentation/screens/main_layout.dart';
import 'config/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSignIn.instance.initialize(
    serverClientId: '602671754555-ba5h8366sufstehlfd77l805bl0ma7kv.apps.googleusercontent.com', // 602671754555-jlq0ll72em551qsatu9qldm3etp6ce72.apps.googleusercontent.com
  );

  runApp(
    const ProviderScope(
      child: DaynPayApp(),
    ),
  );
}

class DaynPayApp extends StatelessWidget {
  const DaynPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    // تحديد أبعاد الشاشة المرجعية (عادة بناءً على تصميم Figma/Tailwind)
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DaynPay',
          // دعم اللغة العربية
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar', 'AE')],
          locale: const Locale('ar', 'AE'),
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme), // استخدمنا Cairo كبديل لـ Hanken Grotesk بدعم عربي ممتاز
            useMaterial3: true,
          ),

          navigatorKey: NavigationService.navigatorKey,

          // 2. ربط مسار البداية
          initialRoute: AppRoutes.splash, // أو splash

          // 3. ربط مولد المسارات
          onGenerateRoute: RouteGenerator.generateRoute,

          // home: const MainLayout(),

          builder: (context, child) {
            // child هنا يمثل الـ Navigator وكل الشاشات التي بداخله
            return AppLockWrapper(
              child: child!,
            );
          },
        );
      },
    );
  }
}