// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_controller.dart';

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
String _$customerControllerHash() =>
    r'28c4401281c4fab7663dfbecfcac482d43386726';

/// See also [CustomerController].
@ProviderFor(CustomerController)
final customerControllerProvider =
    AutoDisposeAsyncNotifierProvider<CustomerController, void>.internal(
  CustomerController.new,
  name: r'customerControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomerController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
