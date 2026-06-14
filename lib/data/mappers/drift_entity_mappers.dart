import 'package:drift/drift.dart' as drift;
import 'package:pos/data/local/database.dart';
import 'package:pos/data/models/customer_model.dart';
import 'package:pos/data/models/payment_model.dart';
import 'package:pos/data/models/product_model.dart';
import 'package:pos/core/enums/app_enums.dart';

/// Extension methods for converting Drift entities to Models
extension ProductMapper on Product {
  ProductModel toModel() {
    return ProductModel(
      id: id,
      name: name,
      category: category,
      barcode: barcode,
      price: price,
      stockQuantity: stockQuantity,
      trackStock: trackStock,
    );
  }
}

extension CustomerMapper on Customer {
  CustomerModel toModel() {
    return CustomerModel(
      id: id,
      name: name,
      phoneNumber: phone ?? '',
      totalDebt: totalDebt,
      status: totalDebt > 0 ? CustomerStatus.debtor : CustomerStatus.settled,
      avatarUrl: null,
    );
  }
}

extension PaymentMapper on Payment {
  PaymentModel toModel(String customerName) {
    return PaymentModel(
      id: id,
      customerId: customerId,
      customerName: customerName,
      amount: amount,
      date: date,
      method: PaymentMethod.values.firstWhere(
        (e) => e.name == method,
        orElse: () => PaymentMethod.cash,
      ),
      note: note,
    );
  }
}

/// Mappers for creating Drift companions from Models
extension ProductModelToDrift on ProductModel {
  ProductsCompanion toCompanion() {
    return ProductsCompanion(
      id: id > 0 ? drift.Value(id) : drift.Value.absent(),
      name: drift.Value(name),
      category: drift.Value(category),
      barcode: drift.Value(barcode),
      price: drift.Value(price),
      stockQuantity: drift.Value(stockQuantity),
      trackStock: drift.Value(trackStock),
    );
  }
}

extension CustomerModelToDrift on CustomerModel {
  CustomersCompanion toCompanion() {
    return CustomersCompanion(
      id: id > 0 ? drift.Value(id) : drift.Value.absent(),
      name: drift.Value(name),
      phone: drift.Value(phoneNumber),
      totalDebt: drift.Value(totalDebt),
    );
  }
}

extension PaymentModelToDrift on PaymentModel {
  PaymentsCompanion toCompanion() {
    return PaymentsCompanion(
      id: id > 0 ? drift.Value(id) : drift.Value.absent(),
      customerId: drift.Value(customerId),
      amount: drift.Value(amount),
      date: drift.Value(date),
      method: drift.Value(method.name),
      note: drift.Value(note),
    );
  }
}

/// List conversion extensions
extension ProductListMapper on List<Product> {
  List<ProductModel> toModels() => map((e) => e.toModel()).toList();
}

extension CustomerListMapper on List<Customer> {
  List<CustomerModel> toModels() => map((e) => e.toModel()).toList();
}

extension PaymentListMapper on List<Payment> {
  /// Note: This requires customer names to be passed separately in real usage
  /// For batch conversion, you'd typically join with customers table
  List<PaymentModel> toModels({Map<int, String>? customerNames}) {
    return map((e) => e.toModel(customerNames?[e.customerId] ?? 'Unknown')).toList();
  }
}



