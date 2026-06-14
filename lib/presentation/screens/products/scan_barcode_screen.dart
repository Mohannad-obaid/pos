// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../core/theme/app_colors.dart';
//
// class ScanBarcodeScreen extends StatelessWidget {
//   const ScanBarcodeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Camera Simulation Background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//
//           // Scanner Overlay (Cutout)
//           ColorFiltered(
//             colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOut),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(color: Colors.black, backgroundBlendMode: BlendMode.dstOut),
//                 ),
//                 Center(
//                   child: Container(
//                     width: 260.w,
//                     height: 260.w,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16.r),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Scanner Frame & Animated Line
//           Center(
//             child: SizedBox(
//               width: 260.w,
//               height: 260.w,
//               child: Stack(
//                 children: [
//                   _buildCornerScanner(),
//                   // Simulated Scan Line
//                   Positioned(
//                     top: 130.w, // في الواقع يجب تحريكها بـ AnimationController
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       height: 2.h,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         boxShadow: [BoxShadow(color: Colors.green, blurRadius: 8, spreadRadius: 2)],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Instruction Text
//           Positioned(
//             top: MediaQuery.of(context).size.height / 2 + 150.h,
//             left: 0,
//             right: 0,
//             child: Text(
//               'ضع الباركود داخل الإطار',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.white70, fontSize: 14.sp),
//             ),
//           ),
//
//           // Top App Bar Over Camera
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () {},
//                       style: IconButton.styleFrom(backgroundColor: Colors.white24),
//                     ),
//                     Text('Scan Barcode', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
//                     IconButton(
//                       icon: const Icon(Icons.flashlight_on, color: Colors.white),
//                       onPressed: () {},
//                       style: IconButton.styleFrom(backgroundColor: Colors.white24),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Bottom Sheet
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 40.h),
//               decoration: BoxDecoration(
//                 color: AppColors.surfaceContainerLowest,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('آخر منتج ممسوح:', style: TextStyle(fontSize: 13.sp, color: AppColors.onSurfaceVariant)),
//                   SizedBox(height: 8.h),
//                   Container(
//                     padding: EdgeInsets.all(12.w),
//                     decoration: BoxDecoration(
//                       color: AppColors.surfaceContainerLow,
//                       borderRadius: BorderRadius.circular(12.r),
//                       border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 48.w,
//                           height: 48.w,
//                           decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(8.r)),
//                           child: Icon(Icons.inventory_2, color: AppColors.primary),
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('كولا 330ml', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
//                               Text('₪5.50', style: TextStyle(fontSize: 14.sp, color: AppColors.primary)),
//                             ],
//                           ),
//                         ),
//                         ElevatedButton.icon(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
//                           ),
//                           onPressed: () {},
//                           icon: Text('أضف', style: TextStyle(color: Colors.white)),
//                           label: Icon(Icons.north_east, color: Colors.white, size: 16.sp),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'أدخل الباركود يدوياً',
//                             suffixIcon: Icon(Icons.keyboard, color: AppColors.onSurfaceVariant),
//                             filled: true,
//                             fillColor: AppColors.surfaceContainerLow,
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8.w),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.surfaceVariant,
//                           foregroundColor: AppColors.onSurfaceVariant,
//                           padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
//                         ),
//                         onPressed: () {},
//                         child: Text('بحث يدوي'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Custom frame corners
//   Widget _buildCornerScanner() {
//     return CustomPaint(
//       size: Size.infinite,
//       painter: ScannerCornersPainter(),
//     );
//   }
// }
//
// class ScannerCornersPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.green
//       ..strokeWidth = 3.0
//       ..style = PaintingStyle.stroke;
//
//     const double length = 24.0;
//     // Top Left
//     canvas.drawPath(Path()..moveTo(0, length)..lineTo(0, 0)..lineTo(length, 0), paint);
//     // Top Right
//     canvas.drawPath(Path()..moveTo(size.width - length, 0)..lineTo(size.width, 0)..lineTo(size.width, length), paint);
//     // Bottom Left
//     canvas.drawPath(Path()..moveTo(0, size.height - length)..lineTo(0, size.height)..lineTo(length, size.height), paint);
//     // Bottom Right
//     canvas.drawPath(Path()..moveTo(size.width - length, size.height)..lineTo(size.width, size.height)..lineTo(size.width, size.height - length), paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/routes/navigation_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/repository_providers.dart'; // مسار كلاس Product

class ScanBarcodeScreen extends ConsumerStatefulWidget {
  /// إذا كانت true، فإن الشاشة ستغلق وتُرجع الباركود فقط (تُستخدم عند إضافة منتج جديد).
  /// إذا كانت false، ستعمل كشاشة كاشير تضيف المنتجات للسلة.
  final bool returnBarcodeOnly;

