// import 'product_model.dart';
//
// class CartItemModel {
//   final ProductModel product;
//   int quantity;
//
//   CartItemModel({
//     required this.product,
//     this.quantity = 1,
//   });
//
//   double get totalPrice => product.price * quantity;
//
//   CartItemModel copyWith({
//     ProductModel? product,
//     int? quantity,
//   }) {
//     return CartItemModel(
//       product: product ?? this.product,
//       quantity: quantity ?? this.quantity,
//     );
//   }
//
//   factory CartItemModel.fromJson(Map<String, dynamic> json) {
//     return CartItemModel(
//       product: ProductModel.fromJson(json['product']),
//       quantity: json['quantity'] ?? 1,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'product': product.toJson(),
//       'quantity': quantity,
//     };
//   }
// }

import '../../data/local/database.dart';

class CartItemModel {
  final Product product; // <--- تم التعديل لاستخدام كلاس Drift
  final int quantity; // <--- يفضل دائماً أن تكون final مع Riverpod

  CartItemModel({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  CartItemModel copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      // Drift يوفر دالة fromJson جاهزة للكلاس المولد
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // Drift يوفر دالة toJson جاهزة أيضاً
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}