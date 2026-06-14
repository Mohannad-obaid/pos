// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
//
// // تأكد من صحة مسارات الاستيراد لديك
// import '../../../../core/theme/app_colors.dart';
// import '../../../../service/backup_service.dart';
//
// class BackupRestoreScreen extends ConsumerStatefulWidget {
//   const BackupRestoreScreen({super.key});
//
//   @override
//   ConsumerState<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
// }
//
// class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
//   bool _isBackingUp = false;
//   String? _restoringFileId;
//
//   // دالة تنسيق حجم الملف
//   String _formatBytes(int? bytes) {
//     if (bytes == null) return 'غير معروف';
//     if (bytes < 1024) return '$bytes B';
//     if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
//     return '${(bytes / 1048576).toStringAsFixed(2)} MB';
//   }
//
//   // دالة النسخ الاحتياطي اليدوي
//   Future<void> _handleBackup() async {
//     setState(() => _isBackingUp = true);
//     final service = ref.read(backupServiceProvider);
//
//     final success = await service.backupToGoogleDrive();
//
//     setState(() => _isBackingUp = false);
//
//     if (mounted) {
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('تم أخذ النسخة الاحتياطية بنجاح ☁️'), backgroundColor: Colors.green),
//         );
//         // تحديث البيانات في الشاشة
//         ref.invalidate(lastBackupDateProvider);
//         ref.invalidate(driveBackupsProvider);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('فشل النسخ الاحتياطي، تأكد من اتصالك بالإنترنت'), backgroundColor: AppColors.error),
//         );
//       }
//     }
//   }
//
//   // دالة الاستعادة مع نافذة التحذير
//   Future<void> _handleRestore(drive.File file) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//         title: Row(
//           children: [
//             Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 28.sp),
//             SizedBox(width: 8.w),
//             const Text('تحذير هام'),
//           ],
//         ),
//         content: Text(
//           'هل أنت متأكد من استعادة نسخة (${DateFormat('dd/MM/yyyy').format(file.createdTime ?? DateTime.now())})؟\n\nسيتم مسح جميع البيانات الحالية واستبدالها بهذه النسخة ولا يمكن التراجع عن هذا الإجراء.',
//           style: TextStyle(fontSize: 14.sp, height: 1.5),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('تأكيد الاستعادة', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//
//     if (confirm == true && mounted) {
//       setState(() => _restoringFileId = file.id);
//
//       final service = ref.read(backupServiceProvider);
//       final success = await service.restoreFromGoogleDrive(file.id!);
//
//       setState(() => _restoringFileId = null);
//
//       if (mounted) {
//         if (success) {
//           // إعادة تشغيل التطبيق أو تحديث الـ Database Provider هنا
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('تمت الاستعادة بنجاح! يرجى إعادة تشغيل التطبيق.'), backgroundColor: Colors.green),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('فشلت عملية الاستعادة'), backgroundColor: AppColors.error),
//           );
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final lastBackupAsync = ref.watch(lastBackupDateProvider);
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: const Text('النسخ الاحتياطي والاستعادة'),
//         backgroundColor: AppColors.surfaceBright,
//         elevation: 0,
//         centerTitle: false,
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           ref.invalidate(lastBackupDateProvider);
//           ref.invalidate(driveBackupsProvider);
//         },
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 1. بطاقة الحالة الحالية
//               _buildStatusCard(lastBackupAsync),
//               SizedBox(height: 24.h),
//
//               // 2. قسم أخذ نسخة جديدة
//               _buildCreateBackupSection(),
//               SizedBox(height: 32.h),
//
//               // 3. قسم الاستعادة (من Google Drive)
//               Text(
//                 'النسخ الاحتياطية السحابية (Google Drive)',
//                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
//               ),
//               SizedBox(height: 12.h),
//               _buildDriveBackupsList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatusCard(AsyncValue<DateTime?> lastBackupAsync) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF0FDF4), // لون أخضر فاتح جداً
//         borderRadius: BorderRadius.circular(12.r),
//         border: const Border(right: BorderSide(color: Color(0xFF22C55E), width: 4)),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.check_circle, color: const Color(0xFF22C55E), size: 32.sp),
//           SizedBox(width: 16.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('الحالة الحالية', style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
//                 SizedBox(height: 4.h),
//                 lastBackupAsync.when(
//                   data: (date) => Text(
//                     date != null
//                         ? 'آخر نسخة: ${DateFormat('dd MMM yyyy, hh:mm a', 'ar').format(date)}'
//                         : 'لم يتم إنشاء أي نسخة سحابية بعد',
//                     style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
//                   ),
//                   loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
//                   error: (_, __) => const Text('خطأ في جلب البيانات'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCreateBackupSection() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 48.w, height: 48.w,
//                 decoration: BoxDecoration(
//                   color: AppColors.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Icon(Icons.cloud_upload, color: AppColors.primary, size: 28.sp),
//               ),
//               SizedBox(width: 16.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('إنشاء نسخة سحابية', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//                     Text('سيتم رفع ملف .db إلى Google Drive', style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           SizedBox(
//             width: double.infinity,
//             height: 52.h,
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//                 elevation: 0,
//               ),
//               onPressed: _isBackingUp ? null : _handleBackup,
//               icon: _isBackingUp
//                   ? SizedBox(width: 20.w, height: 20.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                   : const Icon(Icons.backup),
//               label: Text(_isBackingUp ? 'جاري الرفع...' : 'إنشاء نسخة الآن', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDriveBackupsList() {
//     final backupsAsync = ref.watch(driveBackupsProvider);
//
//     return backupsAsync.when(
//       data: (files) {
//         if (files.isEmpty) {
//           return Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 32.h),
//               child: Column(
//                 children: [
//                   Icon(Icons.cloud_off, size: 64.sp, color: Colors.grey[400]),
//                   SizedBox(height: 16.h),
//                   Text('لا توجد نسخ احتياطية على حسابك', style: TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
//                 ],
//               ),
//             ),
//           );
//         }
//
//         return ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: files.length,
//           separatorBuilder: (_, __) => SizedBox(height: 12.h),
//           itemBuilder: (context, index) {
//             final file = files[index];
//             final isThisRestoring = _restoringFileId == file.id;
//
//             return Container(
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 color: AppColors.surfaceContainerLowest,
//                 borderRadius: BorderRadius.circular(12.r),
//                 border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.description, color: const Color(0xFF0C447C), size: 32.sp),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           file.createdTime != null
//                               ? DateFormat('dd MMM yyyy, hh:mm a', 'ar').format(file.createdTime!)
//                               : 'نسخة غير معروفة',
//                           style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'الحجم: ${_formatBytes(int.tryParse(file.size ?? '0'))}',
//                           style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                   OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: AppColors.primary,
//                       side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
//                     ),
//                     onPressed: (_isBackingUp || _restoringFileId != null) ? null : () => _handleRestore(file),
//                     child: isThisRestoring
//                         ? SizedBox(width: 16.w, height: 16.w, child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2))
//                         : const Text('استعادة'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//       loading: () => const Center(child: Padding(padding: EdgeInsets.all(32.0), child: CircularProgressIndicator())),
//       error: (err, _) => Center(
//         child: Padding(
//           padding: EdgeInsets.all(32.0),
//           child: Text('حدث خطأ أثناء جلب النسخ: $err', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.error)),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import '../../../../core/theme/app_colors.dart';
import '../../../../service/backup_service.dart';

