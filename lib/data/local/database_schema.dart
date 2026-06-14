import 'package:drift/drift.dart';

// جداول الزبائن
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  RealColumn get totalDebt => real().withDefault(const Constant(0.0))();
}

// جداول المنتجات
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get barcode => text().unique()();
  RealColumn get price => real()();
  IntColumn get stockQuantity => integer().withDefault(const Constant(0))();
  BoolColumn get trackStock => boolean().withDefault(const Constant(true))();
}

// جداول الفواتير
class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  //IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get customerId => integer().nullable().references(Customers, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get totalAmount => real()();
  TextColumn get status => text()(); // cash, debt, cancelled
  TextColumn get note => text().nullable()();
}

// جدول الربط بين الفواتير والمنتجات
class InvoiceItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId => integer().references(Invoices, #id)();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get quantity => integer()();
  RealColumn get priceAtSale => real()();
}

// جدول الدفعات المالية
class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get method => text()(); // cash, transfer, online
  TextColumn get note => text().nullable()();
}