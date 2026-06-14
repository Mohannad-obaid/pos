import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'database_schema.dart';

part 'database.g.dart'; // Drift سيقوم بإنشاء هذا الملف تلقائياً

@DriftDatabase(tables: [Customers, Products, Invoices, InvoiceItems, Payments])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'daynpay.db'));
    return NativeDatabase(file);
  });
}