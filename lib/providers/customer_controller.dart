// import 'package:drift/drift.dart';
// import 'package:pos/providers/repository_providers.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:pos/data/local/database.dart';
// import 'package:pos/repositories/customer_repository.dart';
// import 'package:pos/core/providers/database_provider.dart';
//
// part 'customer_controller.g.dart';
//
// // 1. تعريف الـ Provider الخاص بالمستودع هنا مباشرة
// @Riverpod(keepAlive: true)
// CustomerRepository customerRepository(CustomerRepositoryRef ref) {
//   return CustomerRepository(ref.watch(databaseProvider));
// }
//
// // 2. المتحكم الخاص بالواجهة
// @riverpod
// class CustomerController extends _$CustomerController {
//   @override
//   FutureOr<void> build() {
//     return null;
//   }
//
//   Future<bool> addCustomer({
//     required String name,
//     String? phone,
//   }) async {
//     state = const AsyncValue.loading();
//     try {
//       final customer = CustomersCompanion.insert(
//         name: name,
//         phone: Value(phone),
//         totalDebt: const Value(0.0),
//       );
//
//       // الآن سيقرأ من المزود المعرف في الأعلى بكل سهولة
//       await ref.read(customerRepositoryProvider).addCustomer(customer);
//
//       state = const AsyncValue.data(null);
//       return true;
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//       return false;
//     }
//   }
//
//
// }

import 'package:drift/drift.dart';
import 'package:pos/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pos/data/local/database.dart';
import 'package:pos/repositories/customer_repository.dart';
import 'package:pos/core/providers/database_provider.dart';

part 'customer_controller.g.dart';

// 1. تعريف الـ Provider الخاص بالمستودع
@Riverpod(keepAlive: true)
CustomerRepository customerRepository(CustomerRepositoryRef ref) {
  return CustomerRepository(ref.watch(databaseProvider));
}

// 2. مزود البيانات الحية (Stream) لجلب قائمة الزبائن وتحديثها تلقائياً
@riverpod
Stream<List<Customer>> customersList(CustomersListRef ref) {
  return ref.watch(customerRepositoryProvider).getAllCustomers();
}

// 3. المتحكم الخاص بالعمليات (إضافة، تعديل، حذف)
@riverpod
class CustomerController extends _$CustomerController {
  @override
  FutureOr<void> build() {
    return null;
  }

  // إضافة زبون
  Future<bool> addCustomer({
    required String name,
    String? phone,
  }) async {
    state = const AsyncValue.loading();
    try {
      final customer = CustomersCompanion.insert(
        name: name,
        phone: Value(phone),
        totalDebt: const Value(0.0),
      );
      await ref.read(customerRepositoryProvider).addCustomer(customer);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  // تعديل بيانات زبون
  Future<bool> updateCustomer(Customer customer) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(customerRepositoryProvider).updateCustomer(customer);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  // حذف زبون
  Future<bool> deleteCustomer(int customerId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(customerRepositoryProvider).deleteCustomer(customerId);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}