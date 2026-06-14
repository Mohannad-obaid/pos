// import 'package:pos/data/models/cart_item_model.dart';
// import 'package:pos/data/models/product_model.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'cart_provider.g.dart';
//
// @riverpod
// class Cart extends _$Cart {
//   @override
//   List<CartItemModel> build() {
//     // الحالة الابتدائية: سلة فارغة
//     return [];
//   }
//
//   // إضافة منتج للسلة
//   void addProduct(ProductModel product) {
//     // البحث عما إذا كان المنتج موجوداً مسبقاً في السلة
//     final index = state.indexWhere((item) => item.product.id == product.id);
//
//     if (index != -1) {
//       // إذا كان موجوداً، نقوم بزيادة الكمية فقط
//       final currentItem = state[index];
//       final updatedItem = currentItem.copyWith(quantity: currentItem.quantity + 1);
//
//       state = [
//         ...state.sublist(0, index),
//         updatedItem,
//         ...state.sublist(index + 1),
//       ];
//     } else {
//       // إذا لم يكن موجوداً، نضيفه كعنصر جديد
//       state = [...state, CartItemModel(product: product, quantity: 1)];
//     }
//   }
//
//   // إنقاص الكمية أو حذف المنتج إذا وصلت الكمية للصفر
//   void decreaseQuantity(int productId) {
//     final index = state.indexWhere((item) => item.product.id == productId);
//     if (index != -1) {
//       final currentItem = state[index];
//
//       if (currentItem.quantity > 1) {
//         // إنقاص الكمية
//         final updatedItem = currentItem.copyWith(quantity: currentItem.quantity - 1);
//         state = [
//           ...state.sublist(0, index),
//           updatedItem,
//           ...state.sublist(index + 1),
//         ];
//       } else {
//         // حذف العنصر تماماً
//         removeProduct(productId);
//       }
//     }
//   }
//
//   // حذف المنتج بالكامل من السلة
//   void removeProduct(int productId) {
//     state = state.where((item) => item.product.id != productId).toList();
//   }
//
//   // تفريغ السلة بالكامل (بعد إتمام الدفع أو للإلغاء)
//   void clearCart() {
//     state = [];
//   }
// }
//
// // Provider منفصل لحساب الإجمالي تلقائياً (يتحدث فوراً عند أي تغيير في السلة)
// @riverpod
// double cartTotal(CartTotalRef ref) {
//   final cartItems = ref.watch(cartProvider);
//   return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
// }
//
// // Provider لمعرفة عدد العناصر الكلي في السلة
// @riverpod
// int cartItemsCount(CartItemsCountRef ref) {
//   final cartItems = ref.watch(cartProvider);
//   return cartItems.fold(0, (sum, item) => sum + item.quantity);
// }

import 'package:pos/data/models/cart_item_model.dart';
import 'package:pos/data/local/database.dart'; // <--- استدعاء قاعدة البيانات الحقيقية
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  @override
  List<CartItemModel> build() {
    // الحالة الابتدائية: سلة فارغة
    return [];
  }

  // إضافة منتج للسلة
  void addProduct(Product product) { // <--- التعديل هنا: Product بدلاً من ProductModel
    // البحث عما إذا كان المنتج موجوداً مسبقاً في السلة
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      // إذا كان موجوداً، نقوم بزيادة الكمية فقط
      final currentItem = state[index];
      final updatedItem = currentItem.copyWith(quantity: currentItem.quantity + 1);

      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else {
      // إذا لم يكن موجوداً، نضيفه كعنصر جديد
      state = [...state, CartItemModel(product: product, quantity: 1)];
    }
  }

  // إنقاص الكمية أو حذف المنتج إذا وصلت الكمية للصفر
  void decreaseQuantity(int productId) { // الـ ID في Drift هو int وهذا ممتاز
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      final currentItem = state[index];

      if (currentItem.quantity > 1) {
        // إنقاص الكمية
        final updatedItem = currentItem.copyWith(quantity: currentItem.quantity - 1);
        state = [
          ...state.sublist(0, index),
          updatedItem,
          ...state.sublist(index + 1),
        ];
      } else {
        // حذف العنصر تماماً
        removeProduct(productId);
      }
    }
  }

  // حذف المنتج بالكامل من السلة
  void removeProduct(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  // تفريغ السلة بالكامل (بعد إتمام الدفع أو للإلغاء)
  void clearCart() {
    state = [];
  }
}

// Provider منفصل لحساب الإجمالي تلقائياً (يتحدث فوراً عند أي تغيير في السلة)
@Riverpod(keepAlive: true)
double cartTotal(CartTotalRef ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
}

// Provider لمعرفة عدد العناصر الكلي في السلة
@Riverpod(keepAlive: true)
int cartItemsCount(CartItemsCountRef ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
}