// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerRepositoryHash() =>
    r'317d8431a3404f975d97d65953c8c5466745ed24';

/// See also [customerRepository].
@ProviderFor(customerRepository)
final customerRepositoryProvider = Provider<CustomerRepository>.internal(
  customerRepository,
  name: r'customerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CustomerRepositoryRef = ProviderRef<CustomerRepository>;
String _$productRepositoryHash() => r'5645f280ebaa628c2ef74742d2b565e2f3bad3d6';

/// See also [productRepository].
@ProviderFor(productRepository)
final productRepositoryProvider = Provider<ProductRepository>.internal(
  productRepository,
  name: r'productRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductRepositoryRef = ProviderRef<ProductRepository>;
String _$invoiceRepositoryHash() => r'f6ec4f10716f1b86fc2474007e30481bc66fc14f';

/// See also [invoiceRepository].
@ProviderFor(invoiceRepository)
final invoiceRepositoryProvider = Provider<InvoiceRepository>.internal(
  invoiceRepository,
  name: r'invoiceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invoiceRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InvoiceRepositoryRef = ProviderRef<InvoiceRepository>;
String _$paymentRepositoryHash() => r'3d9a8a35fcb13ed7d0aa975cf585f7dd75c5d534';

/// See also [paymentRepository].
@ProviderFor(paymentRepository)
final paymentRepositoryProvider = Provider<PaymentRepository>.internal(
  paymentRepository,
  name: r'paymentRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PaymentRepositoryRef = ProviderRef<PaymentRepository>;
String _$dashboardRepositoryHash() =>
    r'bb384d34bad6a9ff191bddf86ba665370ffac6ed';

/// See also [dashboardRepository].
@ProviderFor(dashboardRepository)
final dashboardRepositoryProvider = Provider<DashboardRepository>.internal(
  dashboardRepository,
  name: r'dashboardRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DashboardRepositoryRef = ProviderRef<DashboardRepository>;
String _$customersListHash() => r'24545d4c461cb8da35e526710ad226445c90cbc7';

/// See also [customersList].
@ProviderFor(customersList)
final customersListProvider =
    AutoDisposeStreamProvider<List<Customer>>.internal(
  customersList,
  name: r'customersListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customersListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CustomersListRef = AutoDisposeStreamProviderRef<List<Customer>>;
String _$productsListHash() => r'428fe0ee8a8966208aa2a64e07632fe5051c620e';

/// See also [productsList].
@ProviderFor(productsList)
final productsListProvider = AutoDisposeStreamProvider<List<Product>>.internal(
  productsList,
  name: r'productsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductsListRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$invoicesListHash() => r'9fc2ddfb94e194458454926dcace640a4a83241b';

/// See also [invoicesList].
@ProviderFor(invoicesList)
final invoicesListProvider = AutoDisposeStreamProvider<List<Invoice>>.internal(
  invoicesList,
  name: r'invoicesListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$invoicesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InvoicesListRef = AutoDisposeStreamProviderRef<List<Invoice>>;
String _$paymentsListHash() => r'e9ebfd3c5b079ffe39c00b63e21f235240e417f8';

/// See also [paymentsList].
@ProviderFor(paymentsList)
final paymentsListProvider = AutoDisposeStreamProvider<List<Payment>>.internal(
  paymentsList,
  name: r'paymentsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$paymentsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PaymentsListRef = AutoDisposeStreamProviderRef<List<Payment>>;
String _$searchProductsHash() => r'210dcfdbe554bc352e868624b5dde849a0d37240';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchProducts].
@ProviderFor(searchProducts)
const searchProductsProvider = SearchProductsFamily();

/// See also [searchProducts].
class SearchProductsFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [searchProducts].
  const SearchProductsFamily();

  /// See also [searchProducts].
  SearchProductsProvider call(
    String query,
  ) {
    return SearchProductsProvider(
      query,
    );
  }

  @override
  SearchProductsProvider getProviderOverride(
    covariant SearchProductsProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchProductsProvider';
}

/// See also [searchProducts].
class SearchProductsProvider extends AutoDisposeStreamProvider<List<Product>> {
  /// See also [searchProducts].
  SearchProductsProvider(
    String query,
  ) : this._internal(
          (ref) => searchProducts(
            ref as SearchProductsRef,
            query,
          ),
          from: searchProductsProvider,
          name: r'searchProductsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchProductsHash,
          dependencies: SearchProductsFamily._dependencies,
          allTransitiveDependencies:
              SearchProductsFamily._allTransitiveDependencies,
          query: query,
        );

  SearchProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    Stream<List<Product>> Function(SearchProductsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchProductsProvider._internal(
        (ref) => create(ref as SearchProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Product>> createElement() {
    return _SearchProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchProductsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchProductsRef on AutoDisposeStreamProviderRef<List<Product>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchProductsProviderElement
    extends AutoDisposeStreamProviderElement<List<Product>>
    with SearchProductsRef {
  _SearchProductsProviderElement(super.provider);

  @override
  String get query => (origin as SearchProductsProvider).query;
}

String _$productsByCategoryHash() =>
    r'ab8148dd8d16ae8eb62490e4dcfdd6f12c9e711d';

/// See also [productsByCategory].
@ProviderFor(productsByCategory)
const productsByCategoryProvider = ProductsByCategoryFamily();

/// See also [productsByCategory].
class ProductsByCategoryFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [productsByCategory].
  const ProductsByCategoryFamily();

  /// See also [productsByCategory].
  ProductsByCategoryProvider call(
    String category,
  ) {
    return ProductsByCategoryProvider(
      category,
    );
  }

  @override
  ProductsByCategoryProvider getProviderOverride(
    covariant ProductsByCategoryProvider provider,
  ) {
    return call(
      provider.category,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsByCategoryProvider';
}

/// See also [productsByCategory].
class ProductsByCategoryProvider
    extends AutoDisposeStreamProvider<List<Product>> {
  /// See also [productsByCategory].
  ProductsByCategoryProvider(
    String category,
  ) : this._internal(
          (ref) => productsByCategory(
            ref as ProductsByCategoryRef,
            category,
          ),
          from: productsByCategoryProvider,
          name: r'productsByCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productsByCategoryHash,
          dependencies: ProductsByCategoryFamily._dependencies,
          allTransitiveDependencies:
              ProductsByCategoryFamily._allTransitiveDependencies,
          category: category,
        );

  ProductsByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  Override overrideWith(
    Stream<List<Product>> Function(ProductsByCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsByCategoryProvider._internal(
        (ref) => create(ref as ProductsByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Product>> createElement() {
    return _ProductsByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsByCategoryProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductsByCategoryRef on AutoDisposeStreamProviderRef<List<Product>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _ProductsByCategoryProviderElement
    extends AutoDisposeStreamProviderElement<List<Product>>
    with ProductsByCategoryRef {
  _ProductsByCategoryProviderElement(super.provider);

  @override
  String get category => (origin as ProductsByCategoryProvider).category;
}

String _$outOfStockProductsHash() =>
    r'0cef04ce2c2be39d931713226038155d88064272';

/// See also [outOfStockProducts].
@ProviderFor(outOfStockProducts)
final outOfStockProductsProvider =
    AutoDisposeStreamProvider<List<Product>>.internal(
  outOfStockProducts,
  name: r'outOfStockProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$outOfStockProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OutOfStockProductsRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$searchCustomersHash() => r'23c2414ca011d6137f974a89b937100380ea17ff';

/// See also [searchCustomers].
@ProviderFor(searchCustomers)
const searchCustomersProvider = SearchCustomersFamily();

/// See also [searchCustomers].
class SearchCustomersFamily extends Family<AsyncValue<List<Customer>>> {
  /// See also [searchCustomers].
  const SearchCustomersFamily();

  /// See also [searchCustomers].
  SearchCustomersProvider call(
    String query,
  ) {
    return SearchCustomersProvider(
      query,
    );
  }

  @override
  SearchCustomersProvider getProviderOverride(
    covariant SearchCustomersProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchCustomersProvider';
}

/// See also [searchCustomers].
class SearchCustomersProvider
    extends AutoDisposeStreamProvider<List<Customer>> {
  /// See also [searchCustomers].
  SearchCustomersProvider(
    String query,
  ) : this._internal(
          (ref) => searchCustomers(
            ref as SearchCustomersRef,
            query,
          ),
          from: searchCustomersProvider,
          name: r'searchCustomersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchCustomersHash,
          dependencies: SearchCustomersFamily._dependencies,
          allTransitiveDependencies:
              SearchCustomersFamily._allTransitiveDependencies,
          query: query,
        );

  SearchCustomersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    Stream<List<Customer>> Function(SearchCustomersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchCustomersProvider._internal(
        (ref) => create(ref as SearchCustomersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Customer>> createElement() {
    return _SearchCustomersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchCustomersProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchCustomersRef on AutoDisposeStreamProviderRef<List<Customer>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchCustomersProviderElement
    extends AutoDisposeStreamProviderElement<List<Customer>>
    with SearchCustomersRef {
  _SearchCustomersProviderElement(super.provider);

  @override
  String get query => (origin as SearchCustomersProvider).query;
}

String _$debtorsHash() => r'39848cce59d7b81a7c8b7e8bdaffafeb9957fd2c';

/// See also [debtors].
@ProviderFor(debtors)
final debtorsProvider = AutoDisposeStreamProvider<List<Customer>>.internal(
  debtors,
  name: r'debtorsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$debtorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DebtorsRef = AutoDisposeStreamProviderRef<List<Customer>>;
String _$customersByDebtStatusHash() =>
    r'88008a823cf637b9f83b7471fbf09af0923603ed';

/// See also [customersByDebtStatus].
@ProviderFor(customersByDebtStatus)
const customersByDebtStatusProvider = CustomersByDebtStatusFamily();

/// See also [customersByDebtStatus].
class CustomersByDebtStatusFamily extends Family<AsyncValue<List<Customer>>> {
  /// See also [customersByDebtStatus].
  const CustomersByDebtStatusFamily();

  /// See also [customersByDebtStatus].
  CustomersByDebtStatusProvider call(
    bool hasDebt,
  ) {
    return CustomersByDebtStatusProvider(
      hasDebt,
    );
  }

  @override
  CustomersByDebtStatusProvider getProviderOverride(
    covariant CustomersByDebtStatusProvider provider,
  ) {
    return call(
      provider.hasDebt,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customersByDebtStatusProvider';
}

/// See also [customersByDebtStatus].
class CustomersByDebtStatusProvider
    extends AutoDisposeStreamProvider<List<Customer>> {
  /// See also [customersByDebtStatus].
  CustomersByDebtStatusProvider(
    bool hasDebt,
  ) : this._internal(
          (ref) => customersByDebtStatus(
            ref as CustomersByDebtStatusRef,
            hasDebt,
          ),
          from: customersByDebtStatusProvider,
          name: r'customersByDebtStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customersByDebtStatusHash,
          dependencies: CustomersByDebtStatusFamily._dependencies,
          allTransitiveDependencies:
              CustomersByDebtStatusFamily._allTransitiveDependencies,
          hasDebt: hasDebt,
        );

  CustomersByDebtStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hasDebt,
  }) : super.internal();

  final bool hasDebt;

  @override
  Override overrideWith(
    Stream<List<Customer>> Function(CustomersByDebtStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomersByDebtStatusProvider._internal(
        (ref) => create(ref as CustomersByDebtStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hasDebt: hasDebt,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Customer>> createElement() {
    return _CustomersByDebtStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomersByDebtStatusProvider && other.hasDebt == hasDebt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hasDebt.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CustomersByDebtStatusRef on AutoDisposeStreamProviderRef<List<Customer>> {
  /// The parameter `hasDebt` of this provider.
  bool get hasDebt;
}

class _CustomersByDebtStatusProviderElement
    extends AutoDisposeStreamProviderElement<List<Customer>>
    with CustomersByDebtStatusRef {
  _CustomersByDebtStatusProviderElement(super.provider);

  @override
  bool get hasDebt => (origin as CustomersByDebtStatusProvider).hasDebt;
}

String _$customerByIdHash() => r'0638eaf7af64c1e98c34af6e0c07f7757ec5589c';

/// See also [customerById].
@ProviderFor(customerById)
const customerByIdProvider = CustomerByIdFamily();

/// See also [customerById].
class CustomerByIdFamily extends Family<AsyncValue<Customer?>> {
  /// See also [customerById].
  const CustomerByIdFamily();

  /// See also [customerById].
  CustomerByIdProvider call(
    int id,
  ) {
    return CustomerByIdProvider(
      id,
    );
  }

  @override
  CustomerByIdProvider getProviderOverride(
    covariant CustomerByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'customerByIdProvider';
}

/// See also [customerById].
class CustomerByIdProvider extends AutoDisposeStreamProvider<Customer?> {
  /// See also [customerById].
  CustomerByIdProvider(
    int id,
  ) : this._internal(
          (ref) => customerById(
            ref as CustomerByIdRef,
            id,
          ),
          from: customerByIdProvider,
          name: r'customerByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerByIdHash,
          dependencies: CustomerByIdFamily._dependencies,
          allTransitiveDependencies:
              CustomerByIdFamily._allTransitiveDependencies,
          id: id,
        );

  CustomerByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Stream<Customer?> Function(CustomerByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CustomerByIdProvider._internal(
        (ref) => create(ref as CustomerByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Customer?> createElement() {
    return _CustomerByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CustomerByIdRef on AutoDisposeStreamProviderRef<Customer?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _CustomerByIdProviderElement
    extends AutoDisposeStreamProviderElement<Customer?> with CustomerByIdRef {
  _CustomerByIdProviderElement(super.provider);

  @override
  int get id => (origin as CustomerByIdProvider).id;
}

String _$productByIdHash() => r'0d1415e269c574577c14ee3243416e157f4e4862';

/// See also [productById].
@ProviderFor(productById)
const productByIdProvider = ProductByIdFamily();

/// See also [productById].
class ProductByIdFamily extends Family<AsyncValue<Product?>> {
  /// See also [productById].
  const ProductByIdFamily();

  /// See also [productById].
  ProductByIdProvider call(
    int id,
  ) {
    return ProductByIdProvider(
      id,
    );
  }

  @override
  ProductByIdProvider getProviderOverride(
    covariant ProductByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productByIdProvider';
}

/// See also [productById].
class ProductByIdProvider extends AutoDisposeStreamProvider<Product?> {
  /// See also [productById].
  ProductByIdProvider(
    int id,
  ) : this._internal(
          (ref) => productById(
            ref as ProductByIdRef,
            id,
          ),
          from: productByIdProvider,
          name: r'productByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productByIdHash,
          dependencies: ProductByIdFamily._dependencies,
          allTransitiveDependencies:
              ProductByIdFamily._allTransitiveDependencies,
          id: id,
        );

  ProductByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Stream<Product?> Function(ProductByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductByIdProvider._internal(
        (ref) => create(ref as ProductByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Product?> createElement() {
    return _ProductByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductByIdRef on AutoDisposeStreamProviderRef<Product?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ProductByIdProviderElement
    extends AutoDisposeStreamProviderElement<Product?> with ProductByIdRef {
  _ProductByIdProviderElement(super.provider);

  @override
  int get id => (origin as ProductByIdProvider).id;
}

String _$productByBarcodeHash() => r'2f7b95c2fcc742c7023c80d2952d3ac3255e572e';

/// See also [productByBarcode].
@ProviderFor(productByBarcode)
const productByBarcodeProvider = ProductByBarcodeFamily();

/// See also [productByBarcode].
class ProductByBarcodeFamily extends Family<AsyncValue<Product?>> {
  /// See also [productByBarcode].
  const ProductByBarcodeFamily();

  /// See also [productByBarcode].
  ProductByBarcodeProvider call(
    String barcode,
  ) {
    return ProductByBarcodeProvider(
      barcode,
    );
  }

  @override
  ProductByBarcodeProvider getProviderOverride(
    covariant ProductByBarcodeProvider provider,
  ) {
    return call(
      provider.barcode,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productByBarcodeProvider';
}

/// See also [productByBarcode].
class ProductByBarcodeProvider extends AutoDisposeStreamProvider<Product?> {
  /// See also [productByBarcode].
  ProductByBarcodeProvider(
    String barcode,
  ) : this._internal(
          (ref) => productByBarcode(
            ref as ProductByBarcodeRef,
            barcode,
          ),
          from: productByBarcodeProvider,
          name: r'productByBarcodeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productByBarcodeHash,
          dependencies: ProductByBarcodeFamily._dependencies,
          allTransitiveDependencies:
              ProductByBarcodeFamily._allTransitiveDependencies,
          barcode: barcode,
        );

  ProductByBarcodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.barcode,
  }) : super.internal();

  final String barcode;

  @override
  Override overrideWith(
    Stream<Product?> Function(ProductByBarcodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductByBarcodeProvider._internal(
        (ref) => create(ref as ProductByBarcodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        barcode: barcode,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Product?> createElement() {
    return _ProductByBarcodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductByBarcodeProvider && other.barcode == barcode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, barcode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductByBarcodeRef on AutoDisposeStreamProviderRef<Product?> {
  /// The parameter `barcode` of this provider.
  String get barcode;
}

class _ProductByBarcodeProviderElement
    extends AutoDisposeStreamProviderElement<Product?>
    with ProductByBarcodeRef {
  _ProductByBarcodeProviderElement(super.provider);

  @override
  String get barcode => (origin as ProductByBarcodeProvider).barcode;
}

String _$invoiceByIdHash() => r'b012e700ffcd71452d5c4fb20455b28cf6a32d62';

/// See also [invoiceById].
@ProviderFor(invoiceById)
const invoiceByIdProvider = InvoiceByIdFamily();

/// See also [invoiceById].
class InvoiceByIdFamily extends Family<AsyncValue<Invoice?>> {
  /// See also [invoiceById].
  const InvoiceByIdFamily();

  /// See also [invoiceById].
  InvoiceByIdProvider call(
    int id,
  ) {
    return InvoiceByIdProvider(
      id,
    );
  }

  @override
  InvoiceByIdProvider getProviderOverride(
    covariant InvoiceByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'invoiceByIdProvider';
}

/// See also [invoiceById].
class InvoiceByIdProvider extends AutoDisposeStreamProvider<Invoice?> {
  /// See also [invoiceById].
  InvoiceByIdProvider(
    int id,
  ) : this._internal(
          (ref) => invoiceById(
            ref as InvoiceByIdRef,
            id,
          ),
          from: invoiceByIdProvider,
          name: r'invoiceByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoiceByIdHash,
          dependencies: InvoiceByIdFamily._dependencies,
          allTransitiveDependencies:
              InvoiceByIdFamily._allTransitiveDependencies,
          id: id,
        );

  InvoiceByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Stream<Invoice?> Function(InvoiceByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvoiceByIdProvider._internal(
        (ref) => create(ref as InvoiceByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Invoice?> createElement() {
    return _InvoiceByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoiceByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InvoiceByIdRef on AutoDisposeStreamProviderRef<Invoice?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _InvoiceByIdProviderElement
    extends AutoDisposeStreamProviderElement<Invoice?> with InvoiceByIdRef {
  _InvoiceByIdProviderElement(super.provider);

  @override
  int get id => (origin as InvoiceByIdProvider).id;
}

String _$paymentByIdHash() => r'43bbd930abbf4f04417f55a8bc2863276245e3b9';

/// See also [paymentById].
@ProviderFor(paymentById)
const paymentByIdProvider = PaymentByIdFamily();

/// See also [paymentById].
class PaymentByIdFamily extends Family<AsyncValue<Payment?>> {
  /// See also [paymentById].
  const PaymentByIdFamily();

  /// See also [paymentById].
  PaymentByIdProvider call(
    int id,
  ) {
    return PaymentByIdProvider(
      id,
    );
  }

  @override
  PaymentByIdProvider getProviderOverride(
    covariant PaymentByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'paymentByIdProvider';
}

/// See also [paymentById].
class PaymentByIdProvider extends AutoDisposeStreamProvider<Payment?> {
  /// See also [paymentById].
  PaymentByIdProvider(
    int id,
  ) : this._internal(
          (ref) => paymentById(
            ref as PaymentByIdRef,
            id,
          ),
          from: paymentByIdProvider,
          name: r'paymentByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paymentByIdHash,
          dependencies: PaymentByIdFamily._dependencies,
          allTransitiveDependencies:
              PaymentByIdFamily._allTransitiveDependencies,
          id: id,
        );

  PaymentByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Stream<Payment?> Function(PaymentByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PaymentByIdProvider._internal(
        (ref) => create(ref as PaymentByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Payment?> createElement() {
    return _PaymentByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PaymentByIdRef on AutoDisposeStreamProviderRef<Payment?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PaymentByIdProviderElement
    extends AutoDisposeStreamProviderElement<Payment?> with PaymentByIdRef {
  _PaymentByIdProviderElement(super.provider);

  @override
  int get id => (origin as PaymentByIdProvider).id;
}

String _$invoicesByCustomerIdHash() =>
    r'16db580c0feaf9255751764e1973e2653ac1761a';

/// See also [invoicesByCustomerId].
@ProviderFor(invoicesByCustomerId)
const invoicesByCustomerIdProvider = InvoicesByCustomerIdFamily();

/// See also [invoicesByCustomerId].
class InvoicesByCustomerIdFamily extends Family<AsyncValue<List<Invoice>>> {
  /// See also [invoicesByCustomerId].
  const InvoicesByCustomerIdFamily();

  /// See also [invoicesByCustomerId].
  InvoicesByCustomerIdProvider call(
    int customerId,
  ) {
    return InvoicesByCustomerIdProvider(
      customerId,
    );
  }

  @override
  InvoicesByCustomerIdProvider getProviderOverride(
    covariant InvoicesByCustomerIdProvider provider,
  ) {
    return call(
      provider.customerId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'invoicesByCustomerIdProvider';
}

/// See also [invoicesByCustomerId].
class InvoicesByCustomerIdProvider
    extends AutoDisposeStreamProvider<List<Invoice>> {
  /// See also [invoicesByCustomerId].
  InvoicesByCustomerIdProvider(
    int customerId,
  ) : this._internal(
          (ref) => invoicesByCustomerId(
            ref as InvoicesByCustomerIdRef,
            customerId,
          ),
          from: invoicesByCustomerIdProvider,
          name: r'invoicesByCustomerIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoicesByCustomerIdHash,
          dependencies: InvoicesByCustomerIdFamily._dependencies,
          allTransitiveDependencies:
              InvoicesByCustomerIdFamily._allTransitiveDependencies,
          customerId: customerId,
        );

  InvoicesByCustomerIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.customerId,
  }) : super.internal();

  final int customerId;

  @override
  Override overrideWith(
    Stream<List<Invoice>> Function(InvoicesByCustomerIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvoicesByCustomerIdProvider._internal(
        (ref) => create(ref as InvoicesByCustomerIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        customerId: customerId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Invoice>> createElement() {
    return _InvoicesByCustomerIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoicesByCustomerIdProvider &&
        other.customerId == customerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, customerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InvoicesByCustomerIdRef on AutoDisposeStreamProviderRef<List<Invoice>> {
  /// The parameter `customerId` of this provider.
  int get customerId;
}

class _InvoicesByCustomerIdProviderElement
    extends AutoDisposeStreamProviderElement<List<Invoice>>
    with InvoicesByCustomerIdRef {
  _InvoicesByCustomerIdProviderElement(super.provider);

  @override
  int get customerId => (origin as InvoicesByCustomerIdProvider).customerId;
}

String _$invoicesByStatusHash() => r'496da3539d10b0782e0d5d59fc352debceedb761';

/// See also [invoicesByStatus].
@ProviderFor(invoicesByStatus)
const invoicesByStatusProvider = InvoicesByStatusFamily();

/// See also [invoicesByStatus].
class InvoicesByStatusFamily extends Family<AsyncValue<List<Invoice>>> {
  /// See also [invoicesByStatus].
  const InvoicesByStatusFamily();

  /// See also [invoicesByStatus].
  InvoicesByStatusProvider call(
    String status,
  ) {
    return InvoicesByStatusProvider(
      status,
    );
  }

  @override
  InvoicesByStatusProvider getProviderOverride(
    covariant InvoicesByStatusProvider provider,
  ) {
    return call(
      provider.status,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'invoicesByStatusProvider';
}

/// See also [invoicesByStatus].
class InvoicesByStatusProvider
    extends AutoDisposeStreamProvider<List<Invoice>> {
  /// See also [invoicesByStatus].
  InvoicesByStatusProvider(
    String status,
  ) : this._internal(
          (ref) => invoicesByStatus(
            ref as InvoicesByStatusRef,
            status,
          ),
          from: invoicesByStatusProvider,
          name: r'invoicesByStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoicesByStatusHash,
          dependencies: InvoicesByStatusFamily._dependencies,
          allTransitiveDependencies:
              InvoicesByStatusFamily._allTransitiveDependencies,
          status: status,
        );

  InvoicesByStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String status;

  @override
  Override overrideWith(
    Stream<List<Invoice>> Function(InvoicesByStatusRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvoicesByStatusProvider._internal(
        (ref) => create(ref as InvoicesByStatusRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Invoice>> createElement() {
    return _InvoicesByStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoicesByStatusProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InvoicesByStatusRef on AutoDisposeStreamProviderRef<List<Invoice>> {
  /// The parameter `status` of this provider.
  String get status;
}

class _InvoicesByStatusProviderElement
    extends AutoDisposeStreamProviderElement<List<Invoice>>
    with InvoicesByStatusRef {
  _InvoicesByStatusProviderElement(super.provider);

  @override
  String get status => (origin as InvoicesByStatusProvider).status;
}

String _$invoiceItemsHash() => r'd7ccc6fc3bbb7b9675f0e42666665e3f7098b35e';

/// See also [invoiceItems].
@ProviderFor(invoiceItems)
const invoiceItemsProvider = InvoiceItemsFamily();

/// See also [invoiceItems].
class InvoiceItemsFamily extends Family<AsyncValue<List<InvoiceItem>>> {
  /// See also [invoiceItems].
  const InvoiceItemsFamily();

  /// See also [invoiceItems].
  InvoiceItemsProvider call(
    int invoiceId,
  ) {
    return InvoiceItemsProvider(
      invoiceId,
    );
  }

  @override
  InvoiceItemsProvider getProviderOverride(
    covariant InvoiceItemsProvider provider,
  ) {
    return call(
      provider.invoiceId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'invoiceItemsProvider';
}

/// See also [invoiceItems].
class InvoiceItemsProvider
    extends AutoDisposeStreamProvider<List<InvoiceItem>> {
  /// See also [invoiceItems].
  InvoiceItemsProvider(
    int invoiceId,
  ) : this._internal(
          (ref) => invoiceItems(
            ref as InvoiceItemsRef,
            invoiceId,
          ),
          from: invoiceItemsProvider,
          name: r'invoiceItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$invoiceItemsHash,
          dependencies: InvoiceItemsFamily._dependencies,
          allTransitiveDependencies:
              InvoiceItemsFamily._allTransitiveDependencies,
          invoiceId: invoiceId,
        );

  InvoiceItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.invoiceId,
  }) : super.internal();

  final int invoiceId;

  @override
  Override overrideWith(
    Stream<List<InvoiceItem>> Function(InvoiceItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InvoiceItemsProvider._internal(
        (ref) => create(ref as InvoiceItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        invoiceId: invoiceId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<InvoiceItem>> createElement() {
    return _InvoiceItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InvoiceItemsProvider && other.invoiceId == invoiceId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, invoiceId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin InvoiceItemsRef on AutoDisposeStreamProviderRef<List<InvoiceItem>> {
  /// The parameter `invoiceId` of this provider.
  int get invoiceId;
}

class _InvoiceItemsProviderElement
    extends AutoDisposeStreamProviderElement<List<InvoiceItem>>
    with InvoiceItemsRef {
  _InvoiceItemsProviderElement(super.provider);

  @override
  int get invoiceId => (origin as InvoiceItemsProvider).invoiceId;
}

String _$productSalesHistoryHash() =>
    r'6fff39c788a4690a6672fceb4d4ed150a09571a7';

/// See also [productSalesHistory].
@ProviderFor(productSalesHistory)
const productSalesHistoryProvider = ProductSalesHistoryFamily();

/// See also [productSalesHistory].
class ProductSalesHistoryFamily
    extends Family<AsyncValue<List<ProductSaleRecord>>> {
  /// See also [productSalesHistory].
  const ProductSalesHistoryFamily();

  /// See also [productSalesHistory].
  ProductSalesHistoryProvider call(
    int productId,
  ) {
    return ProductSalesHistoryProvider(
      productId,
    );
  }

  @override
  ProductSalesHistoryProvider getProviderOverride(
    covariant ProductSalesHistoryProvider provider,
  ) {
    return call(
      provider.productId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productSalesHistoryProvider';
}

/// See also [productSalesHistory].
class ProductSalesHistoryProvider
    extends AutoDisposeStreamProvider<List<ProductSaleRecord>> {
  /// See also [productSalesHistory].
  ProductSalesHistoryProvider(
    int productId,
  ) : this._internal(
          (ref) => productSalesHistory(
            ref as ProductSalesHistoryRef,
            productId,
          ),
          from: productSalesHistoryProvider,
          name: r'productSalesHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productSalesHistoryHash,
          dependencies: ProductSalesHistoryFamily._dependencies,
          allTransitiveDependencies:
              ProductSalesHistoryFamily._allTransitiveDependencies,
          productId: productId,
        );

  ProductSalesHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  Override overrideWith(
    Stream<List<ProductSaleRecord>> Function(ProductSalesHistoryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductSalesHistoryProvider._internal(
        (ref) => create(ref as ProductSalesHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ProductSaleRecord>> createElement() {
    return _ProductSalesHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductSalesHistoryProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductSalesHistoryRef
    on AutoDisposeStreamProviderRef<List<ProductSaleRecord>> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _ProductSalesHistoryProviderElement
    extends AutoDisposeStreamProviderElement<List<ProductSaleRecord>>
    with ProductSalesHistoryRef {
  _ProductSalesHistoryProviderElement(super.provider);

  @override
  int get productId => (origin as ProductSalesHistoryProvider).productId;
}

String _$paymentsByCustomerIdHash() =>
    r'211f2029ac15e7565c50c02239332683bb81c30a';

/// See also [paymentsByCustomerId].
@ProviderFor(paymentsByCustomerId)
const paymentsByCustomerIdProvider = PaymentsByCustomerIdFamily();

/// See also [paymentsByCustomerId].
class PaymentsByCustomerIdFamily extends Family<AsyncValue<List<Payment>>> {
  /// See also [paymentsByCustomerId].
  const PaymentsByCustomerIdFamily();

  /// See also [paymentsByCustomerId].
  PaymentsByCustomerIdProvider call(
    int customerId,
  ) {
    return PaymentsByCustomerIdProvider(
      customerId,
    );
  }

  @override
  PaymentsByCustomerIdProvider getProviderOverride(
    covariant PaymentsByCustomerIdProvider provider,
  ) {
    return call(
      provider.customerId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'paymentsByCustomerIdProvider';
}

/// See also [paymentsByCustomerId].
class PaymentsByCustomerIdProvider
    extends AutoDisposeStreamProvider<List<Payment>> {
  /// See also [paymentsByCustomerId].
  PaymentsByCustomerIdProvider(
    int customerId,
  ) : this._internal(
          (ref) => paymentsByCustomerId(
            ref as PaymentsByCustomerIdRef,
            customerId,
          ),
          from: paymentsByCustomerIdProvider,
          name: r'paymentsByCustomerIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paymentsByCustomerIdHash,
          dependencies: PaymentsByCustomerIdFamily._dependencies,
          allTransitiveDependencies:
              PaymentsByCustomerIdFamily._allTransitiveDependencies,
          customerId: customerId,
        );

  PaymentsByCustomerIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.customerId,
  }) : super.internal();

  final int customerId;

  @override
  Override overrideWith(
    Stream<List<Payment>> Function(PaymentsByCustomerIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PaymentsByCustomerIdProvider._internal(
        (ref) => create(ref as PaymentsByCustomerIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        customerId: customerId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Payment>> createElement() {
    return _PaymentsByCustomerIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentsByCustomerIdProvider &&
        other.customerId == customerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, customerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PaymentsByCustomerIdRef on AutoDisposeStreamProviderRef<List<Payment>> {
  /// The parameter `customerId` of this provider.
  int get customerId;
}

class _PaymentsByCustomerIdProviderElement
    extends AutoDisposeStreamProviderElement<List<Payment>>
    with PaymentsByCustomerIdRef {
  _PaymentsByCustomerIdProviderElement(super.provider);

  @override
  int get customerId => (origin as PaymentsByCustomerIdProvider).customerId;
}

String _$paymentsByMethodHash() => r'e527c8d1e5ef4af55d368f30c7460301ee78db4b';

/// See also [paymentsByMethod].
@ProviderFor(paymentsByMethod)
const paymentsByMethodProvider = PaymentsByMethodFamily();

/// See also [paymentsByMethod].
class PaymentsByMethodFamily extends Family<AsyncValue<List<Payment>>> {
  /// See also [paymentsByMethod].
  const PaymentsByMethodFamily();

  /// See also [paymentsByMethod].
  PaymentsByMethodProvider call(
    String method,
  ) {
    return PaymentsByMethodProvider(
      method,
    );
  }

  @override
  PaymentsByMethodProvider getProviderOverride(
    covariant PaymentsByMethodProvider provider,
  ) {
    return call(
      provider.method,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'paymentsByMethodProvider';
}

/// See also [paymentsByMethod].
class PaymentsByMethodProvider
    extends AutoDisposeStreamProvider<List<Payment>> {
  /// See also [paymentsByMethod].
  PaymentsByMethodProvider(
    String method,
  ) : this._internal(
          (ref) => paymentsByMethod(
            ref as PaymentsByMethodRef,
            method,
          ),
          from: paymentsByMethodProvider,
          name: r'paymentsByMethodProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paymentsByMethodHash,
          dependencies: PaymentsByMethodFamily._dependencies,
          allTransitiveDependencies:
              PaymentsByMethodFamily._allTransitiveDependencies,
          method: method,
        );

  PaymentsByMethodProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.method,
  }) : super.internal();

  final String method;

  @override
  Override overrideWith(
    Stream<List<Payment>> Function(PaymentsByMethodRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PaymentsByMethodProvider._internal(
        (ref) => create(ref as PaymentsByMethodRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        method: method,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Payment>> createElement() {
    return _PaymentsByMethodProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentsByMethodProvider && other.method == method;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, method.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PaymentsByMethodRef on AutoDisposeStreamProviderRef<List<Payment>> {
  /// The parameter `method` of this provider.
  String get method;
}

class _PaymentsByMethodProviderElement
    extends AutoDisposeStreamProviderElement<List<Payment>>
    with PaymentsByMethodRef {
  _PaymentsByMethodProviderElement(super.provider);

  @override
  String get method => (origin as PaymentsByMethodProvider).method;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
