// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final backupServiceProvider = Provider<BackupService>((ref) => BackupService());
//
// final lastBackupDateProvider = FutureProvider<DateTime?>((ref) async {
//   return ref.read(backupServiceProvider).getLastBackupDate();
// });
//
// final driveBackupsProvider = FutureProvider<List<drive.File>>((ref) async {
//   return ref.read(backupServiceProvider).listDriveBackups();
// });
//
// class BackupService {
//   final String dbName = 'daynpay.db';
//   static const String _lastBackupKey = 'last_backup_date';
//   static const String _driveFolderName = 'Kashier_Backups';
//
//   // ✅ v7 — استخدم instance
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//
//   // ── تسجيل الدخول (v7 API) ────────────────────────────
//   // Future<GoogleSignInAccount?> _getSignedInAccount() async {
//   //   try {
//   //     // حاول صامت أولاً
//   //     _googleSignIn.attemptLightweightAuthentication();
//   //
//   //     // انتظر نتيجة الـ authentication
//   //     final event = await _googleSignIn.authenticationEvents
//   //         .firstWhere((e) =>
//   //     e is GoogleSignInAuthenticationEventSignIn ||
//   //         e is GoogleSignInAuthenticationEventSignOut)
//   //         .timeout(const Duration(seconds: 3));
//   //
//   //     if (event is GoogleSignInAuthenticationEventSignIn) {
//   //       return event.user;
//   //     }
//   //   } catch (_) {
//   //     // الصامت فشل، جرب الكامل
//   //   }
//   //
//   //   try {
//   //     await _googleSignIn.authenticate();
//   //     final event = await _googleSignIn.authenticationEvents
//   //         .firstWhere((e) => e is GoogleSignInAuthenticationEventSignIn)
//   //         .timeout(const Duration(seconds: 30));
//   //
//   //     if (event is GoogleSignInAuthenticationEventSignIn) {
//   //       return event.user;
//   //     }
//   //   } catch (e) {
//   //     debugPrint('Google Sign-In error: $e');
//   //   }
//   //
//   //   return null;
//   // }
//
//   // ── الحصول على Auth Headers ──────────────────────────
// // ✅ الطريقة الصحيحة في v7
//
//   Future<GoogleSignInAccount?> _getSignedInAccount() async {
//     try {
//       // لازم initialize أولاً — استدعيها مرة واحدة في main
//       final account = await _googleSignIn.attemptLightweightAuthentication();
//       if (account != null) return account;
//     } catch (_) {}
//
//     try {
//       return await _googleSignIn.authenticate(
//         scopeHint: [drive.DriveApi.driveFileScope],
//       );
//     } catch (e) {
//       debugPrint('Sign-In error: $e');
//       return null;
//     }
//   }
//
//
//
//
//   Future<Map<String, String>?> _getAuthHeaders(GoogleSignInAccount account) async {
//     try {
//       final headers = await account.authorizationClient.authorizationHeaders(
//         [drive.DriveApi.driveFileScope],
//         promptIfNecessary: true,
//       );
//       return headers;
//     } catch (e) {
//       debugPrint('Auth headers error: $e');
//       return null;
//     }
//   }
//
//   // ── 1. نسخة محلية ────────────────────────────────────
//   Future<File?> createLocalBackup() async {
//     try {
//       final dbFile = await _getDatabaseFile();
//       if (!await dbFile.exists()) return null;
//
//       if (await Permission.storage.request().isGranted ||
//           await Permission.manageExternalStorage.request().isGranted) {
//
//         Directory downloadsDirectory;
//         if (Platform.isAndroid) {
//           downloadsDirectory = Directory('/storage/emulated/0/Download');
//         } else {
//           downloadsDirectory = await getApplicationDocumentsDirectory();
//         }
//
//         final backupDir = Directory('${downloadsDirectory.path}/Kashier_Backups');
//         if (!await backupDir.exists()) await backupDir.create(recursive: true);
//
//         final timestamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
//         final backupFile = File('${backupDir.path}/kashier_backup_$timestamp.db');
//
//         await dbFile.copy(backupFile.path);
//         await _cleanOldLocalBackups(backupDir);
//
//         debugPrint('✅ نسخ محلي: ${backupFile.path}');
//         return backupFile;
//       }
//       return null;
//     } catch (e) {
//       debugPrint('Local backup error: $e');
//       return null;
//     }
//   }
//
//   // ── 2. رفع لـ Google Drive ───────────────────────────
//   Future<bool> backupToGoogleDrive() async {
//     try {
//       final account = await _getSignedInAccount();
//       if (account == null) return false;
//
//       final headers = await _getAuthHeaders(account);
//       if (headers == null) return false;
//
//       final client = GoogleAuthClient(headers);
//       final driveApi = drive.DriveApi(client);
//
//       final folderId = await _getOrCreateDriveFolder(driveApi);
//
//       final localBackup = await createLocalBackup();
//       if (localBackup == null) {
//         client.close();
//         return false;
//       }
//
//       final timestamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
//       final driveFile = drive.File()
//         ..name = 'kashier_backup_$timestamp.db'
//         ..parents = [folderId];
//
//       await driveApi.files.create(
//         driveFile,
//         uploadMedia: drive.Media(
//           localBackup.openRead(),
//           await localBackup.length(),
//         ),
//       );
//
//       await _cleanOldDriveBackups(driveApi, folderId);
//       await _saveLastBackupDate();
//
//       client.close();
//       debugPrint('✅ رُفع إلى Drive');
//       return true;
//     } catch (e) {
//       debugPrint('Drive backup error: $e');
//       return false;
//     }
//   }
//
//   // ── 3. استعادة من Drive ───────────────────────────────
//   Future<bool> restoreFromGoogleDrive(String fileId) async {
//     try {
//       final account = await _getSignedInAccount();
//       if (account == null) return false;
//
//       final headers = await _getAuthHeaders(account);
//       if (headers == null) return false;
//
//       final client = GoogleAuthClient(headers);
//       final driveApi = drive.DriveApi(client);
//
//       final response = await driveApi.files.get(
//         fileId,
//         downloadOptions: drive.DownloadOptions.fullMedia,
//       ) as drive.Media;
//
//       final dbFile = await _getDatabaseFile();
//       final bytes = <int>[];
//       await for (final chunk in response.stream) {
//         bytes.addAll(chunk);
//       }
//       await dbFile.writeAsBytes(bytes);
//
//       client.close();
//       return true;
//     } catch (e) {
//       debugPrint('Restore error: $e');
//       return false;
//     }
//   }
//
//   // ── 4. قائمة النسخ في Drive ──────────────────────────
//   Future<List<drive.File>> listDriveBackups() async {
//     try {
//       final account = await _getSignedInAccount();
//       if (account == null) return [];
//
//       final headers = await _getAuthHeaders(account);
//       if (headers == null) return [];
//
//       final client = GoogleAuthClient(headers);
//       final driveApi = drive.DriveApi(client);
//
//       final folderId = await _getOrCreateDriveFolder(driveApi);
//       final fileList = await driveApi.files.list(
//         q: "'$folderId' in parents and trashed=false",
//         orderBy: 'createdTime desc',
//         $fields: 'files(id, name, createdTime, size)',
//       );
//
//       client.close();
//       return fileList.files ?? [];
//     } catch (e) {
//       debugPrint('List backups error: $e');
//       return [];
//     }
//   }
//
//   // ── Helpers ───────────────────────────────────────────
//   Future<File> _getDatabaseFile() async {
//     final docDir = await getApplicationDocumentsDirectory();
//     return File('${docDir.path}/$dbName');
//   }
//
//   Future<void> _cleanOldLocalBackups(Directory dir) async {
//     final files = dir.listSync()
//       ..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
//     if (files.length > 7) {
//       for (final file in files.skip(7)) await file.delete();
//     }
//   }
//
//   Future<String> _getOrCreateDriveFolder(drive.DriveApi api) async {
//     final existing = await api.files.list(
//       q: "name='$_driveFolderName' and mimeType='application/vnd.google-apps.folder' and trashed=false",
//       $fields: 'files(id)',
//     );
//     if (existing.files != null && existing.files!.isNotEmpty) {
//       return existing.files!.first.id!;
//     }
//
//     final folder = drive.File()
//       ..name = _driveFolderName
//       ..mimeType = 'application/vnd.google-apps.folder';
//     final created = await api.files.create(folder);
//     return created.id!;
//   }
//
//   Future<void> _cleanOldDriveBackups(drive.DriveApi api, String folderId) async {
//     final files = await api.files.list(
//       q: "'$folderId' in parents and trashed=false",
//       orderBy: 'createdTime desc',
//       $fields: 'files(id)',
//     );
//     final allFiles = files.files ?? [];
//     if (allFiles.length > 10) {
//       for (final file in allFiles.skip(10)) {
//         await api.files.delete(file.id!);
//       }
//     }
//   }
//
//   Future<void> _saveLastBackupDate() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_lastBackupKey, DateTime.now().toIso8601String());
//   }
//
//   Future<DateTime?> getLastBackupDate() async {
//     final prefs = await SharedPreferences.getInstance();
//     final saved = prefs.getString(_lastBackupKey);
//     return saved != null ? DateTime.parse(saved) : null;
//   }
// }
//
// // ── HTTP Client ───────────────────────────────────────
// class GoogleAuthClient extends http.BaseClient {
//   final Map<String, String> _headers;
//   final http.Client _client = http.Client();
//
//   GoogleAuthClient(this._headers);
//
//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     return _client.send(request..headers.addAll(_headers));
//   }
//
//   @override
//   void close() => _client.close();
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

