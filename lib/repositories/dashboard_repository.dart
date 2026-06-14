import 'package:drift/drift.dart';
import 'package:pos/data/local/database.dart';


class DashboardRepository {
  final AppDatabase _db;

  DashboardRepository(this._db);

  // إجمالي المبيعات (مجموع الفواتير)
  Stream<double?> watchTotalSales() {
    final totalSales = _db.invoices.totalAmount.sum();
    final query = _db.selectOnly(_db.invoices)..addColumns([totalSales]);
    return query.map((row) => row.read(totalSales)).watchSingle();
  }

  // إجمالي الديون المستحقة (مجموع ديون العملاء)
  Stream<double?> watchTotalOutstandingDebt() {
    final totalDebt = _db.customers.totalDebt.sum();
    final query = _db.selectOnly(_db.customers)..addColumns([totalDebt]);
    return query.map((row) => row.read(totalDebt)).watchSingle();
  }

  // المبالغ المحصلة (مجموع المدفوعات)
  Stream<double?> watchTotalCollectedPayments() {
    final totalCollected = _db.payments.amount.sum();
    final query = _db.selectOnly(_db.payments)..addColumns([totalCollected]);
    return query.map((row) => row.read(totalCollected)).watchSingle();
  }
}