import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

final securityServiceProvider = Provider<SecurityService>((ref) {
  return SecurityService();
});

class SecurityService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  // --- دوال الـ PIN المشفر ---
  Future<void> savePin(String pin) async {
    await _secureStorage.write(key: 'secure_pin', value: pin);
  }

  Future<String?> getPin() async {
    return await _secureStorage.read(key: 'secure_pin');
  }

  Future<void> deletePin() async {
    await _secureStorage.delete(key: 'secure_pin');
    await setBiometricEnabled(false); // تعطيل البصمة عند حذف الـ PIN
  }

  // --- دوال البصمة ---
  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'قم بتأكيد هويتك لفتح التطبيق',
        biometricOnly: true, // استخدام البصمة/الوجه فقط بدلاً من الرمز
        persistAcrossBackgrounding: true, // هذا هو البديل لـ stickyAuth في نسختك (لإبقاء المصادقة تعمل حتى لو راح التطبيق للخلفية ثواني)
      );
    } catch (e) {
      print('Biometric auth error: $e');
      return false;
    }
  }

  // حفظ حالة تفعيل البصمة (هذه يمكن حفظها في Secure Storage أو SharedPreferences)
  Future<void> setBiometricEnabled(bool isEnabled) async {
    await _secureStorage.write(key: 'biometric_enabled', value: isEnabled.toString());
  }

  Future<bool> isBiometricEnabled() async {
    final value = await _secureStorage.read(key: 'biometric_enabled');
    return value == 'true';
  }

  // أضف هذه الدوال داخل كلاس SecurityService في ملف security_service.dart

  Future<void> setAutoLockTimeout(int minutes) async {
    await _secureStorage.write(key: 'auto_lock_timeout', value: minutes.toString());
  }

  Future<int> getAutoLockTimeout() async {
    final val = await _secureStorage.read(key: 'auto_lock_timeout');
    // الافتراضي دقيقة واحدة إذا لم يحدد المستخدم
    return int.tryParse(val ?? '1') ?? 1;
  }
}