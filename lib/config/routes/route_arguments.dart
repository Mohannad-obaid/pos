// مثال: إذا أردت تمرير بيانات منتج لشاشة التعديل أو التفاصيل
class ProductDetailsArgs {
  final int productId;
  ProductDetailsArgs({required this.productId});
}

// مثال: تمرير معرف الزبون لشاشة ديون الزبون
class CustomerDebtsArgs {
  final int customerId;
  CustomerDebtsArgs({required this.customerId});
}

//PaymentEntryScreen
class PaymentEntryArgs {
  final int? customerId; // يمكن أن يكون null إذا تم الدخول من الشاشة الرئيسية
  PaymentEntryArgs({this.customerId});
}


class InvoiceDetailsArgs {
  final int invoiceId;

  InvoiceDetailsArgs({required this.invoiceId});
}