import 'package:pos/data/local/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(DatabaseRef ref) {
  final db = AppDatabase();
  // إغلاق قاعدة البيانات عند إغلاق التطبيق
  ref.onDispose(() => db.close());
  return db;
}