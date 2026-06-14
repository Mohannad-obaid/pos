// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../providers/repository_providers.dart';
//
// class SettingsScreen extends ConsumerStatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends ConsumerState<SettingsScreen> {
//   final TextEditingController _nameController = TextEditingController();
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   void _editStoreNameDialog() {
//     final currentName = ref.read(storeNameProvider);
//     _nameController.text = currentName;
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('تغيير اسم المتجر'),
//         content: TextField(
//           controller: _nameController,
//           decoration: const InputDecoration(hintText: 'أدخل الاسم الجديد'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('إلغاء'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_nameController.text.isNotEmpty) {
//                 ref
//                     .read(storeNameProvider.notifier)
//                     .updateName(_nameController.text);
//                 Navigator.pop(context);
//               }
//             },
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final storeName = ref.watch(storeNameProvider);
//
//     return Scaffold(
//       backgroundColor: AppColors.surfaceBright,
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.only(
//           left: 16.w,
//           right: 16.w,
//           top: 16.h,
//           bottom: 100.h,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: _editStoreNameDialog,
//               child: _buildStoreProfile(storeName),
//             ),
//             SizedBox(height: 24.h),
//
//             // القسم 1: المتجر
//             _buildSettingsGroup(
//               title: 'المتجر',
//               items: [
//                 _SettingsItem(title: 'العملة', value: '₪ شيكل'),
//                 _SettingsItem(
//                   title: 'لغة التطبيق',
//                   value: 'العربية',
//                   showBorder: false,
//                 ),
//               ],
//             ),
//             SizedBox(height: 24.h),
//
//             // القسم 2: الأمان
//             _buildSettingsGroup(
//               title: 'الأمان',
//               items: [
//                 _SettingsItem(
//                   title: 'قفل PIN',
//                   isToggle: true,
//                   toggleValue: true,
//                 ),
//                 _SettingsItem(title: 'تغيير PIN'),
//                 _SettingsItem(
//                   title: 'القفل التلقائي بعد',
//                   value: 'فوراً',
//                   showBorder: false,
//                 ),
//               ],
//             ),
//             SizedBox(height: 24.h),
//
//             // القسم 3: وضع التطبيق
//             _buildAppModeSection(),
//             SizedBox(height: 24.h),
//
//             // القسم 4: النسخ الاحتياطي
//             _buildSettingsGroup(
//               title: 'النسخ الاحتياطي',
//               items: [
//                 _SettingsItem(title: 'تكرار النسخ', value: 'يدوي'),
//                 _SettingsItem(
//                   title: 'مكان النسخ التلقائي',
//                   value: 'التنزيلات',
//                   showBorder: false,
//                 ),
//               ],
//               bottomWidget: Padding(
//                 padding: EdgeInsets.all(16.w),
//                 child: Center(
//                   child: Text(
//                     'نسخ الآن',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 24.h),
//
//             // القسم 5: حول التطبيق
//             _buildSettingsGroup(
//               title: 'حول التطبيق',
//               items: [
//                 _SettingsItem(
//                   title: 'الإصدار',
//                   value: '1.0.0',
//                   showChevron: false,
//                 ),
//                 _SettingsItem(
//                   title: 'مسح جميع البيانات',
//                   titleColor: AppColors.error,
//                   showChevron: false,
//                   showBorder: false,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: AppColors.surfaceBright,
//       elevation: 0,
//       centerTitle: true,
//       title: Text(
//         'الإعدادات',
//         style: TextStyle(
//           fontSize: 20.sp,
//           fontWeight: FontWeight.bold,
//           color: AppColors.primary,
//         ),
//       ),
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back, color: AppColors.primary),
//         onPressed: () => Navigator.pop(context),
//       ),
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1.0),
//         child: Container(
//           color: AppColors.outlineVariant.withOpacity(0.5),
//           height: 1.0,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStoreProfile(String storeName) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 28.r,
//             backgroundColor: AppColors.primaryContainer,
//             child: Text(
//               storeName.isNotEmpty ? storeName[0] : 'م',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(width: 16.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   storeName,
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.onSurface,
//                   ),
//                 ),
//                 Text(
//                   'اضغط لتعديل الاسم',
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: AppColors.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Icon(Icons.edit, size: 16.sp, color: AppColors.outline),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSettingsGroup({
//     required String title,
//     required List<_SettingsItem> items,
//     Widget? bottomWidget,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: AppColors.onSurfaceVariant,
//             ),
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             color: AppColors.surfaceContainerLowest,
//             borderRadius: BorderRadius.circular(16.r),
//             border: Border.all(color: AppColors.outlineVariant),
//           ),
//           child: Column(
//             children: [
//               ...items.map((item) => _buildItemTile(item)),
//               if (bottomWidget != null) bottomWidget,
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildItemTile(_SettingsItem item) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//       decoration: BoxDecoration(
//         border: item.showBorder
//             ? Border(
//                 bottom: BorderSide(
//                   color: AppColors.outlineVariant.withOpacity(0.5),
//                 ),
//               )
//             : null,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             item.title,
//             style: TextStyle(
//               fontSize: 16.sp,
//               color: item.titleColor ?? AppColors.onSurface,
//             ),
//           ),
//           Row(
//             children: [
//               if (item.value != null)
//                 Text(
//                   item.value!,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: AppColors.onSurfaceVariant,
//                   ),
//                 ),
//               if (item.isToggle)
//                 SizedBox(
//                   height: 24.h,
//                   child: Switch(
//                     value: item.toggleValue,
//                     activeColor: AppColors.primaryContainer,
//                     onChanged: (val) {},
//                   ),
//                 ),
//               if (item.showChevron && !item.isToggle) ...[
//                 SizedBox(width: 8.w),
//                 Icon(
//                   Icons.arrow_forward_ios,
//                   size: 14.sp,
//                   color: AppColors.outline,
//                 ),
//               ],
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAppModeSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//           child: Text(
//             'وضع التطبيق',
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: AppColors.onSurfaceVariant,
//             ),
//           ),
//         ),
//         _modeCard('بسيط', 'تتبع الديون فقط', Icons.bolt, false),
//         SizedBox(height: 12.h),
//         _modeCard('متقدم', 'POS + منتجات + فواتير', Icons.storefront, false),
//         SizedBox(height: 12.h),
//         _modeCard('هجين', 'الاثنان معاً', Icons.sync, true),
//       ],
//     );
//   }
//
//   Widget _modeCard(
//     String title,
//     String subtitle,
//     IconData icon,
//     bool isSelected,
//   ) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: isSelected
//             ? AppColors.primaryContainer.withOpacity(0.05)
//             : AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: isSelected
//               ? AppColors.primaryContainer
//               : AppColors.outlineVariant,
//           width: isSelected ? 2 : 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20.r,
//             backgroundColor: isSelected
//                 ? AppColors.primaryContainer
//                 : AppColors.surfaceContainer,
//             child: Icon(
//               icon,
//               color: isSelected ? Colors.white : AppColors.primary,
//             ),
//           ),
//           SizedBox(width: 16.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.bold,
//                     color: isSelected ? AppColors.primary : AppColors.onSurface,
//                   ),
//                 ),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: isSelected
//                         ? AppColors.primary.withOpacity(0.8)
//                         : AppColors.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: 24.w,
//             height: 24.w,
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? AppColors.primaryContainer
//                   : Colors.transparent,
//               shape: BoxShape.circle,
//               border: isSelected
//                   ? null
//                   : Border.all(color: AppColors.outlineVariant, width: 2),
//             ),
//             child: isSelected
//                 ? Icon(Icons.check, size: 16.sp, color: Colors.white)
//                 : null,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SettingsItem {
//   final String title;
//   final String? value;
//   final bool showChevron;
//   final bool showBorder;
//   final bool isToggle;
//   final bool toggleValue;
//   final Color? titleColor;
//
//   _SettingsItem({
//     required this.title,
//     this.value,
//     this.showChevron = true,
//     this.showBorder = true,
//     this.isToggle = false,
//     this.toggleValue = false,
//     this.titleColor,
//   });
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos/config/routes/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/enums/app_enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/repository_providers.dart';
import '../../../service/security_service.dart';
import '../lock/pin_lock_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();

  // متغيرات الأمان
  bool _isPinEnabled = false;
  bool _isBiometricEnabled = false;
  int _currentTimeout = 1;
  String _appVersion = '';        // ← 1. أضف هذا


  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    debugPrint('Version: ${info.version}');
    debugPrint('BuildNumber: ${info.buildNumber}');
    debugPrint('AppName: ${info.appName}');
    setState(() => _appVersion = info.version.isNotEmpty
        ? '${info.version}+${info.buildNumber}'
        : '1.0.0');
  }

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _loadSecuritySettings();
  }

  Future<void> _loadSecuritySettings() async {
    final security = ref.read(securityServiceProvider);
    final pin = await security.getPin();
    final bioEnabled = await security.isBiometricEnabled();
    final timeout = await security.getAutoLockTimeout();

    setState(() {
      _isPinEnabled = pin != null;
      _isBiometricEnabled = bioEnabled;
      _currentTimeout = timeout;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _editStoreNameDialog() {
    final currentName = ref.read(storeNameProvider);
    _nameController.text = currentName;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تغيير اسم المتجر'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'أدخل الاسم الجديد'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                ref.read(storeNameProvider.notifier).updateName(_nameController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

// --- دوال القفل التلقائي المحدثة ---
  String _getTimeoutLabel(int minutes) {
    if (minutes == 0) return 'فوراً';
    if (minutes == 1) return 'دقيقة واحدة';
    if (minutes == 5) return '5 دقائق';
    if (minutes == 10) return '10 دقائق';
    if (minutes == 15) return '15 دقيقة';
    if (minutes == 30) return 'نصف ساعة';
    return '$minutes دقيقة';
  }

  void _showTimeoutSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حدد مدة القفل التلقائي', style: TextStyle(fontWeight: FontWeight.bold)),
        // استخدمنا SingleChildScrollView لمنع خروج القائمة عن الشاشة
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('فوراً (بمجرد الخروج)'),
                onTap: () => _updateTimeout(0),
              ),
              ListTile(
                title: const Text('بعد دقيقة واحدة'),
                onTap: () => _updateTimeout(1),
              ),
              ListTile(
                title: const Text('بعد 5 دقائق'),
                onTap: () => _updateTimeout(5),
              ),
              ListTile(
                title: const Text('بعد 10 دقائق'),
                onTap: () => _updateTimeout(10),
              ),
              ListTile(
                title: const Text('بعد 15 دقيقة'),
                onTap: () => _updateTimeout(15),
              ),
              ListTile(
                title: const Text('بعد نصف ساعة'),
                onTap: () => _updateTimeout(30),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTimeout(int minutes) async {
    await ref.read(securityServiceProvider).setAutoLockTimeout(minutes);
    setState(() => _currentTimeout = minutes);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _handleClearData() async {
    // 1. تأكيد أولي بـ Dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 28.sp),
            SizedBox(width: 8.w),
            const Text('تحذير هام'),
          ],
        ),
        content: Text(
          'سيتم مسح جميع البيانات نهائياً ولا يمكن التراجع عن هذا الإجراء.',
          style: TextStyle(fontSize: 14.sp, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('متأكد، امسح', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    // 2. تحقق بالبصمة أو رمز الجهاز
    final localAuth = LocalAuthentication();
    final bool canAuth = await localAuth.canCheckBiometrics || await localAuth.isDeviceSupported();

    if (canAuth) {
      try {
        final bool authenticated = await localAuth.authenticate(
          localizedReason: 'أثبت هويتك لمسح جميع البيانات',
          biometricOnly: false,        // ✅ مباشرة بدون options
          persistAcrossBackgrounding: true, // ✅ بدل stickyAuth
        );
        if (!authenticated || !mounted) return;
      } catch (e) {
        debugPrint('Authentication error: $e');
        return; // إلغاء المسح إذا حدث خطأ في المصادقة
      }
    }

    // 3. مسح البيانات
    await _clearAllData();
  }

  Future<void> _clearAllData() async {
    // امسح قاعدة البيانات
    final docDir = await getApplicationDocumentsDirectory();
    final dbFile = File('${docDir.path}/daynpay.db');
    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    // امسح الـ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم مسح جميع البيانات بنجاح'), backgroundColor: Colors.green),
    );

    // ارجع للشاشة الرئيسية (Splash) لبدء التطبيق من جديد نظيفاً
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.splash, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final storeName = ref.watch(storeNameProvider);

    return Scaffold(
      backgroundColor: AppColors.surfaceBright,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _editStoreNameDialog,
              child: _buildStoreProfile(storeName),
            ),
            SizedBox(height: 24.h),

            // القسم 1: المتجر
            _buildSettingsGroup(
              title: 'المتجر',
              items: [
                _SettingsItem(title: 'العملة', value: '₪ شيكل'),
                _SettingsItem(title: 'لغة التطبيق', value: 'العربية', showBorder: false),
              ],
            ),
            SizedBox(height: 24.h),

            // القسم 2: الأمان (المحدث)
            _buildSettingsGroup(
              title: 'الأمان',
              items: [
                _SettingsItem(
                    title: 'قفل PIN',
                    isToggle: true,
                    toggleValue: _isPinEnabled,
                    onToggle: (val) async {
                      if (val) {
                        final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const PinLockScreen(initialMode: PinMode.setup)));
                        if (result == true) setState(() => _isPinEnabled = true);
                      } else {
                        await ref.read(securityServiceProvider).deletePin();
                        setState(() {
                          _isPinEnabled = false;
                          _isBiometricEnabled = false;
                        });
                      }
                    }
                ),
                if (_isPinEnabled)
                  // _SettingsItem(
                  //     title: 'الدخول بالبصمة',
                  //     isToggle: true,
                  //     toggleValue: _isBiometricEnabled,
                  //     onToggle: (val) async {
                  //       final security = ref.read(securityServiceProvider);
                  //       if (val) {
                  //         final isAvailable = await security.isBiometricAvailable();
                  //         if (!isAvailable) {
                  //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا توجد بصمة مفعلة في هاتفك')));
                  //           return;
                  //         }
                  //         final success = await security.authenticateWithBiometrics();
                  //         if (success) {
                  //           await security.setBiometricEnabled(true);
                  //           setState(() => _isBiometricEnabled = true);
                  //         }
                  //       } else {
                  //         await security.setBiometricEnabled(false);
                  //         setState(() => _isBiometricEnabled = false);
                  //       }
                  //     }
                  // ),
                  _SettingsItem(
                      title: 'الدخول بالبصمة',
                      isToggle: true,
                      toggleValue: _isBiometricEnabled,
                      onToggle: (val) async {
                        final security = ref.read(securityServiceProvider);
                        if (val) {
                          final isAvailable = await security.isBiometricAvailable();
                          if (!mounted) return; // حماية للـ context بعد الـ await

                          if (!isAvailable) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('البصمة غير مدعومة أو غير مفعلة في الهاتف')));
                            return;
                          }

                          final success = await security.authenticateWithBiometrics();
                          if (!mounted) return; // حماية للـ context بعد الـ await

                          if (success) {
                            await security.setBiometricEnabled(true);
                            setState(() => _isBiometricEnabled = true);
                          } else {
                            // هاد السطر رح يظهرلك لو النافذة ما فتحت أو البصمة انرفضت
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم الإلغاء أو فشل التعرف على البصمة')));
                          }
                        } else {
                          await security.setBiometricEnabled(false);
                          setState(() => _isBiometricEnabled = false);
                        }
                      }
                  ),
                _SettingsItem(
                  title: 'القفل التلقائي بعد',
                  value: _getTimeoutLabel(_currentTimeout),
                  showBorder: false,
                  onTap: _isPinEnabled ? _showTimeoutSelector : null,
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // القسم 3: وضع التطبيق
            _buildAppModeSection(),
            SizedBox(height: 24.h),

            // القسم 4: النسخ الاحتياطي
            _buildSettingsGroup(
              title: 'النسخ الاحتياطي',
              items: [
                _SettingsItem(title: 'إعدادات النسخ الاحتياطي', value: '',onTap: (){NavigationService.navigateTo(AppRoutes.backup);},),
               // _SettingsItem(title: 'مكان النسخ التلقائي', value: 'التنزيلات', showBorder: false),
              ],
              // bottomWidget: Padding(
              //   padding: EdgeInsets.all(16.w),
              //   child: Center(
              //     child: Text('نسخ الآن', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
              //   ),
              // ),
            ),
            SizedBox(height: 24.h),

            // القسم 5: حول التطبيق
            _buildSettingsGroup(
              title: 'حول التطبيق',
              items: [
                _SettingsItem(title: 'الإصدار', value: _appVersion, showChevron: false),
                // _SettingsItem(title: 'مسح جميع البيانات', titleColor: AppColors.error, showChevron: false, showBorder: false),
                _SettingsItem(
                  title: 'مسح جميع البيانات',
                  titleColor: AppColors.error,
                  showChevron: false,
                  showBorder: false,
                  onTap: _handleClearData, // ← أضف هذا
                ),
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
      leading: IconButton(icon: Icon(Icons.arrow_back, color: AppColors.primary), onPressed: () => Navigator.pop(context)),
      bottom: PreferredSize(preferredSize: const Size.fromHeight(1.0), child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0)),
    );
  }

  Widget _buildStoreProfile(String storeName) {
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
            child: Text(storeName.isNotEmpty ? storeName[0] : 'م', style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(storeName, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                Text('اضغط لتعديل الاسم', style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Icon(Icons.edit, size: 16.sp, color: AppColors.outline),
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
    return InkWell(
      onTap: item.onTap, // تفعيل الضغط على العنصر بالكامل
      child: Container(
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
                      onChanged: item.onToggle, // ربط الـ Switch
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
        _modeCard('متقدم', 'POS + منتجات + فواتير', Icons.storefront, true),
        // SizedBox(height: 12.h),
        // _modeCard('هجين', 'الاثنان معاً', Icons.sync, true),
      ],
    );
  }

  Widget _modeCard(String title, String subtitle, IconData icon, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryContainer.withOpacity(0.05) : AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant, width: isSelected ? 2 : 1),
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
  final Function(bool)? onToggle;
  final VoidCallback? onTap;

  _SettingsItem({
    required this.title,
    this.value,
    this.showChevron = true,
    this.showBorder = true,
    this.isToggle = false,
    this.toggleValue = false,
    this.titleColor,
    this.onToggle,
    this.onTap,
  });
}