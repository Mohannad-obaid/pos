import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pos/core/providers/database_provider.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/providers/repository_providers.dart'; // مسار الـ Providers المركزي الذي أرسلته لي

part 'product_controller.g.dart';

@riverpod
class ProductController extends _$ProductController {
  @override
  FutureOr<void> build() {
    // الحالة الابتدائية
    return null;
  }

  // دالة إضافة منتج جديد
  Future<bool> addProduct({
    required String name,
    required double price,
    required String barcode,
    required String category,
    required bool trackStock,
    required int stockQuantity,
  }) async {
    // 1. تفعيل حالة التحميل في الواجهة
    state = const AsyncValue.loading();

    try {
      // 2. تجهيز البيانات للإدخال في قاعدة البيانات
      final product = ProductsCompanion.insert(
        name: name,
        price: price,
        barcode: barcode,
        category: category,
        trackStock: Value(trackStock),
        stockQuantity: Value(stockQuantity),
      );

      // 3. إرسال البيانات للـ Repository لحفظها
      await ref.read(productRepositoryProvider).addProduct(product);

      // 4. إغلاق حالة التحميل بنجاح
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      // 5. في حال الخطأ (مثلاً باركود مكرر)
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}