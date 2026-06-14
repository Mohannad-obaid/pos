import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/customer_controller.dart';

class AddCustomerScreen extends ConsumerStatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  ConsumerState<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends ConsumerState<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  // يمكنك إضافة المزيد من الحقول (العنوان، الملاحظات) إذا كنت تريد تحديث الـ Controller ليقبلها

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerControllerProvider);
    final isLoading = state.isLoading;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _buildAppBar(ref, isLoading),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildFormSection(),
              SizedBox(height: 24.h),
              _buildActionButtons(isLoading),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(WidgetRef ref, bool isLoading) {
    return AppBar(
      title: Text('إضافة عميل', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
      actions: [
        TextButton(
          onPressed: isLoading ? null : _saveCustomer,
          child: Text('حفظ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          _buildTextField(label: 'الاسم الكامل *', controller: _nameController, isRequired: true),
          SizedBox(height: 16.h),
          _buildTextField(label: 'رقم الهاتف', controller: _phoneController, isNumber: true),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, bool isRequired = false, bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, color: AppColors.onSurfaceVariant)),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
          validator: (val) => (isRequired && (val == null || val.isEmpty)) ? 'هذا الحقل مطلوب' : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isLoading) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : _saveCustomer,
          style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50.h)),
          child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('تأكيد وإضافة العميل'),
        ),
        TextButton(onPressed: () => NavigationService.goBack(), child: const Text('إلغاء العملية')),
      ],
    );
  }

  Future<void> _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      final success = await ref.read(customerControllerProvider.notifier).addCustomer(
        name: _nameController.text,
        phone: _phoneController.text,
      );

      if (success && mounted) {
        NavigationService.showSnackBar('تم إضافة العميل بنجاح', type: SnackBarType.success);
        NavigationService.goBack();
      }
    }
  }
}