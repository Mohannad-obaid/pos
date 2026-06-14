// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalDebtMeta =
      const VerificationMeta('totalDebt');
  @override
  late final GeneratedColumn<double> totalDebt = GeneratedColumn<double>(
      'total_debt', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns => [id, name, phone, totalDebt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('total_debt')) {
      context.handle(_totalDebtMeta,
          totalDebt.isAcceptableOrUnknown(data['total_debt']!, _totalDebtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      totalDebt: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_debt'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String? phone;
  final double totalDebt;
  const Customer(
      {required this.id,
      required this.name,
      this.phone,
      required this.totalDebt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['total_debt'] = Variable<double>(totalDebt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      totalDebt: Value(totalDebt),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      totalDebt: serializer.fromJson<double>(json['totalDebt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'totalDebt': serializer.toJson<double>(totalDebt),
    };
  }

  Customer copyWith(
          {int? id,
          String? name,
          Value<String?> phone = const Value.absent(),
          double? totalDebt}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        totalDebt: totalDebt ?? this.totalDebt,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      totalDebt: data.totalDebt.present ? data.totalDebt.value : this.totalDebt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('totalDebt: $totalDebt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, totalDebt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.totalDebt == this.totalDebt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<double> totalDebt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.totalDebt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.totalDebt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<double>? totalDebt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (totalDebt != null) 'total_debt': totalDebt,
    });
  }

  CustomersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? phone,
      Value<double>? totalDebt}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      totalDebt: totalDebt ?? this.totalDebt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (totalDebt.present) {
      map['total_debt'] = Variable<double>(totalDebt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('totalDebt: $totalDebt')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stockQuantityMeta =
      const VerificationMeta('stockQuantity');
  @override
  late final GeneratedColumn<int> stockQuantity = GeneratedColumn<int>(
      'stock_quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _trackStockMeta =
      const VerificationMeta('trackStock');
  @override
  late final GeneratedColumn<bool> trackStock = GeneratedColumn<bool>(
      'track_stock', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("track_stock" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, category, barcode, price, stockQuantity, trackStock];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
          _stockQuantityMeta,
          stockQuantity.isAcceptableOrUnknown(
              data['stock_quantity']!, _stockQuantityMeta));
    }
    if (data.containsKey('track_stock')) {
      context.handle(
          _trackStockMeta,
          trackStock.isAcceptableOrUnknown(
              data['track_stock']!, _trackStockMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      stockQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_quantity'])!,
      trackStock: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}track_stock'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String category;
  final String barcode;
  final double price;
  final int stockQuantity;
  final bool trackStock;
  const Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.barcode,
      required this.price,
      required this.stockQuantity,
      required this.trackStock});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['barcode'] = Variable<String>(barcode);
    map['price'] = Variable<double>(price);
    map['stock_quantity'] = Variable<int>(stockQuantity);
    map['track_stock'] = Variable<bool>(trackStock);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      barcode: Value(barcode),
      price: Value(price),
      stockQuantity: Value(stockQuantity),
      trackStock: Value(trackStock),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      barcode: serializer.fromJson<String>(json['barcode']),
      price: serializer.fromJson<double>(json['price']),
      stockQuantity: serializer.fromJson<int>(json['stockQuantity']),
      trackStock: serializer.fromJson<bool>(json['trackStock']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'barcode': serializer.toJson<String>(barcode),
      'price': serializer.toJson<double>(price),
      'stockQuantity': serializer.toJson<int>(stockQuantity),
      'trackStock': serializer.toJson<bool>(trackStock),
    };
  }

  Product copyWith(
          {int? id,
          String? name,
          String? category,
          String? barcode,
          double? price,
          int? stockQuantity,
          bool? trackStock}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        barcode: barcode ?? this.barcode,
        price: price ?? this.price,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        trackStock: trackStock ?? this.trackStock,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      price: data.price.present ? data.price.value : this.price,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      trackStock:
          data.trackStock.present ? data.trackStock.value : this.trackStock,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('barcode: $barcode, ')
          ..write('price: $price, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('trackStock: $trackStock')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, category, barcode, price, stockQuantity, trackStock);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.barcode == this.barcode &&
          other.price == this.price &&
          other.stockQuantity == this.stockQuantity &&
          other.trackStock == this.trackStock);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> barcode;
  final Value<double> price;
  final Value<int> stockQuantity;
  final Value<bool> trackStock;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.barcode = const Value.absent(),
    this.price = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.trackStock = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required String barcode,
    required double price,
    this.stockQuantity = const Value.absent(),
    this.trackStock = const Value.absent(),
  })  : name = Value(name),
        category = Value(category),
        barcode = Value(barcode),
        price = Value(price);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? barcode,
    Expression<double>? price,
    Expression<int>? stockQuantity,
    Expression<bool>? trackStock,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (barcode != null) 'barcode': barcode,
      if (price != null) 'price': price,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (trackStock != null) 'track_stock': trackStock,
    });
  }

  ProductsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? barcode,
      Value<double>? price,
      Value<int>? stockQuantity,
      Value<bool>? trackStock}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      trackStock: trackStock ?? this.trackStock,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<int>(stockQuantity.value);
    }
    if (trackStock.present) {
      map['track_stock'] = Variable<bool>(trackStock.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('barcode: $barcode, ')
          ..write('price: $price, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('trackStock: $trackStock')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, customerId, date, totalAmount, status, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(Insertable<Invoice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final int? customerId;
  final DateTime date;
  final double totalAmount;
  final String status;
  final String? note;
  const Invoice(
      {required this.id,
      this.customerId,
      required this.date,
      required this.totalAmount,
      required this.status,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['date'] = Variable<DateTime>(date);
    map['total_amount'] = Variable<double>(totalAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      date: Value(date),
      totalAmount: Value(totalAmount),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Invoice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      date: serializer.fromJson<DateTime>(json['date']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int?>(customerId),
      'date': serializer.toJson<DateTime>(date),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
    };
  }

  Invoice copyWith(
          {int? id,
          Value<int?> customerId = const Value.absent(),
          DateTime? date,
          double? totalAmount,
          String? status,
          Value<String?> note = const Value.absent()}) =>
      Invoice(
        id: id ?? this.id,
        customerId: customerId.present ? customerId.value : this.customerId,
        date: date ?? this.date,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
        note: note.present ? note.value : this.note,
      );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      date: data.date.present ? data.date.value : this.date,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('date: $date, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, customerId, date, totalAmount, status, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.date == this.date &&
          other.totalAmount == this.totalAmount &&
          other.status == this.status &&
          other.note == this.note);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<int?> customerId;
  final Value<DateTime> date;
  final Value<double> totalAmount;
  final Value<String> status;
  final Value<String?> note;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.date = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    required DateTime date,
    required double totalAmount,
    required String status,
    this.note = const Value.absent(),
  })  : date = Value(date),
        totalAmount = Value(totalAmount),
        status = Value(status);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<DateTime>? date,
    Expression<double>? totalAmount,
    Expression<String>? status,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (date != null) 'date': date,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
    });
  }

  InvoicesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? customerId,
      Value<DateTime>? date,
      Value<double>? totalAmount,
      Value<String>? status,
      Value<String?>? note}) {
    return InvoicesCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      date: date ?? this.date,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('date: $date, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTable extends InvoiceItems
    with TableInfo<$InvoiceItemsTable, InvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _invoiceIdMeta =
      const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
      'invoice_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES invoices (id)'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _priceAtSaleMeta =
      const VerificationMeta('priceAtSale');
  @override
  late final GeneratedColumn<double> priceAtSale = GeneratedColumn<double>(
      'price_at_sale', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, invoiceId, productId, quantity, priceAtSale];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(Insertable<InvoiceItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('price_at_sale')) {
      context.handle(
          _priceAtSaleMeta,
          priceAtSale.isAcceptableOrUnknown(
              data['price_at_sale']!, _priceAtSaleMeta));
    } else if (isInserting) {
      context.missing(_priceAtSaleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      priceAtSale: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price_at_sale'])!,
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItem extends DataClass implements Insertable<InvoiceItem> {
  final int id;
  final int invoiceId;
  final int productId;
  final int quantity;
  final double priceAtSale;
  const InvoiceItem(
      {required this.id,
      required this.invoiceId,
      required this.productId,
      required this.quantity,
      required this.priceAtSale});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['price_at_sale'] = Variable<double>(priceAtSale);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      quantity: Value(quantity),
      priceAtSale: Value(priceAtSale),
    );
  }

  factory InvoiceItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItem(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      priceAtSale: serializer.fromJson<double>(json['priceAtSale']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'priceAtSale': serializer.toJson<double>(priceAtSale),
    };
  }

  InvoiceItem copyWith(
          {int? id,
          int? invoiceId,
          int? productId,
          int? quantity,
          double? priceAtSale}) =>
      InvoiceItem(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        priceAtSale: priceAtSale ?? this.priceAtSale,
      );
  InvoiceItem copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      priceAtSale:
          data.priceAtSale.present ? data.priceAtSale.value : this.priceAtSale,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItem(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('priceAtSale: $priceAtSale')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, invoiceId, productId, quantity, priceAtSale);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItem &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.priceAtSale == this.priceAtSale);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItem> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> productId;
  final Value<int> quantity;
  final Value<double> priceAtSale;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.priceAtSale = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int productId,
    required int quantity,
    required double priceAtSale,
  })  : invoiceId = Value(invoiceId),
        productId = Value(productId),
        quantity = Value(quantity),
        priceAtSale = Value(priceAtSale);
  static Insertable<InvoiceItem> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? productId,
    Expression<int>? quantity,
    Expression<double>? priceAtSale,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (priceAtSale != null) 'price_at_sale': priceAtSale,
    });
  }

  InvoiceItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? invoiceId,
      Value<int>? productId,
      Value<int>? quantity,
      Value<double>? priceAtSale}) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      priceAtSale: priceAtSale ?? this.priceAtSale,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (priceAtSale.present) {
      map['price_at_sale'] = Variable<double>(priceAtSale.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('priceAtSale: $priceAtSale')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, customerId, amount, date, method, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<Payment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int customerId;
  final double amount;
  final DateTime date;
  final String method;
  final String? note;
  const Payment(
      {required this.id,
      required this.customerId,
      required this.amount,
      required this.date,
      required this.method,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      amount: Value(amount),
      date: Value(date),
      method: Value(method),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      method: serializer.fromJson<String>(json['method']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'method': serializer.toJson<String>(method),
      'note': serializer.toJson<String?>(note),
    };
  }

  Payment copyWith(
          {int? id,
          int? customerId,
          double? amount,
          DateTime? date,
          String? method,
          Value<String?> note = const Value.absent()}) =>
      Payment(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        method: method ?? this.method,
        note: note.present ? note.value : this.note,
      );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      method: data.method.present ? data.method.value : this.method,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('method: $method, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, amount, date, method, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.method == this.method &&
          other.note == this.note);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> method;
  final Value<String?> note;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.method = const Value.absent(),
    this.note = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required double amount,
    required DateTime date,
    required String method,
    this.note = const Value.absent(),
  })  : customerId = Value(customerId),
        amount = Value(amount),
        date = Value(date),
        method = Value(method);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? method,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (method != null) 'method': method,
      if (note != null) 'note': note,
    });
  }

  PaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? customerId,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<String>? method,
      Value<String?>? note}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      method: method ?? this.method,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('method: $method, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceItemsTable invoiceItems = $InvoiceItemsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [customers, products, invoices, invoiceItems, payments];
}

typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> phone,
  Value<double> totalDebt,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> phone,
  Value<double> totalDebt,
});

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.invoices,
          aliasName:
              $_aliasNameGenerator(db.customers.id, db.invoices.customerId));

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager($_db, $_db.invoices)
        .filter((f) => f.customerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.payments,
          aliasName:
              $_aliasNameGenerator(db.customers.id, db.payments.customerId));

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.customerId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalDebt => $composableBuilder(
      column: $table.totalDebt, builder: (column) => ColumnFilters(column));

  Expression<bool> invoicesRefs(
      Expression<bool> Function($$InvoicesTableFilterComposer f) f) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableFilterComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> paymentsRefs(
      Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalDebt => $composableBuilder(
      column: $table.totalDebt, builder: (column) => ColumnOrderings(column));
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<double> get totalDebt =>
      $composableBuilder(column: $table.totalDebt, builder: (column) => column);

  Expression<T> invoicesRefs<T extends Object>(
      Expression<T> Function($$InvoicesTableAnnotationComposer a) f) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableAnnotationComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
      Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, $$CustomersTableReferences),
    Customer,
    PrefetchHooks Function({bool invoicesRefs, bool paymentsRefs})> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<double> totalDebt = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            name: name,
            phone: phone,
            totalDebt: totalDebt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> phone = const Value.absent(),
            Value<double> totalDebt = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            totalDebt: totalDebt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CustomersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {invoicesRefs = false, paymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (invoicesRefs) db.invoices,
                if (paymentsRefs) db.payments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoicesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CustomersTableReferences._invoicesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomersTableReferences(db, table, p0)
                                .invoicesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items),
                  if (paymentsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CustomersTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomersTableReferences(db, table, p0)
                                .paymentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CustomersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, $$CustomersTableReferences),
    Customer,
    PrefetchHooks Function({bool invoicesRefs, bool paymentsRefs})>;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  required String name,
  required String category,
  required String barcode,
  required double price,
  Value<int> stockQuantity,
  Value<bool> trackStock,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> category,
  Value<String> barcode,
  Value<double> price,
  Value<int> stockQuantity,
  Value<bool> trackStock,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItem>>
      _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.invoiceItems,
          aliasName:
              $_aliasNameGenerator(db.products.id, db.invoiceItems.productId));

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager($_db, $_db.invoiceItems)
        .filter((f) => f.productId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get trackStock => $composableBuilder(
      column: $table.trackStock, builder: (column) => ColumnFilters(column));

  Expression<bool> invoiceItemsRefs(
      Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoiceItems,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceItemsTableFilterComposer(
              $db: $db,
              $table: $db.invoiceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get trackStock => $composableBuilder(
      column: $table.trackStock, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get stockQuantity => $composableBuilder(
      column: $table.stockQuantity, builder: (column) => column);

  GeneratedColumn<bool> get trackStock => $composableBuilder(
      column: $table.trackStock, builder: (column) => column);

  Expression<T> invoiceItemsRefs<T extends Object>(
      Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoiceItems,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.invoiceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, $$ProductsTableReferences),
    Product,
    PrefetchHooks Function({bool invoiceItemsRefs})> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> barcode = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<int> stockQuantity = const Value.absent(),
            Value<bool> trackStock = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            name: name,
            category: category,
            barcode: barcode,
            price: price,
            stockQuantity: stockQuantity,
            trackStock: trackStock,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String category,
            required String barcode,
            required double price,
            Value<int> stockQuantity = const Value.absent(),
            Value<bool> trackStock = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            name: name,
            category: category,
            barcode: barcode,
            price: price,
            stockQuantity: stockQuantity,
            trackStock: trackStock,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProductsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({invoiceItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (invoiceItemsRefs) db.invoiceItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoiceItemsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ProductsTableReferences
                            ._invoiceItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductsTableReferences(db, table, p0)
                                .invoiceItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, $$ProductsTableReferences),
    Product,
    PrefetchHooks Function({bool invoiceItemsRefs})>;
typedef $$InvoicesTableCreateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  Value<int?> customerId,
  required DateTime date,
  required double totalAmount,
  required String status,
  Value<String?> note,
});
typedef $$InvoicesTableUpdateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  Value<int?> customerId,
  Value<DateTime> date,
  Value<double> totalAmount,
  Value<String> status,
  Value<String?> note,
});

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
          $_aliasNameGenerator(db.invoices.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager? get customerId {
    if ($_item.customerId == null) return null;
    final manager = $$CustomersTableTableManager($_db, $_db.customers)
        .filter((f) => f.id($_item.customerId!));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItem>>
      _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.invoiceItems,
          aliasName:
              $_aliasNameGenerator(db.invoices.id, db.invoiceItems.invoiceId));

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager($_db, $_db.invoiceItems)
        .filter((f) => f.invoiceId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableFilterComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> invoiceItemsRefs(
      Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoiceItems,
        getReferencedColumn: (t) => t.invoiceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceItemsTableFilterComposer(
              $db: $db,
              $table: $db.invoiceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableOrderingComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
      Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoiceItems,
        getReferencedColumn: (t) => t.invoiceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.invoiceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$InvoicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvoicesTable,
    Invoice,
    $$InvoicesTableFilterComposer,
    $$InvoicesTableOrderingComposer,
    $$InvoicesTableAnnotationComposer,
    $$InvoicesTableCreateCompanionBuilder,
    $$InvoicesTableUpdateCompanionBuilder,
    (Invoice, $$InvoicesTableReferences),
    Invoice,
    PrefetchHooks Function({bool customerId, bool invoiceItemsRefs})> {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> customerId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              InvoicesCompanion(
            id: id,
            customerId: customerId,
            date: date,
            totalAmount: totalAmount,
            status: status,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> customerId = const Value.absent(),
            required DateTime date,
            required double totalAmount,
            required String status,
            Value<String?> note = const Value.absent(),
          }) =>
              InvoicesCompanion.insert(
            id: id,
            customerId: customerId,
            date: date,
            totalAmount: totalAmount,
            status: status,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$InvoicesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {customerId = false, invoiceItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (invoiceItemsRefs) db.invoiceItems],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$InvoicesTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$InvoicesTableReferences._customerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoiceItemsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$InvoicesTableReferences
                            ._invoiceItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$InvoicesTableReferences(db, table, p0)
                                .invoiceItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.invoiceId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$InvoicesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InvoicesTable,
    Invoice,
    $$InvoicesTableFilterComposer,
    $$InvoicesTableOrderingComposer,
    $$InvoicesTableAnnotationComposer,
    $$InvoicesTableCreateCompanionBuilder,
    $$InvoicesTableUpdateCompanionBuilder,
    (Invoice, $$InvoicesTableReferences),
    Invoice,
    PrefetchHooks Function({bool customerId, bool invoiceItemsRefs})>;
typedef $$InvoiceItemsTableCreateCompanionBuilder = InvoiceItemsCompanion
    Function({
  Value<int> id,
  required int invoiceId,
  required int productId,
  required int quantity,
  required double priceAtSale,
});
typedef $$InvoiceItemsTableUpdateCompanionBuilder = InvoiceItemsCompanion
    Function({
  Value<int> id,
  Value<int> invoiceId,
  Value<int> productId,
  Value<int> quantity,
  Value<double> priceAtSale,
});

final class $$InvoiceItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItem> {
  $$InvoiceItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias(
          $_aliasNameGenerator(db.invoiceItems.invoiceId, db.invoices.id));

  $$InvoicesTableProcessedTableManager? get invoiceId {
    if ($_item.invoiceId == null) return null;
    final manager = $$InvoicesTableTableManager($_db, $_db.invoices)
        .filter((f) => f.id($_item.invoiceId!));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
          $_aliasNameGenerator(db.invoiceItems.productId, db.products.id));

  $$ProductsTableProcessedTableManager? get productId {
    if ($_item.productId == null) return null;
    final manager = $$ProductsTableTableManager($_db, $_db.products)
        .filter((f) => f.id($_item.productId!));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get priceAtSale => $composableBuilder(
      column: $table.priceAtSale, builder: (column) => ColumnFilters(column));

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableFilterComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableFilterComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get priceAtSale => $composableBuilder(
      column: $table.priceAtSale, builder: (column) => ColumnOrderings(column));

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableOrderingComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableOrderingComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get priceAtSale => $composableBuilder(
      column: $table.priceAtSale, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableAnnotationComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.products,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoiceItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvoiceItemsTable,
    InvoiceItem,
    $$InvoiceItemsTableFilterComposer,
    $$InvoiceItemsTableOrderingComposer,
    $$InvoiceItemsTableAnnotationComposer,
    $$InvoiceItemsTableCreateCompanionBuilder,
    $$InvoiceItemsTableUpdateCompanionBuilder,
    (InvoiceItem, $$InvoiceItemsTableReferences),
    InvoiceItem,
    PrefetchHooks Function({bool invoiceId, bool productId})> {
  $$InvoiceItemsTableTableManager(_$AppDatabase db, $InvoiceItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> invoiceId = const Value.absent(),
            Value<int> productId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<double> priceAtSale = const Value.absent(),
          }) =>
              InvoiceItemsCompanion(
            id: id,
            invoiceId: invoiceId,
            productId: productId,
            quantity: quantity,
            priceAtSale: priceAtSale,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int invoiceId,
            required int productId,
            required int quantity,
            required double priceAtSale,
          }) =>
              InvoiceItemsCompanion.insert(
            id: id,
            invoiceId: invoiceId,
            productId: productId,
            quantity: quantity,
            priceAtSale: priceAtSale,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$InvoiceItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({invoiceId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (invoiceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.invoiceId,
                    referencedTable:
                        $$InvoiceItemsTableReferences._invoiceIdTable(db),
                    referencedColumn:
                        $$InvoiceItemsTableReferences._invoiceIdTable(db).id,
                  ) as T;
                }
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable:
                        $$InvoiceItemsTableReferences._productIdTable(db),
                    referencedColumn:
                        $$InvoiceItemsTableReferences._productIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$InvoiceItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InvoiceItemsTable,
    InvoiceItem,
    $$InvoiceItemsTableFilterComposer,
    $$InvoiceItemsTableOrderingComposer,
    $$InvoiceItemsTableAnnotationComposer,
    $$InvoiceItemsTableCreateCompanionBuilder,
    $$InvoiceItemsTableUpdateCompanionBuilder,
    (InvoiceItem, $$InvoiceItemsTableReferences),
    InvoiceItem,
    PrefetchHooks Function({bool invoiceId, bool productId})>;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int customerId,
  required double amount,
  required DateTime date,
  required String method,
  Value<String?> note,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> customerId,
  Value<double> amount,
  Value<DateTime> date,
  Value<String> method,
  Value<String?> note,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
          $_aliasNameGenerator(db.payments.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager? get customerId {
    if ($_item.customerId == null) return null;
    final manager = $$CustomersTableTableManager($_db, $_db.customers)
        .filter((f) => f.id($_item.customerId!));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableFilterComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableOrderingComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool customerId})> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> customerId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            customerId: customerId,
            amount: amount,
            date: date,
            method: method,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int customerId,
            required double amount,
            required DateTime date,
            required String method,
            Value<String?> note = const Value.absent(),
          }) =>
              PaymentsCompanion.insert(
            id: id,
            customerId: customerId,
            amount: amount,
            date: date,
            method: method,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PaymentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({customerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$PaymentsTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$PaymentsTableReferences._customerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool customerId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
}
