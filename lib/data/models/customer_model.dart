import '../../core/enums/app_enums.dart';

class CustomerModel {
  final String id;
  final String name;
  final String phoneNumber;
  final double totalDebt;
  final CustomerStatus status;
  final String? avatarUrl;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.totalDebt = 0.0,
    this.status = CustomerStatus.settled,
    this.avatarUrl,
  });

  // لإنشاء نسخة معدلة من الأوبجكت (مفيد جداً في إدارة الحالة مثل Bloc/Provider)
  CustomerModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    double? totalDebt,
    CustomerStatus? status,
    String? avatarUrl,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      totalDebt: totalDebt ?? this.totalDebt,
      status: status ?? this.status,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      totalDebt: (json['total_debt'] ?? 0.0).toDouble(),
      status: CustomerStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => CustomerStatus.settled,
      ),
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'total_debt': totalDebt,
      'status': status.name,
      'avatar_url': avatarUrl,
    };
  }
}