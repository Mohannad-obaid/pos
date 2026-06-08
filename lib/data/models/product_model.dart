class ProductModel {
  final String id;
  final String name;
  final String category;
  final String barcode;
  final double price;
  final int stockQuantity;
  final bool trackStock;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.barcode,
    required this.price,
    this.stockQuantity = 0,
    this.trackStock = true,
  });

  bool get isAvailable => !trackStock || stockQuantity > 0;

  ProductModel copyWith({
    String? id,
    String? name,
    String? category,
    String? barcode,
    double? price,
    int? stockQuantity,
    bool? trackStock,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      trackStock: trackStock ?? this.trackStock,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      barcode: json['barcode'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      stockQuantity: json['stock_quantity'] ?? 0,
      trackStock: json['track_stock'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'barcode': barcode,
      'price': price,
      'stock_quantity': stockQuantity,
      'track_stock': trackStock,
    };
  }
}