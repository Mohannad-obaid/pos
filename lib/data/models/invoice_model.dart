import '../../core/enums/app_enums.dart';
import 'cart_item_model.dart';

class InvoiceModel {
  final int id;
  final int? customerId; // null إذا كانت المبيعات كاش لزبون غير مسجل
  final String customerName;
  final DateTime date;
  final InvoiceStatus status;
  final List<CartItemModel> items;

  InvoiceModel({
    required this.id,
    this.customerId,
    required this.customerName,
    required this.date,
    required this.status,
    required this.items,
  });

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] as int,
      customerId: json['customer_id'] as int?,
      customerName: json['customer_name'] ?? '',
      date: DateTime.parse(json['date']),
      status: InvoiceStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => InvoiceStatus.cash,
      ),
      items: (json['items'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'customer_name': customerName,
      'date': date.toIso8601String(),
      'status': status.name,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}