  const ScanBarcodeScreen({super.key, this.returnBarcodeOnly = false});

  @override
  ConsumerState<ScanBarcodeScreen> createState() => _ScanBarcodeScreenState();
}

class _ScanBarcodeScreenState extends ConsumerState<ScanBarcodeScreen> with SingleTickerProviderStateMixin {
  late MobileScannerController _cameraController;
  late AnimationController _animationController;
  final TextEditingController _manualController = TextEditingController();

  bool _isProcessing = false;
  bool _isTorchOn = false;
  String _lastScannedBarcode = '';
  Product? _lastScannedProduct;

  @override
  void initState() {
    super.initState();
    // 1. إعداد كاميرا المسح
    _cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates, // التقاط الباركود مرة واحدة
      facing: CameraFacing.back,
    );

    // 2. إعداد حركة خط المسح الأخضر (يصعد ويهبط كل ثانيتين)
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _animationController.dispose();
    _manualController.dispose();
    super.dispose();
  }

  // 3. دالة معالجة الباركود عند التقاطه أو إدخاله يدوياً
  Future<void> _processBarcode(String barcode) async {
    if (barcode.isEmpty || _isProcessing) return;

    //إذا كانت الشاشة مفتوحة من صفحة "إضافة منتج"، أرجع الرقم فوراً
    // if (widget.returnBarcodeOnly) {
    //   NavigationService.goBack(result: barcode);
    //   return;
    // }

    // إذا كان نفس الباركود السابق، لا داعي للبحث عنه مرة أخرى فوراً
    if (barcode == _lastScannedBarcode) return;

    setState(() {
      _isProcessing = true;
      _lastScannedBarcode = barcode;
    });

    try {
      // البحث عن المنتج في قاعدة البيانات الحقيقية
      final product = await ref.read(productRepositoryProvider).watchProductByBarcode(barcode).first;

      setState(() {
        _lastScannedProduct = product;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _lastScannedProduct = null;
        _isProcessing = false;
      });
    }
  }

  // دالة إضافة المنتج للسلة
  void _addToCart(Product product) {
    ref.read(cartProvider.notifier).addProduct(product);
    NavigationService.showSnackBar('تم إضافة ${product.name} للسلة', type: SnackBarType.success);

    // تفريغ البيانات للتهيؤ للمنتج التالي
    setState(() {
      _lastScannedBarcode = '';
      _lastScannedProduct = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. الكاميرا
          MobileScanner(
            controller: _cameraController,
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                _processBarcode(barcodes.first.rawValue!);
              }
            },
          ),

          // 2. التظليل
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOut),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.black, backgroundBlendMode: BlendMode.dstOut),
                ),
                Container(
                  margin: EdgeInsets.only(right: 50, top: 150, left: 50, bottom: 70),
                  width: 260.w,
                  height: 260.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ],
            ),
          ),

          // 3. إطار المسح والخط المتحرك
          Container(
            margin: EdgeInsets.only(right: 50, top: 150, left: 50, bottom: 70),
            child: SizedBox(
              width: 260.w,
              height: 260.w,
              child: Stack(
                children: [
                  _buildCornerScanner(),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Positioned(
                        top: _animationController.value * (260.w - 4.h),
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2.h,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            boxShadow: [BoxShadow(color: Colors.green, blurRadius: 8, spreadRadius: 2)],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // 4. النص الإرشادي
          Positioned(
            top: MediaQuery.of(context).size.height / 2 + 100.h,
            left: 0,
            right: 0,
            child: Text(
              _isProcessing ? 'جاري البحث...' : 'ضع الباركود داخل الإطار',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
            ),
          ),

          // 5. شريط الأزرار العلوي
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
                      onPressed: () => NavigationService.goBack(),
                      style: IconButton.styleFrom(backgroundColor: Colors.white24),
                    ),
                    Text('مسح الباركود', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: Icon(_isTorchOn ? Icons.flashlight_off : Icons.flashlight_on, color: Colors.white),
                      onPressed: () {
                        _cameraController.toggleTorch();
                        setState(() => _isTorchOn = !_isTorchOn);
                      },
                      style: IconButton.styleFrom(backgroundColor: Colors.white24),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 6. اللوحة السفلية (تُرسم قبل الشريط العائم ليكون هو فوقها)
          if (!widget.returnBarcodeOnly)
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
                    Text('نتيجة المسح:', style: TextStyle(fontSize: 13.sp, color: AppColors.onSurfaceVariant)),
                    SizedBox(height: 8.h),
                    _buildScanResult(),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _manualController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'أدخل الباركود يدوياً',
                              suffixIcon: const Icon(Icons.keyboard, color: AppColors.onSurfaceVariant),
                              filled: true,
                              fillColor: AppColors.surfaceContainerLow,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none),
                            ),
                            onSubmitted: (value) => _processBarcode(value),
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
                          onPressed: () => _processBarcode(_manualController.text.trim()),
                          child: const Text('بحث'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // 7. الشريط العائم (آخر عنصر في الـ Stack ليكون في أعلى طبقة وفوق اللوحة السفلية)
          _buildFloatingCartBar(),
        ],
      ),
    );
  }

  // تم تصحيح المعادلة الرياضية ومسافة الطفو (bottom)
  Widget _buildFloatingCartBar() {
    final cartItems = ref.watch(cartProvider);

    // إخفاء الشريط إذا السلة فاضية
    if (cartItems.isEmpty) return const SizedBox.shrink();

    final int totalCount = cartItems.fold(0, (sum, item) => sum + item.quantity);
    // تم تصحيح المعادلة هنا لتجنب تضاعف السعر
    final double totalPrice = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

    return Positioned(
      // تم رفع الـ bottom إلى 270 ليكون واضحاً فوق الـ Bottom Sheet
      bottom: widget.returnBarcodeOnly ? 24.h : 270.h,
      left: 16.w,
      right: 16.w,
      child: GestureDetector(
        onTap: () => NavigationService.navigateTo(AppRoutes.cart),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // عداد المنتجات
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '$totalCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'عرض السلة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // المجموع + سهم
              Row(
                children: [
                  Text(
                    '₪${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14.sp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // رسم نتيجة المسح ديناميكياً
  Widget _buildScanResult() {
    if (_lastScannedBarcode.isEmpty) {
      return Container(
        padding: EdgeInsets.all(16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        ),
        child: Text('بانتظار قراءة باركود...', style: TextStyle(color: AppColors.outline)),
      );
    }

    if (_lastScannedProduct == null) {
      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.errorContainer,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.error.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('منتج غير مسجل', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black )), //AppColors.onErrorContainer
                SizedBox(height: 4.h,),
                Text('الباركود: $_lastScannedBarcode', style: TextStyle(fontSize: 12.sp, color: Colors.black)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, foregroundColor: Colors.white),
              onPressed: () {
                NavigationService.navigateTo(AppRoutes.addProduct);
              },
              child: const Text('إضافة للمخزن'),
            ),
          ],
        ),
      );
    }

    // المنتج موجود بالفعل
    return Container(
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
                Text(_lastScannedProduct!.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                Text('₪${_lastScannedProduct!.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 14.sp, color: AppColors.primary)),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            ),
            onPressed: () => _addToCart(_lastScannedProduct!),
            icon: const Text('أضف', style: TextStyle(color: Colors.white)),
            label: Icon(Icons.north_east, color: Colors.white, size: 16.sp),
          ),
        ],
      ),
    );
  }

  // زوايا الإطار (كما تفضلت بتصميمها)
  Widget _buildCornerScanner() {
    return CustomPaint(
      size: Size.infinite,
      painter: ScannerCornersPainter(),
    );
  }

  Widget _buildFloatingCartBar1() {
    final cartItems = ref.watch(cartProvider);

    // إخفاء الشريط إذا السلة فاضية
    if (cartItems.isEmpty) return const SizedBox.shrink();

    final int totalCount = cartItems.fold(0, (sum, item) => sum + item.quantity);
    final double totalPrice = cartItems.fold(0.0, (sum, item) => sum + (item.totalPrice * item.quantity));

    return Positioned(
      // يظهر فوق الـ Bottom Sheet مباشرة
      bottom: widget.returnBarcodeOnly ? 24.h : 220.h,
      left: 16.w,
      right: 16.w,
      child: GestureDetector(
        onTap: () => NavigationService.navigateTo(AppRoutes.cart),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // عداد المنتجات
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '$totalCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'عرض السلة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // المجموع + سهم
              Row(
                children: [
                  Text(
                    '₪${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14.sp),
                ],
              ),
            ],
          ),
        ),
      ),
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
    canvas.drawPath(Path()..moveTo(0, length)..lineTo(0, 0)..lineTo(length, 0), paint);
    canvas.drawPath(Path()..moveTo(size.width - length, 0)..lineTo(size.width, 0)..lineTo(size.width, length), paint);
    canvas.drawPath(Path()..moveTo(0, size.height - length)..lineTo(0, size.height)..lineTo(length, size.height), paint);
    canvas.drawPath(Path()..moveTo(size.width - length, size.height)..lineTo(size.width, size.height)..lineTo(size.width, size.height - length), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}