class BackupRestoreScreen extends ConsumerStatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  ConsumerState<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
  bool _isBackingUp = false;
  String? _restoringFileId;
  bool _autoBackupEnabled = false;
  int _autoBackupDays = 1;
  // 0 = Drive, 1 = Local
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _loadAutoBackupSettings();
  }

  Future<void> _loadAutoBackupSettings() async {
    final service = ref.read(backupServiceProvider);
    final enabled = await service.getAutoBackupEnabled();
    final days = await service.getAutoBackupDays();
    if (mounted) setState(() { _autoBackupEnabled = enabled; _autoBackupDays = days; });
  }

  String _formatBytes(int? bytes) {
    if (bytes == null) return 'غير معروف';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1048576).toStringAsFixed(2)} MB';
  }

  String _formatLocalFileName(String path) {
    final name = path.split('/').last;
    // kashier_backup_20250614_1430.db → 14/06/2025 14:30
    try {
      final part = name.replaceAll('kashier_backup_', '').replaceAll('.db', '');
      final date = DateFormat('yyyyMMdd_HHmm').parse(part);
      return DateFormat('dd/MM/yyyy  HH:mm').format(date);
    } catch (_) { return name; }
  }

  // ── النسخ اليدوي ─────────────────────────────────────
  Future<void> _handleBackup() async {
    setState(() => _isBackingUp = true);
    final success = await ref.read(backupServiceProvider).backupToGoogleDrive();
    setState(() => _isBackingUp = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? 'تم الحفظ على Google Drive ☁️' : 'فشل النسخ، تحقق من الاتصال'),
      backgroundColor: success ? Colors.green : AppColors.error,
    ));
    if (success) {
      ref.invalidate(lastBackupDateProvider);
      ref.invalidate(driveBackupsProvider);
    }
  }

  // ── تغيير الحساب ─────────────────────────────────────
  Future<void> _handleChangeAccount() async {
    await ref.read(backupServiceProvider).signOut();
    ref.invalidate(signedInAccountProvider);
    await ref.read(backupServiceProvider).backupToGoogleDrive(forceNewAccount: true);
    ref.invalidate(signedInAccountProvider);
    ref.invalidate(driveBackupsProvider);
  }

  // ── إعدادات النسخ التلقائي ──────────────────────────
  Future<void> _saveAutoBackupSettings() async {
    await ref.read(backupServiceProvider).setAutoBackup(
      enabled: _autoBackupEnabled,
      days: _autoBackupDays,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('تم حفظ إعدادات النسخ التلقائي ✅'),
      backgroundColor: Colors.green,
    ));
  }

  // ── استعادة من Drive ─────────────────────────────────
  Future<void> _handleRestoreDrive(drive.File file) async {
    final confirm = await _showRestoreDialog(
      DateFormat('dd/MM/yyyy').format(file.createdTime ?? DateTime.now()),
    );
    if (confirm != true || !mounted) return;

    setState(() => _restoringFileId = file.id);
    final success = await ref.read(backupServiceProvider).restoreFromGoogleDrive(file.id!);
    setState(() => _restoringFileId = null);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? 'تمت الاستعادة! أعد تشغيل التطبيق.' : 'فشلت الاستعادة'),
      backgroundColor: success ? Colors.green : AppColors.error,
    ));
  }

  // ── استعادة من ملف محلي ──────────────────────────────
  Future<void> _handleRestoreLocal(File file) async {
    final confirm = await _showRestoreDialog(_formatLocalFileName(file.path));
    if (confirm != true || !mounted) return;

    setState(() => _restoringFileId = file.path);
    final success = await ref.read(backupServiceProvider).restoreFromLocalFile(file.path);
    setState(() => _restoringFileId = null);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? 'تمت الاستعادة! أعد تشغيل التطبيق.' : 'فشلت الاستعادة'),
      backgroundColor: success ? Colors.green : AppColors.error,
    ));
  }

  Future<bool?> _showRestoreDialog(String dateLabel) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 28.sp),
          SizedBox(width: 8.w),
          const Text('تحذير هام'),
        ]),
        content: Text(
          'استعادة نسخة ($dateLabel)؟\n\nسيتم مسح جميع البيانات الحالية واستبدالها. لا يمكن التراجع.',
          style: TextStyle(fontSize: 14.sp, height: 1.5),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('تأكيد', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final lastBackupAsync = ref.watch(lastBackupDateProvider);
    final accountAsync = ref.watch(signedInAccountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('النسخ الاحتياطي'),
        backgroundColor: AppColors.surfaceBright,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(lastBackupDateProvider);
          ref.invalidate(driveBackupsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. بطاقة الحساب
              _buildAccountCard(accountAsync),
              SizedBox(height: 16.h),

              // 2. بطاقة الحالة
              _buildStatusCard(lastBackupAsync),
              SizedBox(height: 16.h),

              // 3. نسخ يدوي
              _buildManualBackupSection(),
              SizedBox(height: 16.h),

              // 4. النسخ التلقائي
              _buildAutoBackupSection(),
              SizedBox(height: 24.h),

              // 5. الاستعادة (Drive / محلي)
              _buildRestoreSection(),
            ],
          ),
        ),
      ),
    );
  }

  // ── بطاقة الحساب ─────────────────────────────────────
  Widget _buildAccountCard(AsyncValue<String?> accountAsync) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w, height: 44.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.account_circle, color: AppColors.primary, size: 28.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: accountAsync.when(
              data: (email) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('حساب Google', style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                  Text(
                    email ?? 'لم يتم الربط بعد',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              error: (_, __) => const Text('خطأ'),
            ),
          ),
          TextButton(
            onPressed: _handleChangeAccount,
            child: Text(
              accountAsync.value != null ? 'تغيير' : 'ربط',
              style: TextStyle(color: AppColors.primary, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ── بطاقة الحالة ─────────────────────────────────────
  Widget _buildStatusCard(AsyncValue<DateTime?> lastBackupAsync) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12.r),
        border: const Border(right: BorderSide(color: Color(0xFF22C55E), width: 4)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: const Color(0xFF22C55E), size: 32.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: lastBackupAsync.when(
              data: (date) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('آخر نسخة احتياطية', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                  SizedBox(height: 2.h),
                  Text(
                    date != null
                        ? DateFormat('dd/MM/yyyy  HH:mm').format(date)
                        : 'لم يتم إنشاء أي نسخة بعد',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                  ),
                ],
              ),
              loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              error: (_, __) => const Text('خطأ'),
            ),
          ),
        ],
      ),
    );
  }

  // ── نسخ يدوي ─────────────────────────────────────────
  Widget _buildManualBackupSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.cloud_upload, color: AppColors.primary, size: 24.sp),
            SizedBox(width: 8.w),
            Text('نسخ يدوي', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ]),
          SizedBox(height: 4.h),
          Text('ارفع نسخة الآن إلى Google Drive', style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              onPressed: _isBackingUp ? null : _handleBackup,
              icon: _isBackingUp
                  ? SizedBox(width: 18.w, height: 18.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.backup),
              label: Text(_isBackingUp ? 'جاري الرفع...' : 'إنشاء نسخة الآن',
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // ── النسخ التلقائي ────────────────────────────────────
  Widget _buildAutoBackupSection() {
    final dayOptions = [1, 2, 3, 7, 14, 30];
    final dayLabels = {1: 'يومياً', 2: 'كل يومين', 3: 'كل 3 أيام', 7: 'أسبوعياً', 14: 'كل أسبوعين', 30: 'شهرياً'};

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(Icons.schedule, color: AppColors.secondary, size: 24.sp),
                SizedBox(width: 8.w),
                Text('نسخ تلقائي', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              ]),
              Switch(
                value: _autoBackupEnabled,
                onChanged: (val) => setState(() => _autoBackupEnabled = val),
                activeColor: AppColors.primary,
              ),
            ],
          ),
          if (_autoBackupEnabled) ...[
            SizedBox(height: 12.h),
            Text('تكرار النسخ:', style: TextStyle(fontSize: 13.sp, color: AppColors.onSurfaceVariant)),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: dayOptions.map((days) {
                final selected = _autoBackupDays == days;
                return GestureDetector(
                  onTap: () => setState(() => _autoBackupDays = days),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: selected ? AppColors.primary : AppColors.outlineVariant,
                      ),
                    ),
                    child: Text(
                      dayLabels[days]!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: selected ? Colors.white : AppColors.onSurface,
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
                onPressed: _saveAutoBackupSettings,
                child: Text('حفظ الإعدادات', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── قسم الاستعادة ─────────────────────────────────────
  Widget _buildRestoreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('استعادة نسخة احتياطية',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
        SizedBox(height: 12.h),

        // تاب Drive / محلي
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              _buildTab(0, Icons.cloud, 'Google Drive'),
              _buildTab(1, Icons.phone_android, 'من الجهاز'),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        _selectedTab == 0 ? _buildDriveBackupsList() : _buildLocalBackupsList(),
      ],
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    final selected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18.sp, color: selected ? Colors.white : AppColors.onSurfaceVariant),
              SizedBox(width: 6.w),
              Text(label, style: TextStyle(
                fontSize: 13.sp,
                color: selected ? Colors.white : AppColors.onSurfaceVariant,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              )),
            ],
          ),
        ),
      ),
    );
  }

  // ── قائمة Drive ───────────────────────────────────────
  Widget _buildDriveBackupsList() {
    final backupsAsync = ref.watch(driveBackupsProvider);
    return backupsAsync.when(
      data: (files) => files.isEmpty
          ? _buildEmptyState(Icons.cloud_off, 'لا توجد نسخ على Google Drive')
          : ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: files.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (_, i) => _buildDriveItem(files[i]),
      ),
      loading: () => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())),
      error: (e, _) => _buildEmptyState(Icons.error_outline, 'خطأ في جلب النسخ'),
    );
  }

  Widget _buildDriveItem(drive.File file) {
    final isRestoring = _restoringFileId == file.id;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_done, color: AppColors.primary, size: 28.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.createdTime != null ? DateFormat('dd/MM/yyyy  HH:mm').format(file.createdTime!) : 'غير معروف',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                Text('الحجم: ${_formatBytes(int.tryParse(file.size ?? '0'))}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: (_isBackingUp || _restoringFileId != null) ? null : () => _handleRestoreDrive(file),
            child: isRestoring
                ? SizedBox(width: 16.w, height: 16.w, child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2))
                : const Text('استعادة'),
          ),
        ],
      ),
    );
  }

  // ── قائمة المحلية ─────────────────────────────────────
  Widget _buildLocalBackupsList() {
    return FutureBuilder<List<File>>(
      future: ref.read(backupServiceProvider).listLocalBackups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()));
        }
        final files = snapshot.data ?? [];
        if (files.isEmpty) return _buildEmptyState(Icons.phone_android, 'لا توجد نسخ محلية على الجهاز');

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: files.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (_, i) => _buildLocalItem(files[i]),
        );
      },
    );
  }

  Widget _buildLocalItem(File file) {
    final isRestoring = _restoringFileId == file.path;
    final size = file.lengthSync();
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.storage, color: const Color(0xFF4D556B), size: 28.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_formatLocalFileName(file.path),
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                Text('الحجم: ${_formatBytes(size)}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: (_isBackingUp || _restoringFileId != null) ? null : () => _handleRestoreLocal(file),
            child: isRestoring
                ? SizedBox(width: 16.w, height: 16.w, child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2))
                : const Text('استعادة'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(IconData icon, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          children: [
            Icon(icon, size: 56.sp, color: Colors.grey[400]),
            SizedBox(height: 12.h),
            Text(message, style: TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}