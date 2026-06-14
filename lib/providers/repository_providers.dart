import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos/core/providers/database_provider.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/repositories/customer_repository.dart';
import 'package:pos/repositories/dashboard_repository.dart';
import 'package:pos/repositories/invoice_repository.dart';
import 'package:pos/repositories/payment_repository.dart';
import 'package:pos/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'repository_providers.g.dart';


@Riverpod(keepAlive: true)
CustomerRepository customerRepository(CustomerRepositoryRef ref) {
  return CustomerRepository(ref.watch(databaseProvider));
}

@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepository(ref.watch(databaseProvider));
}

@Riverpod(keepAlive: true)
InvoiceRepository invoiceRepository(InvoiceRepositoryRef ref) {
  return InvoiceRepository(ref.watch(databaseProvider));
}

@Riverpod(keepAlive: true)
PaymentRepository paymentRepository(PaymentRepositoryRef ref) {
  return PaymentRepository(ref.watch(databaseProvider));
}

@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(DashboardRepositoryRef ref) {
  return DashboardRepository(ref.watch(databaseProvider));
}

// ============ STREAM PROVIDERS ============

@riverpod
Stream<List<Customer>> customersList(CustomersListRef ref) {
  return ref.watch(customerRepositoryProvider).getAllCustomers();
}

@riverpod
Stream<List<Product>> productsList(ProductsListRef ref) {
  return ref.watch(productRepositoryProvider).watchAllProducts();
}

@riverpod
Stream<List<Invoice>> invoicesList(InvoicesListRef ref) {
  return ref.watch(invoiceRepositoryProvider).watchAllInvoices();
}

@riverpod
Stream<List<Payment>> paymentsList(PaymentsListRef ref) {
  return ref.watch(paymentRepositoryProvider).watchAllPayments();
}

// ============ FILTERED PRODUCTS ============

@riverpod
Stream<List<Product>> searchProducts(SearchProductsRef ref, String query) {
  if (query.isEmpty) {
    return ref.watch(productRepositoryProvider).watchAllProducts();
  }
  return ref.watch(productRepositoryProvider).searchProducts(query);
}

@riverpod
Stream<List<Product>> productsByCategory(ProductsByCategoryRef ref, String category) {
  return ref.watch(productRepositoryProvider).watchProductsByCategory(category);
}

@riverpod
Stream<List<Product>> outOfStockProducts(OutOfStockProductsRef ref) {
  return ref.watch(productRepositoryProvider).watchOutOfStockProducts();
}

// ============ FILTERED CUSTOMERS ============

@riverpod
Stream<List<Customer>> searchCustomers(SearchCustomersRef ref, String query) {
  if (query.isEmpty) {
    return ref.watch(customerRepositoryProvider).getAllCustomers();
  }
  return ref.watch(customerRepositoryProvider).searchCustomers(query);
}

@riverpod
Stream<List<Customer>> debtors(DebtorsRef ref) {
  return ref.watch(customerRepositoryProvider).getDebtors();
}

@riverpod
Stream<List<Customer>> customersByDebtStatus(CustomersByDebtStatusRef ref, bool hasDebt) {
  return ref.watch(customerRepositoryProvider).getCustomersByDebtStatus(hasDebt);
}

// ============ SINGLE ITEM PROVIDERS ============

@riverpod
Stream<Customer?> customerById(CustomerByIdRef ref, int id) {
  return ref.watch(customerRepositoryProvider).getCustomerById(id);
}

@riverpod
Stream<Product?> productById(ProductByIdRef ref, int id) {
  return ref.watch(productRepositoryProvider).watchProductById(id);
}

@riverpod
Stream<Product?> productByBarcode(ProductByBarcodeRef ref, String barcode) {
  return ref.watch(productRepositoryProvider).watchProductByBarcode(barcode);
}

@riverpod
Stream<Invoice?> invoiceById(InvoiceByIdRef ref, int id) {
  return ref.watch(invoiceRepositoryProvider).watchInvoiceById(id);
}

@riverpod
Stream<Payment?> paymentById(PaymentByIdRef ref, int id) {
  return ref.watch(paymentRepositoryProvider).watchPaymentById(id);
}

// ============ FILTERED INVOICES ============

@riverpod
Stream<List<Invoice>> invoicesByCustomerId(InvoicesByCustomerIdRef ref, int customerId) {
  return ref.watch(invoiceRepositoryProvider).watchInvoicesByCustomerId(customerId);
}

@riverpod
Stream<List<Invoice>> invoicesByStatus(InvoicesByStatusRef ref, String status) {
  return ref.watch(invoiceRepositoryProvider).watchInvoicesByStatus(status);
}

@riverpod
Stream<List<InvoiceItem>> invoiceItems(InvoiceItemsRef ref, int invoiceId) {
  return ref.watch(invoiceRepositoryProvider).watchInvoiceItems(invoiceId);
}

@riverpod
Stream<List<ProductSaleRecord>> productSalesHistory(ProductSalesHistoryRef ref, int productId) {
  return ref.watch(invoiceRepositoryProvider).watchProductSalesHistory(productId);
}

// ============ FILTERED PAYMENTS ============

@riverpod
Stream<List<Payment>> paymentsByCustomerId(PaymentsByCustomerIdRef ref, int customerId) {
  return ref.watch(paymentRepositoryProvider).watchPaymentsByCustomerId(customerId);
}

@riverpod
Stream<List<Payment>> paymentsByMethod(PaymentsByMethodRef ref, String method) {
  return ref.watch(paymentRepositoryProvider).watchPaymentsByMethod(method);
}


final storeNameProvider = StateNotifierProvider<StoreNameNotifier, String>((ref) {
  return StoreNameNotifier();
});

class StoreNameNotifier extends StateNotifier<String> {
  StoreNameNotifier() : super('حدث اسم متجرك') {
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('store_name') ?? 'حدث اسم متجرك';
  }

  Future<void> updateName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('store_name', newName);
    state = newName;
  }
}


