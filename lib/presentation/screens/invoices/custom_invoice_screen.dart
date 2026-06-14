import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/theme/app_colors.dart';
import '../../../data/local/database.dart';
import '../../../providers/repository_providers.dart';

class CustomInvoiceScreen extends ConsumerStatefulWidget {
  const CustomInvoiceScreen({super.key});

  @override
  ConsumerState<CustomInvoiceScreen> createState() => _CustomInvoiceScreenState();
}

class _CustomInvoiceScreenState extends ConsumerState<CustomInvoiceScreen> {
  String _paymentMode = 'نقد'; // 'نقد' أو 'دين'
  int? _selectedCustomerId;

  // استخدام Controllers بدلاً من النصوص الثابتة
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // --- نافذة اختيار العميل (الذكية) ---
  void _showCustomerSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Consumer(
          builder: (context, sheetRef, child) {
            final customersAsync = sheetRef.watch(customersListProvider);
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('اختر العميل', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                        if (_selectedCustomerId != null)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedCustomerId = null;
                                _paymentMode = 'نقد';
                              });
                              Navigator.pop(context);
                            },
                            child: Text('إزالة التحديد', style: TextStyle(color: AppColors.error)),
                          )
                      ],
                    ),
                  ),
                  Divider(height: 1, color: AppColors.outlineVariant),
                  Expanded(
                    child: customersAsync.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('خطأ: $e')),
                      data: (customers) {
                        if (customers.isEmpty) return const Center(child: Text('لا يوجد عملاء'));
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
                              subtitle: Text(customer.phone ?? 'بدون رقم'),
                              onTap: () {
                                setState(() {
                                  _selectedCustomerId = customer.id;
                                  _paymentMode = 'دين';
                                });
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

  // --- دالة حفظ وإصدار الفاتورة ---
  Future<void> _issueInvoice() async {
    // قراءة المبلغ من الـ Controller
    final double amount = double.tryParse(_amountController.text) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرجاء إدخال مبلغ صحيح')));
      return;
    }

    if (_paymentMode == 'دين' && _selectedCustomerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرجاء اختيار العميل لتسجيل الدين')));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final invoiceCompanion = InvoicesCompanion.insert(
        customerId: _selectedCustomerId != null ? drift.Value(_selectedCustomerId!) : const drift.Value.absent(),
        totalAmount: amount,
        date: DateTime.now(),
        status: _paymentMode,
        note: drift.Value(_noteController.text.trim()),
      );

      final isDebt = _paymentMode == 'دين';

      await ref.read(invoiceRepositoryProvider).createInvoice(invoiceCompanion, [], isDebt);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إصدار الفاتورة بنجاح!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: AppColors.error),
        );
      }

      print('Error issuing invoice: $e');
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
      currentCustomer = ref.watch(customerByIdProvider(_selectedCustomerId!)).valueOrNull;
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 100.h),
              child: Column(
                children: [
                  _buildAmountDisplay(),
                  SizedBox(height: 24.h),
                  _buildDescriptionField(),
                  SizedBox(height: 16.h),
                  _buildCustomerSelection(currentCustomer),
                  SizedBox(height: 16.h),
                  _buildPaymentMethod(),
                ],
              ),
            ),
          ),
          _buildFooterAction(),
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
      title: Text('إصدار فاتورة مخصصة', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: AppColors.onSurfaceVariant, size: 24.sp),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: AppColors.outlineVariant.withOpacity(0.5), height: 1.0),
      ),
    );
  }

  Widget _buildAmountDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('المبلغ الإجمالي', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.outlineVariant),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center, // توسيط النص
            style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: TextStyle(color: AppColors.outlineVariant.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 24.h),
              // علامة الشيكل على اليسار (في التصميم العربي)
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text('₪', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: AppColors.primary)),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text('وصف الفاتورة / البيان', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _noteController,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'مثلاً: خدمة تصليح، بضاعة منوعة...',
            hintStyle: TextStyle(color: AppColors.outlineVariant),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Icon(Icons.edit_note, color: AppColors.onSurfaceVariant, size: 24.sp),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: AppColors.outlineVariant)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: AppColors.outlineVariant)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerSelection(Customer? customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text('العميل', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: _showCustomerSelector,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(color: AppColors.primaryFixed, shape: BoxShape.circle),
                      child: Icon(Icons.person_add, color: AppColors.primary, size: 20.sp),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(customer?.name ?? 'اختر عميل أو ابحث عنه', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
                        Text(customer != null ? 'تم التحديد' : 'اختياري', style: TextStyle(fontSize: 12.sp, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.chevron_left, color: AppColors.onSurfaceVariant, size: 24.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text('طريقة الدفع', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(child: _paymentModeBtn('نقد', Icons.payments, 'نقد')),
            SizedBox(width: 12.w),
            Expanded(child: _paymentModeBtn('دين', Icons.account_balance_wallet, 'دين')),
          ],
        ),
      ],
    );
  }

  Widget _paymentModeBtn(String label, IconData icon, String mode) {
    final bool isSelected = _paymentMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _paymentMode = mode),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.outlineVariant, width: isSelected ? 2 : 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant, size: 28.sp),
            SizedBox(height: 8.h),
            Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterAction() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.4),
        ),
        onPressed: _isSaving ? null : _issueInvoice,
        child: _isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 24.sp),
            SizedBox(width: 8.w),
            Text('إصدار الفاتورة', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}