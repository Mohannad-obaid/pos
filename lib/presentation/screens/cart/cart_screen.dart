import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // بيانات وهمية لمحاكاة السلة
  final List<Map<String, dynamic>> _cartItems = [
    {'title': 'كولا 330ml', 'price': 5.00, 'qty': 1},
    {'title': 'خبز تنور', 'price': 4.50, 'qty': 2},
    {'title': 'شيبس', 'price': 3.00, 'qty': 3},
    {'title': 'ماء 1.5L', 'price': 7.00, 'qty': 1},
  ];

  double get _totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['qty']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: _cartItems.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return _buildCartItem(item, index);
              },
            ),
          ),
          _buildBottomSummary(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surfaceContainerLowest,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        onPressed: () {},
      ),
      title: Row(
        children: [
          Text('السلة', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '${_cartItems.length} منتجات',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.onPrimaryContainer),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.delete_outline, color: AppColors.onSurfaceVariant, size: 24.sp),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: ValueKey(item['title']),
      direction: DismissDirection.startToEnd,
      background: Container(
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24.w),
        child: Icon(Icons.delete, color: Colors.white, size: 28.sp),
      ),
      onDismissed: (direction) {
        setState(() {
          _cartItems.removeAt(index);
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            // أزرار الكمية
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.outlineVariant),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  _qtyButton(Icons.remove, () {
                    if (item['qty'] > 1) setState(() => item['qty']--);
                  }, isRemove: item['qty'] == 1),
                  SizedBox(
                    width: 24.w,
                    child: Text(
                      '${item['qty']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _qtyButton(Icons.add, () => setState(() => item['qty']++)),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // تفاصيل المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  Text('₪ ${item['price'].toStringAsFixed(2)}', style: TextStyle(fontSize: 13.sp, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            // الإجمالي للمنتج
            Text(
              '₪ ${(item['price'] * item['qty']).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap, {bool isRemove = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: isRemove ? AppColors.error.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: isRemove ? AppColors.error : AppColors.onSurface,
        ),
      ),
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(top: BorderSide(color: AppColors.outlineVariant)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_cartItems.length} منتجات · قبل الضريبة: ₪ ${_totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                    SizedBox(height: 4.h),
                    Text('المجموع:', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                  ],
                ),
                Text(
                  '₪ ${_totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(color: AppColors.outlineVariant.withValues(alpha: 0.3), height: 1),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: AppColors.outline),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    onPressed: () {
                      setState(() => _cartItems.clear());
                    },
                    child: Icon(Icons.delete_sweep, color: AppColors.onSurfaceVariant),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      elevation: 4,
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('إتمام الشراء', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}