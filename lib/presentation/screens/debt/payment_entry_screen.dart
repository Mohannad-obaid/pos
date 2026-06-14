// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:drift/drift.dart' as drift;
// import '../../../core/theme/app_colors.dart';
// import '../../../data/local/database.dart'; // مسار قاعدة البيانات الخاص بك
// import '../../../providers/repository_providers.dart';
//
// class PaymentEntryScreen extends ConsumerStatefulWidget {
//   final int? customerId; // جعل المعرف اختيارياً لدعم الدخول من الشاشة الرئيسية
//
//   const PaymentEntryScreen({super.key, this.customerId});
//
//   @override
//   ConsumerState<PaymentEntryScreen> createState() => _PaymentEntryScreenState();
// }
//
// class _PaymentEntryScreenState extends ConsumerState<PaymentEntryScreen> {
//   int? _selectedCustomerId; // لتتبع العميل المحدد حالياً في الشاشة
//   double _enteredAmount = 0.0;
//   String _selectedMethod = 'نقد'; // نقد أو تحويل
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _notesController = TextEditingController();
//   bool _isSaving = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // تعيين المعرف القادم للشاشة إن وُجد
//     _selectedCustomerId = widget.customerId;
//   }
//
//   @override
//   void dispose() {
//     _amountController.dispose();
//     _notesController.dispose();
//     super.dispose();
//   }
//
//   void _checkDebt(String value) {
//     setState(() {
//       _enteredAmount = double.tryParse(value) ?? 0.0;
//     });
//   }
//
//   // نافذة سفلية مخصصة لاختيار أو تغيير العميل
//   void _showCustomerSelector() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: AppColors.surfaceContainerLowest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
//       builder: (context) {
//         final customersAsync = ref.watch(customersListProvider);
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(16.w),
//                 child: Text('اختر عميلاً لتسجيل الدفعة', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//               ),
//               Divider(height: 1, color: AppColors.outlineVariant),
//               Expanded(
//                 child: customersAsync.when(
//                   loading: () => const Center(child: CircularProgressIndicator()),
//                   error: (e, _) => Center(child: Text('خطأ في تحميل العملاء: $e')),
//                   data: (customers) {
//                     if (customers.isEmpty) return const Center(child: Text('لا يوجد عملاء مسجلين'));
//                     return ListView.builder(
//                       itemCount: customers.length,
//                       itemBuilder: (context, index) {
//                         final customer = customers[index];
//                         return ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: AppColors.primaryContainer,
//                             child: Text(customer.name.substring(0, 1), style: TextStyle(color: AppColors.onPrimaryContainer)),
//                           ),
//                           title: Text(customer.name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
//                           subtitle: Text('الدين: ₪${customer.totalDebt.toStringAsFixed(2)}'),
//                           onTap: () {
//                             setState(() => _selectedCustomerId = customer.id);
//                             Navigator.pop(context);
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // دالة الحفظ والتأكيد
//   Future<void> _savePayment(Customer? customer) async {
//     if (customer == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('الرجاء اختيار عميل أولاً قبل تأكيد الدفع')),
//       );
//       return;
//     }
//
//     if (_enteredAmount <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('الرجاء إدخال مبلغ صحيح أكبر من صفر')),
//       );
//       return;
//     }
//
//     setState(() => _isSaving = true);
//
//     try {
//       final paymentCompanion = PaymentsCompanion.insert(
//         customerId: customer.id,
//         amount: _enteredAmount,
//         date: DateTime.now(),
//         method: _selectedMethod,
//       );
//
//       await ref.read(paymentRepositoryProvider).addPayment(paymentCompanion);
//
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('تم تسجيل الدفعة بنجاح!'), backgroundColor: Colors.green),
//         );
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('حدث خطأ أثناء الحفظ: $e'), backgroundColor: AppColors.error),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isSaving = false);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // مراقبة بيانات العميل المحدد حالياً إن وُجد
//     Customer? currentCustomer;
//     if (_selectedCustomerId != null) {
//       final customerAsync = ref.watch(customerByIdProvider(_selectedCustomerId!));
//       currentCustomer = customerAsync.valueOrNull;
//     }
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: _buildAppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildCustomerCard(currentCustomer),
//                   SizedBox(height: 24.h),
//                   _buildAmountInputSection(currentCustomer?.totalDebt ?? 0.0),
//                   SizedBox(height: 24.h),
//                   _buildPaymentMethodSection(),
//                   SizedBox(height: 24.h),
//                   _buildDatePickerSection(),
//                   SizedBox(height: 24.h),
//                   _buildNotesSection(),
//                 ],
//               ),
//             ),
//           ),
//           _buildBottomActionButton(currentCustomer),
//         ],
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: AppColors.surface,
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_forward, color: AppColors.primary, size: 24.sp),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: Text(
//         'تسجيل دفعة',
//         style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.account_balance_wallet, color: AppColors.primary, size: 24.sp),
//           onPressed: () {},
//         ),
//       ],
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1.0),
//         child: Container(color: AppColors.outlineVariant, height: 1.0),
//       ),
//     );
//   }
//
//   Widget _buildCustomerCard(Customer? customer) {
//     String balanceText;
//     Color balanceColor;
//
//     if (customer == null) {
//       balanceText = 'لم يتم تحديد عميل بعد';
//       balanceColor = AppColors.onSurfaceVariant;
//     } else if (customer.totalDebt > 0) {
//       balanceText = 'الدين الحالي: ₪${customer.totalDebt.toStringAsFixed(2)}';
//       balanceColor = AppColors.error;
//     } else if (customer.totalDebt < 0) {
//       balanceText = 'رصيد العميل (له): ₪${(customer.totalDebt * -1).toStringAsFixed(2)}';
//       balanceColor = AppColors.secondary;
//     } else {
//       balanceText = 'الرصيد مُصَفَّر (₪0)';
//       balanceColor = AppColors.onSurfaceVariant;
//     }
//
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainerLowest,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: AppColors.outlineVariant),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 48.w,
//                 height: 48.w,
//                 decoration: const BoxDecoration(
//                   color: AppColors.primaryContainer,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Text(
//                     customer != null ? customer.name.substring(0, 1) : '؟',
//                     style: TextStyle(color: AppColors.onPrimaryContainer, fontSize: 20.sp, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16.w),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(customer?.name ?? 'اختر عميلاً', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
//                   SizedBox(height: 4.h),
//                   Text(balanceText, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: balanceColor)),
//                 ],
//               ),
//             ],
//           ),
//           InkWell(
//             onTap: _showCustomerSelector,
//             child: Row(
//               children: [
//                 Text(customer == null ? 'اختر' : 'تغيير', style: TextStyle(fontSize: 14.sp, color: AppColors.primary, fontWeight: FontWeight.w600)),
//                 SizedBox(width: 4.w),
//                 Icon(Icons.expand_more, size: 16.sp, color: AppColors.primary),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAmountInputSection(double currentDebt) {
//     final bool isOverpayingDebt = currentDebt > 0 && _enteredAmount > currentDebt;
//     final bool isAddingToCredit = currentDebt <= 0 && _enteredAmount > 0;
//     final bool showInfo = (_selectedCustomerId != null) && (isOverpayingDebt || isAddingToCredit);
//
//     String infoText = '';
//     if (isOverpayingDebt) {
//       final credit = _enteredAmount - currentDebt;
//       infoText = 'سيتم تصفير الدين وحفظ ₪${credit.toStringAsFixed(2)} كرصيد للعميل';
//     } else if (isAddingToCredit) {
//       infoText = 'سيتم إضافة المبلغ بالكامل كرصيد في محفظة العميل';
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('مبلغ الدفع', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//         SizedBox(height: 8.h),
//         TextField(
//           controller: _amountController,
//           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//           onChanged: _checkDebt,
//           style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
//           decoration: InputDecoration(
//             hintText: '0.00',
//             hintStyle: TextStyle(color: AppColors.outlineVariant),
//             filled: true,
//             fillColor: AppColors.surfaceContainerLowest,
//             contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
//             prefixIcon: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Text('₪', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
//             ),
//             prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: AppColors.outlineVariant),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: AppColors.outlineVariant),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: AppColors.primary, width: 2),
//             ),
//           ),
//         ),
//         if (showInfo) ...[
//           SizedBox(height: 12.h),
//           Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: AppColors.secondaryContainer.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(8.r),
//               border: Border.all(color: AppColors.secondary.withOpacity(0.5)),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.info_outline, color: AppColors.onSecondaryFixedVariant, size: 20.sp),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   child: Text(
//                     infoText,
//                     style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.onSecondaryFixedVariant),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildPaymentMethodSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('طريقة الدفع', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//         SizedBox(height: 8.h),
//         Container(
//           padding: EdgeInsets.all(4.w),
//           decoration: BoxDecoration(
//             color: AppColors.surfaceContainer,
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: _methodToggleBtn('نقداً', Icons.payments, 'نقد'),
//               ),
//               Expanded(
//                 child: _methodToggleBtn('تحويل بنكي', Icons.account_balance, 'تحويل'),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _methodToggleBtn(String title, IconData icon, String methodValue) {
//     final bool isSelected = _selectedMethod == methodValue;
//
//     return GestureDetector(
//       onTap: () => setState(() => _selectedMethod = methodValue),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12.h),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.white : Colors.transparent,
//           borderRadius: BorderRadius.circular(8.r),
//           boxShadow: isSelected
//               ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]
//               : null,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant, size: 20.sp),
//             SizedBox(width: 8.w),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDatePickerSection() {
//     final now = DateTime.now();
//     final months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
//     final dateStr = "اليوم، ${now.day} ${months[now.month - 1]} ${now.year}";
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('التاريخ', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//         SizedBox(height: 8.h),
//         Container(
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             color: AppColors.surfaceContainerLowest,
//             borderRadius: BorderRadius.circular(12.r),
//             border: Border.all(color: AppColors.outlineVariant),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.calendar_today, color: AppColors.onSurfaceVariant, size: 20.sp),
//                   SizedBox(width: 12.w),
//                   Text(dateStr, style: TextStyle(fontSize: 16.sp, color: AppColors.onSurface)),
//                 ],
//               ),
//               Icon(Icons.edit, color: AppColors.onSurfaceVariant, size: 20.sp),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildNotesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('ملاحظات (اختياري)', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
//         SizedBox(height: 8.h),
//         TextField(
//           controller: _notesController,
//           maxLines: 3,
//           style: TextStyle(fontSize: 16.sp, color: AppColors.onSurface),
//           decoration: InputDecoration(
//             hintText: 'أضف أي ملاحظات إضافية هنا...',
//             hintStyle: TextStyle(color: AppColors.outlineVariant),
//             filled: true,
//             fillColor: AppColors.surfaceContainerLowest,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: AppColors.outlineVariant),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide(color: AppColors.outlineVariant),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: AppColors.primary, width: 2),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBottomActionButton(Customer? customer) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
//       decoration: BoxDecoration(
//         color: AppColors.background.withOpacity(0.9),
//       ),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: AppColors.onPrimary,
//           minimumSize: Size(double.infinity, 56.h),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//           elevation: 4,
//         ),
//         onPressed: _isSaving ? null : () => _savePayment(customer),
//         child: _isSaving
//             ? const CircularProgressIndicator(color: AppColors.onPrimary)
//             : Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.check_circle, size: 24.sp),
//             SizedBox(width: 8.w),
//             Text('تأكيد تسجيل الدفع', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }
// }

///-----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart';
import '../../../providers/repository_providers.dart';

class PaymentEntryScreen extends ConsumerStatefulWidget {
  final int? customerId;

  const PaymentEntryScreen({super.key, this.customerId});

  @override
  ConsumerState<PaymentEntryScreen> createState() => _PaymentEntryScreenState();
}

class _PaymentEntryScreenState extends ConsumerState<PaymentEntryScreen> {
  int? _selectedCustomerId;
  double _enteredAmount = 0.0;
  String _selectedMethod = 'نقد';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedCustomerId = widget.customerId;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _checkDebt(String value) {
    setState(() {
      _enteredAmount = double.tryParse(value) ?? 0.0;
    });
  }

  // ---------------------------------------------------------
  // تم الإصلاح هنا: استخدام Consumer داخل الـ builder
  // ---------------------------------------------------------
  void _showCustomerSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        // تغليف المحتوى بـ Consumer لكي تتحدث النافذة بمجرد وصول الداتا
        return Consumer(
          builder: (context, sheetRef, child) {
            final customersAsync = sheetRef.watch(customersListProvider);

            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text('اختر عميلاً لتسجيل الدفعة', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  ),
                  Divider(height: 1, color: AppColors.outlineVariant),
                  Expanded(
                    child: customersAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('خطأ في تحميل العملاء: $e')),
                      data: (customers) {
                        if (customers.isEmpty) return const Center(child: Text('لا يوجد عملاء مسجلين'));
                        return ListView.builder(
                          itemCount: customers.length,
                          itemBuilder: (context, index) {
                            final customer = customers[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.primaryContainer,
                                child: Text(customer.name.substring(0, 1), style: TextStyle(color: AppColors.onPrimaryContainer)),
                              ),
                              title: Text(customer.name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                              subtitle: Text('الدين: ₪${customer.totalDebt.toStringAsFixed(2)}'),
                              onTap: () {
                                setState(() => _selectedCustomerId = customer.id);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _validateAndConfirmPayment(Customer? customer) {
    if (customer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء اختيار عميل أولاً قبل تأكيد الدفع')),
      );
      return;
    }

    if (_enteredAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال مبلغ صحيح أكبر من صفر')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Row(
            children: [
              Icon(Icons.receipt_long, color: AppColors.primary, size: 28.sp),
              SizedBox(width: 8.w),
              Text('تأكيد الدفعة', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
            ],
          ),
          content: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 15.sp, color: AppColors.onSurfaceVariant, height: 1.5, fontFamily: 'Cairo'),
              children: [
                const TextSpan(text: 'هل أنت متأكد من تسجيل دفعة بقيمة '),
                TextSpan(text: '₪${_enteredAmount.toStringAsFixed(2)} ', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                const TextSpan(text: 'لحساب العميل '),
                TextSpan(text: '${customer.name}؟', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('تراجع', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                _executePayment(customer);
              },
              child: Text('نعم، تأكيد', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _executePayment(Customer customer) async {
    setState(() => _isSaving = true);

    try {
      final paymentCompanion = PaymentsCompanion.insert(
        customerId: customer.id,
        amount: _enteredAmount,
        date: DateTime.now(),
        method: _selectedMethod,
        note: _notesController.text.trim().isEmpty ? drift.Value.absent() : drift.Value(_notesController.text.trim()),
      );

      await ref.read(paymentRepositoryProvider).addPayment(paymentCompanion);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تسجيل الدفعة بنجاح!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء الحفظ: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Customer? currentCustomer;
    if (_selectedCustomerId != null) {
      final customerAsync = ref.watch(customerByIdProvider(_selectedCustomerId!));
      currentCustomer = customerAsync.valueOrNull;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomerCard(currentCustomer),
                  SizedBox(height: 24.h),
                  _buildAmountInputSection(currentCustomer?.totalDebt ?? 0.0),
                  SizedBox(height: 24.h),
                  _buildPaymentMethodSection(),
                  SizedBox(height: 24.h),
                  _buildDatePickerSection(),
                  SizedBox(height: 24.h),
                  _buildNotesSection(),
                ],
              ),
            ),
          ),
          _buildBottomActionButton(currentCustomer),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_forward, color: AppColors.primary, size: 24.sp),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'تسجيل دفعة',
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_balance_wallet, color: AppColors.primary, size: 24.sp),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant, height: 1.0),
      ),
    );
  }

  Widget _buildCustomerCard(Customer? customer) {
    String balanceText;
    Color balanceColor;

    if (customer == null) {
      balanceText = 'لم يتم تحديد عميل بعد';
      balanceColor = AppColors.onSurfaceVariant;
    } else if (customer.totalDebt > 0) {
      balanceText = 'الدين الحالي: ₪${customer.totalDebt.toStringAsFixed(2)}';
      balanceColor = AppColors.error;
    } else if (customer.totalDebt < 0) {
      balanceText = 'رصيد العميل (له): ₪${(customer.totalDebt * -1).toStringAsFixed(2)}';
      balanceColor = AppColors.secondary;
    } else {
      balanceText = 'الرصيد مُصَفَّر (₪0)';
      balanceColor = AppColors.onSurfaceVariant;
    }

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    customer != null ? customer.name.substring(0, 1) : '؟',
                    style: TextStyle(color: AppColors.onPrimaryContainer, fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer?.name ?? 'اختر عميلاً', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  SizedBox(height: 4.h),
                  Text(balanceText, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: balanceColor)),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: _showCustomerSelector,
            child: Row(
              children: [
                Text(customer == null ? 'اختر' : 'تغيير', style: TextStyle(fontSize: 14.sp, color: AppColors.primary, fontWeight: FontWeight.w600)),
                SizedBox(width: 4.w),
                Icon(Icons.expand_more, size: 16.sp, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInputSection(double currentDebt) {
    final bool isOverpayingDebt = currentDebt > 0 && _enteredAmount > currentDebt;
    final bool isAddingToCredit = currentDebt <= 0 && _enteredAmount > 0;
    final bool showInfo = (_selectedCustomerId != null) && (isOverpayingDebt || isAddingToCredit);

    String infoText = '';
    if (isOverpayingDebt) {
      final credit = _enteredAmount - currentDebt;
      infoText = 'سيتم تصفير الدين وحفظ ₪${credit.toStringAsFixed(2)} كرصيد للعميل';
    } else if (isAddingToCredit) {
      infoText = 'سيتم إضافة المبلغ بالكامل كرصيد في محفظة العميل';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مبلغ الدفع', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),
        TextField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: _checkDebt,
          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold, color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: '0.00',
            hintStyle: TextStyle(color: AppColors.outlineVariant),
            filled: true,
            fillColor: AppColors.surfaceContainerLowest,
            contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text('₪', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
        if (showInfo) ...[
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.secondary.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.onSecondaryFixedVariant, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    infoText,
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.onSecondaryFixedVariant),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('طريقة الدفع', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: _methodToggleBtn('نقداً', Icons.payments, 'نقد'),
              ),
              Expanded(
                child: _methodToggleBtn('تحويل بنكي', Icons.account_balance, 'تحويل'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _methodToggleBtn(String title, IconData icon, String methodValue) {
    final bool isSelected = _selectedMethod == methodValue;

    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = methodValue),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerSection() {
    final now = DateTime.now();
    final months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    final dateStr = "اليوم، ${now.day} ${months[now.month - 1]} ${now.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('التاريخ', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: AppColors.onSurfaceVariant, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(dateStr, style: TextStyle(fontSize: 16.sp, color: AppColors.onSurface)),
                ],
              ),
              Icon(Icons.edit, color: AppColors.onSurfaceVariant, size: 20.sp),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ملاحظات (اختياري)', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),
        TextField(
          controller: _notesController,
          maxLines: 3,
          style: TextStyle(fontSize: 16.sp, color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: 'أضف أي ملاحظات إضافية هنا...',
            hintStyle: TextStyle(color: AppColors.outlineVariant),
            filled: true,
            fillColor: AppColors.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionButton(Customer? customer) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.9),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 4,
        ),
        onPressed: _isSaving ? null : () => _validateAndConfirmPayment(customer),
        child: _isSaving
            ? const CircularProgressIndicator(color: AppColors.onPrimary)
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 24.sp),
            SizedBox(width: 8.w),
            Text('تأكيد تسجيل الدفع', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

///------------------------------------------------------------------------------