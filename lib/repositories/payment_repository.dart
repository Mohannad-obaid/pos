import 'package:drift/drift.dart';
import 'package:pos/data/local/database.dart';

class PaymentRepository {
  final AppDatabase _db;

  PaymentRepository(this._db);

  Stream<List<Payment>> watchAllPayments() {
    return (_db.select(_db.payments)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
  }

  // تسجيل دفعة وتحديث رصيد العميل
  Future<void> addPayment(PaymentsCompanion payment) async {
    await _db.transaction(() async {
      // 1. تسجيل الدفعة
      await _db.into(_db.payments).insert(payment);

      // 2. تحديث رصيد العميل (إنقاص الدين)
      final customerId = payment.customerId.value;
      final customer = await (_db.select(_db.customers)..where((c) => c.id.equals(customerId))).getSingle();

      final newDebt = customer.totalDebt - payment.amount.value;
      // // نضمن أن الدين لا يصبح بالسالب إلا إذا كان ذلك مسموحاً في نظامك (كرصيد دائن)
      // await _db.update(_db.customers).replace(customer.copyWith(totalDebt: (newDebt).clamp(0.0, double.infinity)));

      // بدون clamp، نسمح بالرقم السالب ليمثل "رصيد العميل"
      await _db.update(_db.customers).replace(customer.copyWith(totalDebt: newDebt));
    });
  }

  // جلب دفعات عميل محدد
  Stream<List<Payment>> watchPaymentsByCustomerId(int customerId) {
    return (_db.select(_db.payments)
      ..where((p) => p.customerId.equals(customerId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  // جلب دفعة واحدة
  Stream<Payment?> watchPaymentById(int id) {
    return (_db.select(_db.payments)
      ..where((p) => p.id.equals(id)))
        .watchSingleOrNull();
  }

  // جلب الدفعات حسب نطاق التاريخ
  Stream<List<Payment>> watchPaymentsByDateRange(DateTime startDate, DateTime endDate) {
    return (_db.select(_db.payments)
      ..where((p) => p.date.isBetween(startDate as Expression<DateTime>, endDate as Expression<DateTime>))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  // جلب الدفعات حسب طريقة الدفع
  Stream<List<Payment>> watchPaymentsByMethod(String method) {
    return (_db.select(_db.payments)
      ..where((p) => p.method.equals(method))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  // حذف دفعة (نادر لكن مهم للتصحيح)
  Future<bool> deletePayment(int paymentId) async {
    final payment = await (_db.select(_db.payments)
      ..where((p) => p.id.equals(paymentId))).getSingleOrNull();

    if (payment == null) return false;

    await _db.transaction(() async {
      // عكس تحديث الدين
      final customer = await (_db.select(_db.customers)
        ..where((c) => c.id.equals(payment.customerId))).getSingle();

      final newDebt = customer.totalDebt + payment.amount;
      await _db.update(_db.customers).replace(customer.copyWith(totalDebt: newDebt));

      // حذف الدفعة
      await (_db.delete(_db.payments)
        ..where((p) => p.id.equals(paymentId))).go();
    });

    return true;
  }
}