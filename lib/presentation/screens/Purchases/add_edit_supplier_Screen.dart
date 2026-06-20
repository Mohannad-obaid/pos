import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class AddEditSupplierScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? supplier; // إذا كان null يعني إضافة جديد، غير ذلك يعني تعديل
  const AddEditSupplierScreen({super.key, this.supplier});

  @override
  ConsumerState<AddEditSupplierScreen> createState() => _AddEditSupplierScreenState();
}

class _AddEditSupplierScreenState extends ConsumerState<AddEditSupplierScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _creditLimitController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.supplier?['name']);
    _phoneController = TextEditingController(text: widget.supplier?['phone']);
    _addressController = TextEditingController(text: widget.supplier?['address']);
    _creditLimitController = TextEditingController(text: widget.supplier?['creditLimit']?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.supplier == null ? 'إضافة مورد جديد' : 'تعديل بيانات المورد'),
        backgroundColor: AppColors.surface,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            _buildTextField(_nameController, 'اسم المورد / الشركة', Icons.business, isRequired: true),
            SizedBox(height: 16.h),
            _buildTextField(_phoneController, 'رقم الهاتف', Icons.phone, keyboardType: TextInputType.phone),
            SizedBox(height: 16.h),
            _buildTextField(_addressController, 'العنوان', Icons.location_on),
            SizedBox(height: 16.h),
            _buildTextField(_creditLimitController, 'الحد الائتماني (أقصى دين مسموح)', Icons.money_off, keyboardType: TextInputType.number),
            SizedBox(height: 32.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // هنا يتم الحفظ في قاعدة البيانات
                  Navigator.pop(context);
                }
              },
              child: Text('حفظ البيانات', style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType? keyboardType, bool isRequired = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
      validator: isRequired ? (value) => value!.isEmpty ? 'هذا الحقل مطلوب' : null : null,
    );
  }
}