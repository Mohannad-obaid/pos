// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartTotalHash() => r'5193e02e2cfdce217f54d8b99aaed4efbdf52725';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider = Provider<double>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartTotalRef = ProviderRef<double>;
String _$cartItemsCountHash() => r'de136a2b8d37dbb11f27f1073d5c637d371c5dae';

/// See also [cartItemsCount].
@ProviderFor(cartItemsCount)
final cartItemsCountProvider = Provider<int>.internal(
  cartItemsCount,
  name: r'cartItemsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartItemsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartItemsCountRef = ProviderRef<int>;
String _$cartHash() => r'94fc7bb65caf07fd46ba85c5eb912a22a91858c3';

/// See also [Cart].
@ProviderFor(Cart)
final cartProvider = NotifierProvider<Cart, List<CartItemModel>>.internal(
  Cart.new,
  name: r'cartProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Cart = Notifier<List<CartItemModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
