import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class ScanBarcodeScreen extends StatelessWidget {
  const ScanBarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Simulation Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Scanner Overlay (Cutout)
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOut),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.black, backgroundBlendMode: BlendMode.dstOut),
                ),
                Center(
                  child: Container(
                    width: 260.w,
                    height: 260.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scanner Frame & Animated Line
          Center(
            child: SizedBox(
              width: 260.w,
              height: 260.w,
              child: Stack(
                children: [
                  _buildCornerScanner(),
                  // Simulated Scan Line
                  Positioned(
                    top: 130.w, // في الواقع يجب تحريكها بـ AnimationController
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        boxShadow: [BoxShadow(color: Colors.green, blurRadius: 8, spreadRadius: 2)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Instruction Text
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 150.h,
            left: 0,
            right: 0,
            child: Text(
              'ضع الباركود داخل الإطار',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
            ),
          ),

          // Top App Bar Over Camera
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {},
                      style: IconButton.styleFrom(backgroundColor: Colors.white24),
                    ),
                    Text('Scan Barcode', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.flashlight_on, color: Colors.white),
                      onPressed: () {},
                      style: IconButton.styleFrom(backgroundColor: Colors.white24),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 40.h),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('آخر منتج ممسوح:', style: TextStyle(fontSize: 13.sp, color: AppColors.onSurfaceVariant)),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(8.r)),
                          child: Icon(Icons.inventory_2, color: AppColors.primary),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('كولا 330ml', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                              Text('₪5.50', style: TextStyle(fontSize: 14.sp, color: AppColors.primary)),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                          ),
                          onPressed: () {},
                          icon: Text('أضف', style: TextStyle(color: Colors.white)),
                          label: Icon(Icons.north_east, color: Colors.white, size: 16.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'أدخل الباركود يدوياً',
                            suffixIcon: Icon(Icons.keyboard, color: AppColors.onSurfaceVariant),
                            filled: true,
                            fillColor: AppColors.surfaceContainerLow,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surfaceVariant,
                          foregroundColor: AppColors.onSurfaceVariant,
                          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        onPressed: () {},
                        child: Text('بحث يدوي'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom frame corners
  Widget _buildCornerScanner() {
    return CustomPaint(
      size: Size.infinite,
      painter: ScannerCornersPainter(),
    );
  }
}

class ScannerCornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    const double length = 24.0;
    // Top Left
    canvas.drawPath(Path()..moveTo(0, length)..lineTo(0, 0)..lineTo(length, 0), paint);
    // Top Right
    canvas.drawPath(Path()..moveTo(size.width - length, 0)..lineTo(size.width, 0)..lineTo(size.width, length), paint);
    // Bottom Left
    canvas.drawPath(Path()..moveTo(0, size.height - length)..lineTo(0, size.height)..lineTo(length, size.height), paint);
    // Bottom Right
    canvas.drawPath(Path()..moveTo(size.width - length, size.height)..lineTo(size.width, size.height)..lineTo(size.width, size.height - length), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}