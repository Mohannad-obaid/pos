// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// class ScannerScreen extends StatefulWidget {
//   const ScannerScreen({super.key});
//
//   @override
//   State<ScannerScreen> createState() => _ScannerScreenState();
// }
//
// class _ScannerScreenState extends State<ScannerScreen> {
//   // متغير لمنع قراءة الباركود أكثر من مرة متتالية
//   bool _isScanned = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('وجّه الكاميرا نحو الباركود'),
//         centerTitle: true,
//       ),
//       body: MobileScanner(
//         // إعدادات الكاميرا والمسح
//         controller: MobileScannerController(
//           detectionSpeed: DetectionSpeed.noDuplicates, // التقاط بدون تكرار
//           facing: CameraFacing.back,
//         ),
//         onDetect: (capture) {
//           if (_isScanned) return; // إذا تم المسح، تجاهل القراءات الإضافية
//
//           final List<Barcode> barcodes = capture.barcodes;
//           if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
//             setState(() {
//               _isScanned = true;
//             });
//
//             final String code = barcodes.first.rawValue!;
//
//             // إغلاق الشاشة وإرسال الرقم الملتقط للشاشة السابقة
//             Navigator.pop(context, code);
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart'; // تأكد من مسار الألوان لديك

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

// أضفنا SingleTickerProviderStateMixin لتشغيل الأنيميشن (خط الليزر)
class _ScannerScreenState extends State<ScannerScreen> with SingleTickerProviderStateMixin {
  bool _isScanned = false;
  late MobileScannerController _cameraController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // إعداد متحكم الكاميرا
    _cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );

    // إعداد أنيميشن خط المسح (يتحرك كل ثانيتين صعوداً وهبوطاً)
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // حجم مربع المسح
    final double scanAreaSize = 250.w;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. الكاميرا في الخلفية
          MobileScanner(
            controller: _cameraController,
            onDetect: (capture) {
              if (_isScanned) return;

              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                setState(() {
                  _isScanned = true;
                });

                final String code = barcodes.first.rawValue!;
                Navigator.pop(context, code);
              }
            },
          ),

          // 2. تظليل الشاشة (Overlay) مع ترك مربع شفاف في المنتصف
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Center(
                  child: Container(
                    height: scanAreaSize,
                    width: scanAreaSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. تصميم زوايا المربع (Corners) وخط المسح المتحرك
          Center(
            child: SizedBox(
              height: scanAreaSize,
              width: scanAreaSize,
              child: Stack(
                children: [
                  // زوايا المربع
                  _buildCorners(),

                  // خط المسح المتحرك (الليزر)
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Positioned(
                        top: _animationController.value * (scanAreaSize - 4.h),
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.5),
                                blurRadius: 10.r,
                                spreadRadius: 2.r,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // 4. أزرار التحكم العلوية (رجوع، فلاش، تبديل الكاميرا)
          Positioned(
            top: 50.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // زر الرجوع
                _buildControlButton(
                  icon: Icons.close,
                  onTap: () => Navigator.pop(context),
                ),
                Row(
                  children: [
                    // زر تشغيل الفلاش
                    _buildControlButton(
                      icon: Icons.flash_on,
                      onTap: () => _cameraController.toggleTorch(),
                    ),
                    SizedBox(width: 16.w),
                    // زر تبديل الكاميرا (أمامي/خلفي)
                    _buildControlButton(
                      icon: Icons.flip_camera_ios,
                      onTap: () => _cameraController.switchCamera(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 5. نص إرشادي في الأسفل
          Positioned(
            bottom: 80.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Icon(Icons.qr_code_scanner, color: Colors.white70, size: 40.sp),
                SizedBox(height: 16.h),
                Text(
                  'وجّه الكاميرا نحو الباركود للمسح',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لرسم الأزرار العلوية بخلفية شبه شفافة
  Widget _buildControlButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white30, width: 1),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 24.sp),
        onPressed: onTap,
      ),
    );
  }

  // دالة مساعدة لرسم زوايا المربع (ستايل الكاميرا الاحترافي)
  Widget _buildCorners() {
    final double cornerLength = 30.w;
    final double cornerThickness = 4.w;
    final Color cornerColor = AppColors.primary;

    return Stack(
      children: [
        // الزاوية أعلى اليسار
        Positioned(
          top: 0, left: 0,
          child: _corner(cornerLength, cornerThickness, cornerColor, isTop: true, isLeft: true),
        ),
        // الزاوية أعلى اليمين
        Positioned(
          top: 0, right: 0,
          child: _corner(cornerLength, cornerThickness, cornerColor, isTop: true, isLeft: false),
        ),
        // الزاوية أسفل اليسار
        Positioned(
          bottom: 0, left: 0,
          child: _corner(cornerLength, cornerThickness, cornerColor, isTop: false, isLeft: true),
        ),
        // الزاوية أسفل اليمين
        Positioned(
          bottom: 0, right: 0,
          child: _corner(cornerLength, cornerThickness, cornerColor, isTop: false, isLeft: false),
        ),
      ],
    );
  }

  Widget _corner(double length, double thickness, Color color, {required bool isTop, required bool isLeft}) {
    return Column(
      crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        if (isTop) Container(width: length, height: thickness, color: color),
        Container(width: thickness, height: length - thickness, color: color),
        if (!isTop) Container(width: length, height: thickness, color: color),
      ],
    );
  }
}