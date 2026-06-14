import 'package:drift/drift.dart';
import 'package:pos/data/local/database.dart';

class InvoiceRepository {
  final AppDatabase _db;

  InvoiceRepository(this._db);

  Stream<List<Invoice>> watchAllInvoices() {
    return (_db.select(_db.invoices)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
  }

  // إنشاء فاتورة متكاملة باستخدام Transaction
  Future<void> createInvoice(
      InvoicesCompanion invoice,
      List<InvoiceItemsCompanion> items,
      bool isDebt,
      ) async {
    await _db.transaction(() async {
      // 1. إدخال الفاتورة وجلب الـ ID الخاص بها
      final invoiceId = await _db.into(_db.invoices).insert(invoice);

      // 2. إدخال عناصر الفاتورة وتحديث المخزون
      for (var item in items) {
        // ربط العنصر برقم الفاتورة الجديد
        final newItem = item.copyWith(invoiceId: Value(invoiceId));
        await _db.into(_db.invoiceItems).insert(newItem);

        // تحديث المخزون (إذا كان المنتج يتبع المخزون)
        final productId = item.productId.value;
        final product = await (_db.select(_db.products)..where((p) => p.id.equals(productId))).getSingle();

        if (product.trackStock) {
          final newStock = product.stockQuantity - item.quantity.value;
          await _db.update(_db.products).replace(product.copyWith(stockQuantity: newStock));
        }
      }

      // 3. تحديث دين العميل إذا كانت الفاتورة آجلة
      if (isDebt && invoice.customerId.present && invoice.customerId.value != null) {
        final customerId = invoice.customerId.value!;
        final customer = await (_db.select(_db.customers)..where((c) => c.id.equals(customerId))).getSingle();

        final newDebt = customer.totalDebt + invoice.totalAmount.value;
        await _db.update(_db.customers).replace(customer.copyWith(totalDebt: newDebt));
      }
    });
  }

  // جلب فاتورة واحدة مع عناصرها
  Stream<Invoice?> watchInvoiceById(int id) {
    return (_db.select(_db.invoices)
      ..where((i) => i.id.equals(id)))
        .watchSingleOrNull();
  }

  // جلب فواتير العميل
  Stream<List<Invoice>> watchInvoicesByCustomerId(int customerId) {
    return (_db.select(_db.invoices)
      ..where((i) => i.customerId.equals(customerId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  // جلب عناصر الفاتورة
  Stream<List<InvoiceItem>> watchInvoiceItems(int invoiceId) {
    return (_db.select(_db.invoiceItems)
      ..where((i) => i.invoiceId.equals(invoiceId)))
        .watch();
  }

  // إلغاء فاتورة وعكس العمليات (في transaction)
  Future<void> cancelInvoice(int invoiceId) async {
    await _db.transaction(() async {
      // 1. جلب الفاتورة
      final invoice = await (_db.select(_db.invoices)
        ..where((i) => i.id.equals(invoiceId))).getSingleOrNull();

      if (invoice == null) throw Exception('الفاتورة غير موجودة');

      // 2. جلب عناصر الفاتورة
      final items = await (_db.select(_db.invoiceItems)
        ..where((i) => i.invoiceId.equals(invoiceId))).get();

      // 3. عكس تحديثات المخزون والدين
      for (var item in items) {
        final product = await (_db.select(_db.products)
          ..where((p) => p.id.equals(item.productId))).getSingle();

        if (product.trackStock) {
          final newStock = product.stockQuantity + item.quantity;
          await _db.update(_db.products).replace(product.copyWith(stockQuantity: newStock));
        }
      }

      // 4. عكس دين العميل إذا كانت آجلة
      if (invoice.status == 'debt' && invoice.customerId != null) {
        final customer = await (_db.select(_db.customers)
          ..where((c) => c.id.equals(invoice.customerId!))).getSingle();

        final newDebt = (customer.totalDebt - invoice.totalAmount).clamp(0.0, double.infinity);
        await _db.update(_db.customers).replace(customer.copyWith(totalDebt: newDebt));
      }

      // 5. تحديث حالة الفاتورة إلى مُلغاة
      await _db.update(_db.invoices).replace(invoice.copyWith(status: 'cancelled'));
    });
  }

  // جلب فواتير حسب نطاق التاريخ
  Stream<List<Invoice>> watchInvoicesByDateRange(DateTime startDate, DateTime endDate) {
    return (_db.select(_db.invoices)
      ..where((i) => i.date.isBetween(startDate as Expression<DateTime>, endDate as Expression<DateTime>))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  // جلب فواتير حسب الحالة
  Stream<List<Invoice>> watchInvoicesByStatus(String status) {
    return (_db.select(_db.invoices)
      ..where((i) => i.status.equals(status))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  Stream<List<ProductSaleRecord>> watchProductSalesHistory(int productId) {
    final query = _db.select(_db.invoiceItems).join([
      innerJoin(_db.invoices, _db.invoices.id.equalsExp(_db.invoiceItems.invoiceId)),
    ])
      ..where(_db.invoiceItems.productId.equals(productId))
      ..orderBy([OrderingTerm.desc(_db.invoices.date)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final invoice = row.readTable(_db.invoices);
        final item = row.readTable(_db.invoiceItems);
        return ProductSaleRecord(
          date: invoice.date,
          quantity: item.quantity as num,
          status: invoice.status,
        );
      }).toList();
    });
  }
}

// 1. أضف هذا الكلاس المساعد في أعلى أو أسفل ملف invoice_repository.dart
class ProductSaleRecord {
  final DateTime date;
  final num quantity;
  final String status;

  ProductSaleRecord({required this.date, required this.quantity, required this.status});
}



