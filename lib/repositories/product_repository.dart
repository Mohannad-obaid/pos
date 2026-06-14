import 'package:drift/drift.dart';
import 'package:pos/data/local/database.dart';


class ProductRepository {
  final AppDatabase _db;

  ProductRepository(this._db);

  // جلب كل المنتجات
  Stream<List<Product>> watchAllProducts() {
    return _db.select(_db.products).watch();
  }

  // إضافة منتج جديد
  Future<int> addProduct(ProductsCompanion product) {
    return _db.into(_db.products).insert(product);
  }

  // تحديث منتج (مثلاً تعديل السعر أو الكمية يدوياً)
  Future<bool> updateProduct(Product product) {
    return _db.update(_db.products).replace(product);
  }

  // مسح باركود أو بحث بالاسم
  Stream<List<Product>> searchProducts(String query) {
    return (_db.select(_db.products)
      ..where((p) => p.name.like('%$query%') | p.barcode.equals(query)))
        .watch();
  }

  // جلب منتج بواسطة الـ ID
  Stream<Product?> watchProductById(int id) {
    return (_db.select(_db.products)
      ..where((p) => p.id.equals(id)))
        .watchSingleOrNull();
  }

  // جلب منتجات حسب الفئة
  Stream<List<Product>> watchProductsByCategory(String category) {
    return (_db.select(_db.products)
      ..where((p) => p.category.equals(category)))
        .watch();
  }

  // جلب منتج بواسطة الباركود
  Stream<Product?> watchProductByBarcode(String barcode) {
    return (_db.select(_db.products)
      ..where((p) => p.barcode.equals(barcode)))
        .watchSingleOrNull();
  }

  // تحديث المخزون (مهم للمبيعات)
  Future<bool> updateStock(int productId, int newQuantity) async {
    final product = await (_db.select(_db.products)
      ..where((p) => p.id.equals(productId))).getSingleOrNull();

    if (product == null) return false;

    return updateProduct(product.copyWith(stockQuantity: newQuantity));
  }

  // حذف منتج
  Future<bool> deleteProduct(int productId) async {
    final count = await (_db.delete(_db.products)
      ..where((p) => p.id.equals(productId))).go();
    return count > 0;
  }

  // جلب المنتجات المنفدة (بدون مخزون)
  Stream<List<Product>> watchOutOfStockProducts() {
    return (_db.select(_db.products)
      ..where((p) => p.trackStock.equals(true) & p.stockQuantity.isSmallerThanValue(1)))
        .watch();
  }
}