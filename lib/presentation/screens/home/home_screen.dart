// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pos/config/routes/app_routes.dart';
// import 'package:pos/config/routes/navigation_service.dart';
// import '../../../core/theme/app_colors.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//             _buildTotalDebtCard(),
//             SizedBox(height: 24.h),
//             _buildQuickActions(),
//             SizedBox(height: 24.h),
//             _buildRecentCustomers(),
//             SizedBox(height: 24.h),
//             _buildRecentTransactions(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 1. AppBar
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: AppColors.surface,
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1.0),
//         child: Container(
//           color: AppColors.outlineVariant.withOpacity(0.5),
//           height: 1.0,
//         ),
//       ),
//       title: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: AppColors.primary,
//             radius: 18.r,
//             child: Text(
//               'MT',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(width: 12.w),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'متجر محمد',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.onSurface,
//                 ),
//               ),
//               Text(
//                 'اليوم، الثلاثاء',
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: AppColors.onSurfaceVariant,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(
//             Icons.notifications_none,
//             color: AppColors.onSurfaceVariant,
//             size: 24.sp,
//           ),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.settings_outlined,
//             color: AppColors.onSurfaceVariant,
//             size: 24.sp,
//           ),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }
//
//   // 2. Total Debt Card
//   Widget _buildTotalDebtCard() {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: const Color(0xFFEFF6FF),
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: AppColors.primary.withOpacity(0.1)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'إجمالي الديون المستحقة',
//                     style: TextStyle(
//                       fontSize: 13.sp,
//                       color: AppColors.onSurfaceVariant,
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     '₪ 4,820.00',
//                     style: TextStyle(
//                       fontSize: 32.sp,
//                       fontWeight: FontWeight.bold,
//                       color: const Color(0xFFDC2626),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color: Colors.amber.shade100,
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Text(
//                   '↑ 3 جديد اليوم',
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.amber.shade700,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           Divider(color: AppColors.primary.withOpacity(0.1), height: 1),
//           SizedBox(height: 12.h),
//           Row(
//             children: [
//               Icon(Icons.person_outline, size: 18.sp, color: AppColors.primary),
//               SizedBox(width: 4.w),
//               Text(
//                 '12 زبون',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.primary,
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               Icon(
//                 Icons.receipt_outlined,
//                 size: 18.sp,
//                 color: AppColors.secondary,
//               ),
//               SizedBox(width: 4.w),
//               Text(
//                 '8 فاتورة اليوم',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.secondary,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 3. Quick Actions Grid
//   Widget _buildQuickActions() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       mainAxisSpacing: 12.h,
//       crossAxisSpacing: 12.w,
//       childAspectRatio: 2.2, // لتتناسب مع ارتفاع الكرت
//       children: [
//         _actionButton(
//           Icons.add_card,
//           '+ دين سريع',
//           AppColors.primary,
//           onTap: () {
//             NavigationService.navigateTo(AppRoutes.quickDebt);
//           },
//         ),
//         _actionButton(
//           Icons.post_add,
//           'فاتورة جديدة',
//           AppColors.secondary,
//           onTap: () {
//             NavigationService.navigateTo(AppRoutes.customInvoice);
//           },
//         ),
//         _actionButton(
//           Icons.person_add_alt_1,
//           'إضافة زبون',
//           Colors.purple.shade600,
//           onTap: () {
//             NavigationService.navigateTo(AppRoutes.addCustomer);
//           },
//         ),
//         _actionButton(
//           Icons.payments_outlined,
//           'تسجيل دفعة',
//           Colors.teal.shade600,
//           onTap: () {
//             NavigationService.navigateTo(AppRoutes.paymentEntry);
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _actionButton(
//     IconData icon,
//     String label,
//     Color color, {
//     VoidCallback? onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: AppColors.outlineVariant, width: 0.5),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12.r),
//           onTap: onTap,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, color: color, size: 28.sp),
//               SizedBox(height: 4.h),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.onSurface,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 4. Recent Customers Horizontal List
//   Widget _buildRecentCustomers() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'آخر الزبائن',
//               style: TextStyle(
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.onSurface,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Row(
//                 children: [
//                   Text(
//                     'المزيد',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   Icon(
//                     Icons.arrow_back_ios_new,
//                     size: 14.sp,
//                     color: AppColors.primary,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 12.h),
//         SizedBox(
//           height: 100.h,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               _customerAvatar('أحمد محمود', '₪ 450', isAvatar: true),
//               _customerAvatar('ليلى علي', '₪ 1,200', isAvatar: true),
//               _customerAvatar(
//                 'ياسين صقر',
//                 '₪ 80',
//                 isInitials: true,
//                 initials: 'ي',
//               ),
//               _customerAvatar('سامي كمال', '₪ 310', isAvatar: true),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _customerAvatar(
//     String name,
//     String amount, {
//     bool isAvatar = false,
//     bool isInitials = false,
//     String initials = '',
//   }) {
//     return Container(
//       width: 72.w,
//       margin: EdgeInsets.only(left: 12.w),
//       child: Column(
//         children: [
//           if (isAvatar)
//             CircleAvatar(
//               radius: 24.r,
//               backgroundColor: Colors.grey.shade200,
//               child: Icon(
//                 Icons.person,
//                 color: Colors.grey,
//               ), // Placeholder للصورة
//             )
//           else if (isInitials)
//             CircleAvatar(
//               radius: 24.r,
//               backgroundColor: AppColors.secondaryContainer,
//               child: Text(
//                 initials,
//                 style: TextStyle(
//                   color: AppColors.onSecondaryContainer,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.sp,
//                 ),
//               ),
//             ),
//           SizedBox(height: 6.h),
//           Text(
//             name,
//             style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             amount,
//             style: TextStyle(
//               fontSize: 12.sp,
//               fontWeight: FontWeight.bold,
//               color: AppColors.error,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 5. Recent Transactions
//   Widget _buildRecentTransactions() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'آخر المعاملات',
//           style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: AppColors.onSurface,
//           ),
//         ),
//         SizedBox(height: 12.h),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16.r),
//             border: Border.all(color: AppColors.outlineVariant),
//           ),
//           child: Column(
//             children: [
//               _transactionTile(
//                 'أحمد محمود',
//                 'دين جديد • 10:45 ص',
//                 '₪ 120.00',
//                 AppColors.error,
//               ),
//               Divider(height: 1, color: AppColors.outlineVariant),
//               _transactionTile(
//                 'ليلى علي',
//                 'دفعة مستلمة • 09:20 ص',
//                 '₪ 500.00',
//                 AppColors.secondary,
//               ),
//               Divider(height: 1, color: AppColors.outlineVariant),
//               _transactionTile(
//                 'سامي كمال',
//                 'دين جديد • 08:15 ص',
//                 '₪ 45.00',
//                 AppColors.error,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _transactionTile(
//     String title,
//     String subtitle,
//     String amount,
//     Color amountColor,
//   ) {
//     return ListTile(
//       contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
//       leading: Container(
//         width: 8.w,
//         height: 8.w,
//         decoration: BoxDecoration(color: amountColor, shape: BoxShape.circle),
//       ),
//       minLeadingWidth: 10.w,
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 16.sp,
//           fontWeight: FontWeight.w600,
//           color: AppColors.onSurface,
//         ),
//       ),
//       subtitle: Text(
//         subtitle,
//         style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant),
//       ),
//       trailing: Text(
//         amount,
//         style: TextStyle(
//           fontSize: 16.sp,
//           fontWeight: FontWeight.bold,
//           color: amountColor,
//         ),
//       ),
//       onTap: () {},
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/config/routes/app_routes.dart';
import 'package:pos/config/routes/navigation_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart';
import '../../../providers/repository_providers.dart';

// --- كلاس مساعد لدمج الحركات في الصفحة الرئيسية ---
enum HomeTransactionType { invoice, payment }

class HomeTransaction {
  final String title;
  final String subtitle;
  final double amount;
  final HomeTransactionType type;
  final DateTime date;
  final Color color;

  HomeTransaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.date,
    required this.color,
  });
}
// -------------------------------------------------

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // جلب البيانات من المزودات (نستخدم valueOrNull لنتجنب التعشيق المعقد لـ when)
    final customers = ref.watch(customersListProvider).valueOrNull ?? [];
    final invoices = ref.watch(invoicesListProvider).valueOrNull ?? [];
    final payments = ref.watch(paymentsListProvider).valueOrNull ?? [];

    // --- الحسابات المنطقية ---
    final now = DateTime.now();
    double totalDebt = 0;
    int todayInvoicesCount = 0;
    int newDebtsToday = 0;

    // حساب إجمالي الديون
    for (var c in customers) {
      if (c.totalDebt > 0) totalDebt += c.totalDebt;
    }

    // حساب فواتير وديون اليوم
    for (var inv in invoices) {
      if (inv.date.year == now.year && inv.date.month == now.month && inv.date.day == now.day) {
        todayInvoicesCount++;
        if (inv.status == 'دين' || inv.status == 'Debt' || inv.status == 'آجل') {
          newDebtsToday++;
        }
      }
    }

    // --- تحضير العملاء (الأعلى ديناً لعرضهم في آخر الزبائن) ---
    final sortedCustomers = List<Customer>.from(customers)
      ..sort((a, b) => b.totalDebt.compareTo(a.totalDebt));
    final recentCustomers = sortedCustomers.take(5).toList();

    // --- تحضير آخر المعاملات (دمج الفواتير والدفعات) ---
    final customerMap = {for (var c in customers) c.id: c.name};
    List<HomeTransaction> recentTransactions = [];

    // إضافة الفواتير
    for (var inv in invoices) {
      final cName = inv.customerId != null ? (customerMap[inv.customerId] ?? 'زبون محذوف') : 'زبون نقدي';
      final isDebt = inv.status == 'دين' || inv.status == 'Debt';

      recentTransactions.add(HomeTransaction(
        title: cName,
        subtitle: '${isDebt ? 'دين جديد' : 'فاتورة نقدية'} • ${_formatTime(inv.date)}',
        amount: inv.totalAmount,
        type: HomeTransactionType.invoice,
        date: inv.date,
        color: isDebt ? AppColors.error : AppColors.primary,
      ));
    }

    // إضافة الدفعات
    for (var pay in payments) {
      final cName = customerMap[pay.customerId] ?? 'زبون محذوف';
      recentTransactions.add(HomeTransaction(
        title: cName,
        subtitle: 'دفعة مستلمة • ${_formatTime(pay.date)}',
        amount: pay.amount,
        type: HomeTransactionType.payment,
        date: pay.date,
        color: AppColors.secondary,
      ));
    }

    // ترتيب المعاملات بالأحدث وأخذ أول 3 فقط
    recentTransactions.sort((a, b) => b.date.compareTo(a.date));
    final topTransactions = recentTransactions.take(3).toList();

    final storeName = ref.watch(storeNameProvider);

    return Scaffold(
      appBar: _buildAppBar(storeName),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          bottom: 100.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalDebtCard(totalDebt, newDebtsToday, customers.length, todayInvoicesCount),
            SizedBox(height: 24.h),
            _buildQuickActions(),
            SizedBox(height: 24.h),
            _buildRecentCustomers(recentCustomers),
            SizedBox(height: 24.h),
            _buildRecentTransactions(topTransactions),
          ],
        ),
      ),
    );
  }

  // 1. AppBar
  PreferredSizeWidget _buildAppBar(String storeName) {
    // تحديد اليوم الحالي بالعربية
    final now = DateTime.now();
    const days = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
    final todayStr = 'اليوم، ${days[now.weekday - 1]}';

    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.outlineVariant.withOpacity(0.5),
          height: 1.0,
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 18.r,
            child: Text(
              'MT', // يمكن جعلها ديناميكية لو كان هناك إعدادات للمتجر
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                storeName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                todayStr,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
      leading: SizedBox(),
      leadingWidth: 2.w,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: AppColors.onSurfaceVariant, size: 24.sp),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings_outlined, color: AppColors.onSurfaceVariant, size: 24.sp),
          onPressed: () {
            NavigationService.navigateTo(AppRoutes.settings);
          },
        ),
      ],
    );
  }

  // 2. Total Debt Card
  Widget _buildTotalDebtCard(double totalDebt, int newDebts, int customersCount, int todayInvoicesCount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إجمالي الديون المستحقة',
                    style: TextStyle(fontSize: 13.sp, color: AppColors.onSurfaceVariant),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '₪ ${totalDebt.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFDC2626),
                    ),
                  ),
                ],
              ),
              if (newDebts > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '↑ $newDebts جديد اليوم',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade700,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.primary.withOpacity(0.1), height: 1),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.person_outline, size: 18.sp, color: AppColors.primary),
              SizedBox(width: 4.w),
              Text(
                '$customersCount زبون',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.receipt_outlined, size: 18.sp, color: AppColors.secondary),
              SizedBox(width: 4.w),
              Text(
                '$todayInvoicesCount فاتورة اليوم',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Quick Actions Grid
  Widget _buildQuickActions() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 2.2,
      children: [
        _actionButton(
          Icons.add_card,
          '+ دين سريع',
          AppColors.primary,
          onTap: () => NavigationService.navigateTo(AppRoutes.quickDebt),
        ),
        _actionButton(
          Icons.post_add,
          'فاتورة جديدة',
          AppColors.secondary,
          onTap: () => NavigationService.navigateTo(AppRoutes.customInvoice),
        ),
        _actionButton(
          Icons.person_add_alt_1,
          'إضافة زبون',
          Colors.purple.shade600,
          onTap: () => NavigationService.navigateTo(AppRoutes.addCustomer),
        ),
        _actionButton(
          Icons.payments_outlined,
          'تسجيل دفعة',
          Colors.teal.shade600,
          onTap: () => NavigationService.navigateTo(AppRoutes.paymentEntry),
        ),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label, Color color, {VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant, width: 0.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28.sp),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 4. Recent Customers Horizontal List
  Widget _buildRecentCustomers(List<Customer> customers) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'آخر الزبائن',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
            ),
            GestureDetector(
              onTap: () {
                NavigationService.navigateTo(AppRoutes.customers);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('المزيد', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  SizedBox(width: 3.w,),
                  Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: customers.isEmpty
              ? Center(child: Text('لا يوجد زبائن بعد', style: TextStyle(color: AppColors.outline)))
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              // استخراج أول حرف من اسم الزبون
              final initials = customer.name.trim().isNotEmpty ? customer.name.trim().substring(0, 1) : '؟';

              return _customerAvatar(
                customer.name,
                '₪ ${customer.totalDebt.toStringAsFixed(0)}',
                initials: initials,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _customerAvatar(String name, String amount, {required String initials}) {
    return Container(
      width: 72.w,
      margin: EdgeInsets.only(left: 12.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.secondaryContainer,
            child: Text(
              initials,
              style: TextStyle(
                color: AppColors.onSecondaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            name.split(' ').first, // عرض الاسم الأول فقط ليتسع المكان
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.error,
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }

  // 5. Recent Transactions
  Widget _buildRecentTransactions(List<HomeTransaction> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'آخر المعاملات',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: transactions.isEmpty
              ? Padding(
            padding: EdgeInsets.all(24.w),
            child: Center(child: Text('لا توجد معاملات مسجلة بعد', style: TextStyle(color: AppColors.outline))),
          )
              : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: AppColors.outlineVariant),
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return _transactionTile(
                tx.title,
                tx.subtitle,
                '₪ ${tx.amount.toStringAsFixed(2)}',
                tx.color,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _transactionTile(String title, String subtitle, String amount, Color amountColor) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(color: amountColor, shape: BoxShape.circle),
      ),
      minLeadingWidth: 10.w,
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant),
      ),
      trailing: Text(
        amount,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: amountColor),
        textDirection: TextDirection.ltr,
      ),
      onTap: () {},
    );
  }

  // دالة مساعدة لتنسيق الوقت (ص/م)
  String _formatTime(DateTime date) {
    int hour = date.hour;
    String amPm = 'ص';
    if (hour >= 12) {
      amPm = 'م';
      if (hour > 12) hour -= 12;
    }
    if (hour == 0) hour = 12;
    return "$hour:${date.minute.toString().padLeft(2, '0')} $amPm";
  }
}