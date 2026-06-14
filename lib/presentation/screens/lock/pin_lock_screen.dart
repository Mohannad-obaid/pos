import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/enums/app_enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../service/security_service.dart'; // تأكد من مسار مزود خدمة الأمان


class PinLockScreen extends ConsumerStatefulWidget {
  final PinMode initialMode;

  const PinLockScreen({super.key, required this.initialMode});

  @override
  ConsumerState<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends ConsumerState<PinLockScreen> {
  String _enteredPin = '';
  String _firstPinForSetup = '';
  late PinMode _currentMode;
  bool _showBiometricIcon = false;

  @override
  void initState() {
    super.initState();
    _currentMode = widget.initialMode;
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    if (_currentMode == PinMode.unlock) {
      final security = ref.read(securityServiceProvider);
      final isEnabled = await security.isBiometricEnabled();

      if (isEnabled) {
        setState(() => _showBiometricIcon = true);
        _triggerBiometricAuth();
      }
    }
  }

  Future<void> _triggerBiometricAuth() async {
    final security = ref.read(securityServiceProvider);
    final success = await security.authenticateWithBiometrics();
    if (success && mounted) {
      Navigator.pop(context, true);
    }
  }

  void _onNumPressed(String num) {
    if (_enteredPin.length < 4) {
      setState(() => _enteredPin += num);
      if (_enteredPin.length == 4) _processFullPin();
    }
  }

  void _onBackspacePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(() => _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1));
    }
  }

  void _processFullPin() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final security = ref.read(securityServiceProvider);

    if (_currentMode == PinMode.setup) {
      setState(() {
        _firstPinForSetup = _enteredPin;
        _enteredPin = '';
        _currentMode = PinMode.confirm;
      });
    } else if (_currentMode == PinMode.confirm) {
      if (_enteredPin == _firstPinForSetup) {
        await security.savePin(_enteredPin);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تعيين الرمز السري بنجاح'), backgroundColor: Colors.green),
          );
          Navigator.pop(context, true);
        }
      } else {
        _showError('الرمز غير متطابق، حاول مرة أخرى');
        setState(() {
          _enteredPin = '';
          _currentMode = PinMode.setup;
        });
      }
    } else if (_currentMode == PinMode.unlock) {
      final savedPin = await security.getPin();
      if (_enteredPin == savedPin) {
        if (mounted) Navigator.pop(context, true);
      } else {
        _showError('الرمز خاطئ');
        setState(() => _enteredPin = '');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error, duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = _currentMode == PinMode.setup ? 'إعداد رمز PIN' : (_currentMode == PinMode.confirm ? 'تأكيد الرمز' : 'أدخل رمز PIN');
    String subtitle = _currentMode == PinMode.setup ? 'أدخل 4 أرقام لحماية التطبيق' : (_currentMode == PinMode.confirm ? 'أدخل الرمز مرة أخرى للتأكيد' : 'لفتح تطبيق DaynPay');

    // تغليف الشاشة بـ PopScope لمنع الرجوع من أزرار الهاتف الفعليا
    return PopScope(
      // إذا كان الوضع "فتح القفل"، نمنع الرجوع (false). في أي وضع آخر نسمح به (true)
      canPop: _currentMode != PinMode.unlock,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop && _currentMode == PinMode.unlock) {
          // لم يتم الرجوع لأن التطبيق مقفل
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يجب إدخال الرمز')));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surfaceBright,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: _currentMode == PinMode.unlock
              ? const SizedBox() // إخفاء زر الرجوع عند الفتح الإجباري
              : IconButton(icon: Icon(Icons.close, color: AppColors.onSurface), onPressed: () => Navigator.pop(context, false)),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Icon(Icons.lock_outline, size: 48.sp, color: AppColors.primary),
              SizedBox(height: 16.h),
              Text(title, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              SizedBox(height: 8.h),
              Text(subtitle, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index < _enteredPin.length ? AppColors.primary : Colors.transparent,
                      border: Border.all(color: index < _enteredPin.length ? AppColors.primary : AppColors.outlineVariant, width: 2),
                    ),
                  );
                }),
              ),
              const Spacer(),
              _buildNumpad(),
              SizedBox(height: 48.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumpad() {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'bio', '0', '⌫'];

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: keys.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
          ),
          itemBuilder: (context, index) {
            final key = keys[index];
      
            if (key == 'bio') {
              return _showBiometricIcon
                  ? InkWell(
                onTap: _triggerBiometricAuth,
                borderRadius: BorderRadius.circular(40.r),
                child: Center(child: Icon(Icons.fingerprint, size: 36.sp, color: AppColors.primary)),
              )
                  : const SizedBox();
            }
      
            final isBackspace = key == '⌫';
            return InkWell(
              onTap: isBackspace ? _onBackspacePressed : () => _onNumPressed(key),
              borderRadius: BorderRadius.circular(40.r),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.surfaceContainerLowest),
                child: Center(
                  child: isBackspace
                      ? Icon(Icons.backspace_outlined, size: 28.sp, color: AppColors.onSurfaceVariant)
                      : Text(key, style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}