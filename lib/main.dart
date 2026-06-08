import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_colors.dart';
import 'presentation/screens/main_layout.dart';

void main() {
  runApp(const DaynPayApp());
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
          home: const MainLayout(),
        );
      },
    );
  }
}