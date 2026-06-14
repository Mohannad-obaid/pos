import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/routes/navigation_service.dart';
import '../../../config/routes/route_arguments.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/repository_providers.dart';

class CustomersListScreen extends ConsumerStatefulWidget {
  const CustomersListScreen({super.key});

  @override
  ConsumerState<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends ConsumerState<CustomersListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // 0: الكل, 1: مديونون, 2: مسددون
  int _selectedFilterIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // جلب البيانات الحية من قاعدة البيانات
    final customersAsync = ref.watch(customersListProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.navigateTo(AppRoutes.addCustomer);
        },
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: AppColors.onPrimary, size: 28.sp),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilters(),
          Expanded(
            child: customersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('حدث خطأ: $error')),
              data: (customers) {
                // 1. تطبيق فلتر البحث (بالاسم أو الرقم)
                var filteredCustomers = customers.where((c) {
                  final matchesName = c.name.toLowerCase().contains(_searchQuery.toLowerCase());
                  final matchesPhone = c.phone?.contains(_searchQuery) ?? false;
                  return matchesName || matchesPhone;
                }).toList();

                // 2. تطبيق فلتر الحالة (مديون / مسدد)
                if (_selectedFilterIndex == 1) {
                  filteredCustomers = filteredCustomers.where((c) => c.totalDebt > 0).toList();
                } else if (_selectedFilterIndex == 2) {
                  filteredCustomers = filteredCustomers.where((c) => c.totalDebt <= 0).toList();
                }

                if (filteredCustomers.isEmpty) {
                  return Center(
                    child: Text('لا يوجد زبائن مطابقين', style: TextStyle(fontSize: 16.sp, color: AppColors.outline)),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 100.h),
                  itemCount: filteredCustomers.length,
                  itemBuilder: (context, index) {
                    final customer = filteredCustomers[index];

                    // 1. استخراج أول حرفين من الاسم للأيقونة
                    final nameParts = customer.name.trim().split(' ');
                    String initials = nameParts.first.substring(0, 1);
                    if (nameParts.length > 1) {
                      initials += nameParts[1].substring(0, 1);
                    }

                    // 2. المنطق الصحيح للحالات الثلاث
                    String stateCustomer;
                    Color avatarBg;
                    Color statusColor;
                    String displayAmount;

                    if (customer.totalDebt > 0) {
                      stateCustomer = 'مديون';
                      displayAmount = '₪ ${customer.totalDebt.toStringAsFixed(2)}';
                      avatarBg = AppColors.errorContainer;
                      statusColor = AppColors.error; // أحمر للديون
                    } else if (customer.totalDebt < 0) {
                      stateCustomer = 'له رصيد';
                      // نضرب في -1 لكي لا يظهر الرصيد بالسالب في الواجهة
                      displayAmount = '₪ ${(customer.totalDebt * -1).toStringAsFixed(2)}';
                      avatarBg = AppColors.primaryContainer;
                      statusColor = AppColors.primary; // أزرق (أو أي لون مناسب) للرصيد الإيجابي
                    } else {
                      stateCustomer = 'مسدد';
                      displayAmount = '₪ 0.00';
                      avatarBg = AppColors.secondaryContainer;
                      statusColor = AppColors.secondary; // أخضر للمسدد بالكامل
                    }

                    // 3. بناء واجهة المستخدم
                    return _buildCustomerTile(
                      name: customer.name,
                      phone: customer.phone ?? 'لا يوجد رقم',
                      initials: initials,
                      avatarBg: avatarBg,
                      statusColor: statusColor,
                      amount: displayAmount,
                      statusText: stateCustomer,
                      onTap: () {
                        NavigationService.navigateTo(
                          AppRoutes.customerDetails,
                          arguments: CustomerDebtsArgs(
                            customerId: customer.id,
                          ),
                        );
                      },
                    );
                  },
                );

                // 3. بناء القائمة الحقيقية
                // return ListView.builder(
                //   padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 100.h),
                //   itemCount: filteredCustomers.length,
                //   itemBuilder: (context, index) {
                //     final customer = filteredCustomers[index];
                //
                //     // استخراج أول حرفين من الاسم للأيقونة
                //     final nameParts = customer.name.trim().split(' ');
                //     String initials = nameParts.first.substring(0, 1);
                //     if (nameParts.length > 1) {
                //       initials += nameParts[1].substring(0, 1);
                //     }
                //
                //     var stateCustumer = '--';
                //     if(customer.totalDebt > 0){
                //       stateCustumer = 'مديون';
                //     }else if(customer.totalDebt < 0){
                //       stateCustumer = 'مسدد';
                //     } else {
                //       stateCustumer = 'له رصيد';
                //     }
                //     final hasDebt = customer.totalDebt > 0;
                //
                //     return _buildCustomerTile(
                //       name: customer.name,
                //       phone: customer.phone ?? 'لا يوجد رقم',
                //       initials: initials,
                //       avatarBg: hasDebt ? AppColors.errorContainer : AppColors.secondaryContainer,
                //       statusColor: hasDebt ? AppColors.error : AppColors.secondary,
                //       amount: '₪ ${customer.totalDebt.toStringAsFixed(2)}',
                //       statusText: stateCustumer, //hasDebt ? 'مديون' : 'مسوّى',
                //       onTap: () {
                //         // تمرير البيانات الحقيقية لشاشة التفاصيل
                //         NavigationService.navigateTo(
                //           AppRoutes.customerDetails,
                //           arguments: CustomerDebtsArgs(
                //             customerId: customer.id,
                //           ),
                //         );
                //       },
                //     );
                //   },
                // );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        'الزبائن',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        onPressed: () => NavigationService.goBack(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'ابحث بالاسم أو الهاتف...',
            hintStyle: TextStyle(color: AppColors.outline, fontSize: 14.sp),
            prefixIcon: Icon(Icons.search, color: AppColors.onSurfaceVariant, size: 20.sp),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
              icon: Icon(Icons.clear, size: 20.sp),
              onPressed: () {
                _searchController.clear();
                setState(() => _searchQuery = '');
              },
            )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _buildFilterChip('الكل', index: 0),
          SizedBox(width: 8.w),
          _buildFilterChip('مديونون', index: 1),
          SizedBox(width: 8.w),
          _buildFilterChip('مسددون', index: 2),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {required int index}) {
    final isSelected = _selectedFilterIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilterIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.outlineVariant.withOpacity(0.5),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
              ),
            ),
            if (isSelected) ...[
              SizedBox(width: 4.w),
              Icon(Icons.check, color: AppColors.onPrimaryContainer, size: 16.sp),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerTile({
    required String name,
    required String phone,
    required String initials,
    required Color avatarBg,
    required Color statusColor,
    required String amount,
    required String statusText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.outlineVariant, width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 21.r,
                  backgroundColor: avatarBg,
                  child: Text(
                    initials,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: statusColor),
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                    Text(phone, style: TextStyle(fontSize: 13.sp, color: AppColors.outline)),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(amount, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: statusColor)),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: statusColor),
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