// ── Keys ──────────────────────────────────────────────
const String _keyLastBackup = 'last_backup_date';
const String _keyAutoBackupEnabled = 'auto_backup_enabled';
const String _keyAutoBackupDays = 'auto_backup_days';
const String _keySignedInEmail = 'signed_in_email'; // ✅ حفظ الحساب
const String _driveFolderName = 'Kashier_Backups';
const String _autoBackupTask = 'kashier_auto_backup';

// ── Providers ─────────────────────────────────────────
final backupServiceProvider = Provider<BackupService>((ref) => BackupService());

final lastBackupDateProvider = FutureProvider<DateTime?>((ref) async {
  return ref.read(backupServiceProvider).getLastBackupDate();
});

final driveBackupsProvider = FutureProvider<List<drive.File>>((ref) async {
  return ref.read(backupServiceProvider).listDriveBackups();
});

final signedInAccountProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_keySignedInEmail);
});

final autoBackupSettingsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'enabled': prefs.getBool(_keyAutoBackupEnabled) ?? false,
    'days': prefs.getInt(_keyAutoBackupDays) ?? 1,
  };
});

// ── WorkManager Dispatcher ────────────────────────────
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == _autoBackupTask) {
      await BackupService().backupToGoogleDrive();
    }
    return true;
  });
}

