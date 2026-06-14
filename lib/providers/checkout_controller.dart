import 'package:pos/data/local/database.dart';
import 'package:pos/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import 'cart_provider.dart';
part 'checkout_controller.g.dart';

class CheckoutException implements Exception {
  final String message;
  CheckoutException(this.message);

  @override
  String toString() => message;
}

@riverpod
class CheckoutController extends _$CheckoutController {
  @override
  FutureOr<void> build() {
    // لا يوجد حالة ابتدائية معقدة هنا، فقط نجهز الـ Controller
  }

  /// Validates that all items in cart have sufficient stock
  Future<bool> _validateStock() async {
    final cartItems = ref.read(cartProvider);
    final productRepo = ref.read(productRepositoryProvider);

    for (var item in cartItems) {
      try {
        // Get the latest product data from database
        final products = await productRepo.watchAllProducts().first;
        final product = products.firstWhere(
          (p) => p.id == item.product.id,
          orElse: () => throw CheckoutException(
            'المنتج "${item.product.name}" غير موجود في قاعدة البيانات',
          ),
        );

        if (product.trackStock && product.stockQuantity < item.quantity) {
          throw CheckoutException(
            'الكمية المتوفرة من "${item.product.name}" غير كافية. '
            'متوفر: ${product.stockQuantity}، المطلوب: ${item.quantity}',
          );
        }
      } catch (e) {
        if (e is CheckoutException) rethrow;
        throw CheckoutException('خطأ في التحقق من المخزون: ${e.toString()}');
      }
    }

    return true;
  }

  /// Validates customer for debt sales
  Future<bool> _validateCustomer(int customerId) async {
    final customerRepo = ref.read(customerRepositoryProvider);

    try {
      final customers = await customerRepo.getAllCustomers().first;
      final exists = customers.any((c) => c.id == customerId);

      if (!exists) {
        throw CheckoutException('العميل المختار غير موجود في قاعدة البيانات');
      }

      return true;
    } catch (e) {
      if (e is CheckoutException) rethrow;
      throw CheckoutException('خطأ في التحقق من بيانات العميل: ${e.toString()}');
    }
  }

  /// Process checkout with full validation
  Future<bool> processCheckout({
    required bool isDebt,
    int? customerId,
  }) async {
    state = const AsyncValue.loading();

    try {
      final cartItems = ref.read(cartProvider);

      // Validation 1: Cart is not empty
      if (cartItems.isEmpty) {
        throw CheckoutException('السلة فارغة. يرجى إضافة منتجات قبل الدفع');
      }

      // Validation 2: Stock check
      await _validateStock();

      // Validation 3: Debt sales must have a customer
      if (isDebt && customerId == null) {
        throw CheckoutException('يجب اختيار عميل للمبيعات الآجلة');
      }

      // Validation 4: Customer exists for debt sales
      if (isDebt && customerId != null) {
        await _validateCustomer(customerId);
      }

      final totalAmount = ref.read(cartTotalProvider);

      // Prepare invoice
      final invoice = InvoicesCompanion.insert(
        customerId: Value(customerId),
        date: DateTime.now(),
        totalAmount: totalAmount,
        status: isDebt ? 'debt' : 'cash',
      );

      // Prepare invoice items (all IDs are now safely int)
      final items = cartItems.map((item) {
        return InvoiceItemsCompanion(
          productId: Value(item.product.id),
          quantity: Value(item.quantity),
          priceAtSale: Value(item.product.price),
        );
      }).toList();

      // Execute transaction
      await ref.read(invoiceRepositoryProvider).createInvoice(invoice, items, isDebt);

      // Clear cart only after successful transaction
      ref.read(cartProvider.notifier).clearCart();

      state = const AsyncValue.data(null);
      return true;
    } on CheckoutException catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    } catch (e, st) {
      state = AsyncValue.error(
        CheckoutException('خطأ غير متوقع: ${e.toString()}'),
        st,
      );
      return false;
    }
  }

  /// Get user-friendly error message
  String? getErrorMessage() {
    return state.maybeWhen(
      error: (error, _) => error is CheckoutException ? error.message : 'حدث خطأ غير متوقع',
      orElse: () => null,
    );
  }
}