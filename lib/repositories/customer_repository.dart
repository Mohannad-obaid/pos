import 'package:drift/drift.dart';
import 'package:pos/data/local/database.dart';

class CustomerRepository {
  final AppDatabase _db;

  CustomerRepository(this._db);

  // جلب كل الزبائن
  Stream<List<Customer>> getAllCustomers() {
    return _db.select(_db.customers).watch();
  }

  // إضافة زبون جديد
  Future<int> addCustomer(CustomersCompanion customer) {
    return _db.into(_db.customers).insert(customer);
  }

  // دالة لجلب زبون واحد (ستحتاجها في صفحة تفاصيل العميل)
  Stream<Customer?> getCustomerById(int id) {
    return (_db.select(_db.customers)..where((c) => c.id.equals(id))).watchSingleOrNull();
  }

  // البحث عن الزبائن (بالاسم أو الهاتف)
  Stream<List<Customer>> searchCustomers(String query) {
    return (_db.select(_db.customers)
      ..where((c) => c.name.like('%$query%') | c.phone.like('%$query%')))
        .watch();
  }

  // تحديث بيانات العميل
  Future<bool> updateCustomer(Customer customer) {
    return _db.update(_db.customers).replace(customer);
  }

  // حذف عميل
  Future<bool> deleteCustomer(int customerId) async {
    final count = await (_db.delete(_db.customers)
      ..where((c) => c.id.equals(customerId))).go();
    return count > 0;
  }

  // جلب العملاء المديونين فقط
  Stream<List<Customer>> getDebtors() {
    return (_db.select(_db.customers)
      ..where((c) => c.totalDebt.isBiggerThanValue(0)))
        .watch();
  }

  // جلب العملاء مع فلترة حسب الدين
  Stream<List<Customer>> getCustomersByDebtStatus(bool hasDebt) {
    if (hasDebt) {
      return (_db.select(_db.customers)
        ..where((c) => c.totalDebt.isBiggerThanValue(0)))
          .watch();
    } else {
      return (_db.select(_db.customers)
        ..where((c) => c.totalDebt.equals(0)))
          .watch();
    }
  }
}