class BackupService {
  final String dbName = 'daynpay.db';
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  GoogleSignInAccount? _cachedAccount; // ✅ cache الحساب في الـ session

  // ── تسجيل الدخول مع الحفظ ──────────────────────────
  Future<GoogleSignInAccount?> _getSignedInAccount({bool forceNew = false}) async {
    // إذا عندنا حساب محفوظ في الـ session، ارجعه مباشرة
    if (_cachedAccount != null && !forceNew) return _cachedAccount;

    try {
      // جرب صامت أولاً (يرجع الحساب السابق بدون popup)
      final account = await _googleSignIn.attemptLightweightAuthentication();
      if (account != null) {
        _cachedAccount = account;
        await _saveSignedInEmail(account.email);
        return account;
      }
    } catch (_) {}

    // إذا فشل الصامت، افتح شاشة الاختيار
    try {
      final account = await _googleSignIn.authenticate(
        scopeHint: [drive.DriveApi.driveFileScope],
      );
      _cachedAccount = account;
      await _saveSignedInEmail(account.email);
      return account;
    } catch (e) {
      debugPrint('Sign-In error: $e');
      return null;
    }
  }

  Future<void> _saveSignedInEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySignedInEmail, email);
  }

  Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySignedInEmail);
  }

  // تسجيل خروج وإزالة الحساب المحفوظ
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _cachedAccount = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySignedInEmail);
  }

  Future<Map<String, String>?> _getAuthHeaders(GoogleSignInAccount account) async {
    try {
      return await account.authorizationClient.authorizationHeaders(
        [drive.DriveApi.driveFileScope],
        promptIfNecessary: true,
      );
    } catch (e) {
      debugPrint('Auth headers error: $e');
      return null;
    }
  }

  // ── 1. نسخة محلية ────────────────────────────────────
  Future<File?> createLocalBackup() async {
    try {
      final dbFile = await _getDatabaseFile();
      if (!await dbFile.exists()) return null;

      if (await Permission.storage.request().isGranted ||
          await Permission.manageExternalStorage.request().isGranted) {

        Directory downloadsDir;
        if (Platform.isAndroid) {
          downloadsDir = Directory('/storage/emulated/0/Download');
        } else {
          downloadsDir = await getApplicationDocumentsDirectory();
        }

        final backupDir = Directory('${downloadsDir.path}/Kashier_Backups');
        if (!await backupDir.exists()) await backupDir.create(recursive: true);

        final timestamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
        final backupFile = File('${backupDir.path}/kashier_backup_$timestamp.db');
        await dbFile.copy(backupFile.path);
        await _cleanOldLocalBackups(backupDir);

        return backupFile;
      }
      return null;
    } catch (e) {
      debugPrint('Local backup error: $e');
      return null;
    }
  }

  // ── 2. رفع لـ Google Drive ───────────────────────────
  Future<bool> backupToGoogleDrive({bool forceNewAccount = false}) async {
    try {
      final account = await _getSignedInAccount(forceNew: forceNewAccount);
      if (account == null) return false;

      final headers = await _getAuthHeaders(account);
      if (headers == null) return false;

      final client = GoogleAuthClient(headers);
      final driveApi = drive.DriveApi(client);
      final folderId = await _getOrCreateDriveFolder(driveApi);

      final localBackup = await createLocalBackup();
      if (localBackup == null) { client.close(); return false; }

      final timestamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
      await driveApi.files.create(
        drive.File()
          ..name = 'kashier_backup_$timestamp.db'
          ..parents = [folderId],
        uploadMedia: drive.Media(localBackup.openRead(), await localBackup.length()),
      );

      await _cleanOldDriveBackups(driveApi, folderId);
      await _saveLastBackupDate();
      client.close();
      return true;
    } catch (e) {
      debugPrint('Drive backup error: $e');
      return false;
    }
  }

  // ── 3. استعادة من Drive ───────────────────────────────
  Future<bool> restoreFromGoogleDrive(String fileId) async {
    try {
      final account = await _getSignedInAccount();
      if (account == null) return false;

      final headers = await _getAuthHeaders(account);
      if (headers == null) return false;

      final client = GoogleAuthClient(headers);
      final driveApi = drive.DriveApi(client);

      final response = await driveApi.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final dbFile = await _getDatabaseFile();
      final bytes = <int>[];
      await for (final chunk in response.stream) { bytes.addAll(chunk); }
      await dbFile.writeAsBytes(bytes);

      client.close();
      return true;
    } catch (e) {
      debugPrint('Restore error: $e');
      return false;
    }
  }

  // ── 4. استعادة من ملف محلي ✅ جديد ──────────────────
  Future<bool> restoreFromLocalFile(String filePath) async {
    try {
      final backupFile = File(filePath);
      if (!await backupFile.exists()) return false;

      final dbFile = await _getDatabaseFile();
      await backupFile.copy(dbFile.path);
      return true;
    } catch (e) {
      debugPrint('Local restore error: $e');
      return false;
    }
  }

  // جلب النسخ المحلية المتاحة ✅ جديد
  Future<List<File>> listLocalBackups() async {
    try {
      Directory downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      final backupDir = Directory('${downloadsDir.path}/Kashier_Backups');
      if (!await backupDir.exists()) return [];

      final files = backupDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.db'))
          .toList()
        ..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

      return files;
    } catch (e) {
      return [];
    }
  }

  // ── 5. قائمة النسخ في Drive ──────────────────────────
  Future<List<drive.File>> listDriveBackups() async {
    try {
      final account = await _getSignedInAccount();
      if (account == null) return [];

      final headers = await _getAuthHeaders(account);
      if (headers == null) return [];

      final client = GoogleAuthClient(headers);
      final driveApi = drive.DriveApi(client);
      final folderId = await _getOrCreateDriveFolder(driveApi);

      final fileList = await driveApi.files.list(
        q: "'$folderId' in parents and trashed=false",
        orderBy: 'createdTime desc',
        $fields: 'files(id, name, createdTime, size)',
      );

      client.close();
      return fileList.files ?? [];
    } catch (e) {
      debugPrint('List backups error: $e');
      return [];
    }
  }

  // ── 6. إعدادات النسخ التلقائي ✅ جديد ───────────────
  Future<void> setAutoBackup({required bool enabled, required int days}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAutoBackupEnabled, enabled);
    await prefs.setInt(_keyAutoBackupDays, days);

    // إلغاء المهمة القديمة دائماً
    await Workmanager().cancelByUniqueName(_autoBackupTask);

    if (enabled) {
      await Workmanager().registerPeriodicTask(
        _autoBackupTask,
        _autoBackupTask,
        frequency: Duration(days: days),
        initialDelay: Duration(days: days),
        constraints: Constraints(networkType: NetworkType.connected),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
      );
    }
  }

  Future<bool> getAutoBackupEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAutoBackupEnabled) ?? false;
  }

  Future<int> getAutoBackupDays() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyAutoBackupDays) ?? 1;
  }

  // ── Helpers ───────────────────────────────────────────
  Future<File> _getDatabaseFile() async {
    final docDir = await getApplicationDocumentsDirectory();
    return File('${docDir.path}/$dbName');
  }

  Future<void> _cleanOldLocalBackups(Directory dir) async {
    final files = dir.listSync()
      ..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
    if (files.length > 7) {
      for (final file in files.skip(7)) await file.delete();
    }
  }

  Future<String> _getOrCreateDriveFolder(drive.DriveApi api) async {
    final existing = await api.files.list(
      q: "name='$_driveFolderName' and mimeType='application/vnd.google-apps.folder' and trashed=false",
      $fields: 'files(id)',
    );
    if (existing.files?.isNotEmpty == true) return existing.files!.first.id!;

    final created = await api.files.create(
      drive.File()
        ..name = _driveFolderName
        ..mimeType = 'application/vnd.google-apps.folder',
    );
    return created.id!;
  }

  Future<void> _cleanOldDriveBackups(drive.DriveApi api, String folderId) async {
    final files = await api.files.list(
      q: "'$folderId' in parents and trashed=false",
      orderBy: 'createdTime desc',
      $fields: 'files(id)',
    );
    final allFiles = files.files ?? [];
    if (allFiles.length > 10) {
      for (final file in allFiles.skip(10)) await api.files.delete(file.id!);
    }
  }

  Future<void> _saveLastBackupDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastBackup, DateTime.now().toIso8601String());
  }

  Future<DateTime?> getLastBackupDate() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_keyLastBackup);
    return saved != null ? DateTime.parse(saved) : null;
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();
  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      _client.send(request..headers.addAll(_headers));

  @override
  void close() => _client.close();
}