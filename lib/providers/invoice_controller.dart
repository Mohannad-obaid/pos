import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'repository_providers.dart'; // تأكد من مسار ملف المستودعات لديك

part 'invoice_controller.g.dart';

@riverpod
class InvoiceController extends _$InvoiceController {
  @override
  FutureOr<void> build() {
    // الحالة الابتدائية
    return null;
  }

  // دالة إلغاء الفاتورة
  Future<bool> cancelInvoice(int invoiceId) async {
    state = const AsyncValue.loading();
    try {
      // استدعاء دالة الإلغاء من الـ Repository
      await ref.read(invoiceRepositoryProvider).cancelInvoice(invoiceId);

      state = const AsyncValue.data(null);
      return true; // نجاح العملية
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false; // فشل العملية
    }
  }
}