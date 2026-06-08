import '../../core/enums/app_enums.dart';

class PaymentModel {
  final String id;
  final String customerId;
  final String customerName;
  final double amount;
  final DateTime date;
  final PaymentMethod method;
  final String? note;

  PaymentModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.amount,
    required this.date,
    required this.method,
    this.note,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] ?? '',
      customerId: json['customer_id'] ?? '',
      customerName: json['customer_name'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      date: DateTime.parse(json['date']),
      method: PaymentMethod.values.firstWhere(
            (e) => e.name == json['method'],
        orElse: () => PaymentMethod.cash,
      ),
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'customer_name': customerName,
      'amount': amount,
      'date': date.toIso8601String(),
      'method': method.name,
      'note': note,
    };
  }
}