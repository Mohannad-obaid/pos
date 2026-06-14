// import 'package:flutter/material.dart';
// import 'package:pos/presentation/screens/main_layout.dart';
// import '../../presentation/screens/cart/cart_screen.dart';
// import 'app_routes.dart';
// import 'route_arguments.dart';
// import 'error_screens.dart';
//
// // قم باستيراد شاشاتك هنا (استبدل المسارات حسب مجلداتك)
// // import '../../presentation/screens/home/home_screen.dart';
// // import '../../presentation/screens/cart/cart_screen.dart';
// // import '../../presentation/screens/checkout/checkout_screen.dart';
// // ... إلخ
//
// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     // جلب الـ Arguments إن وجدت
//     final args = settings.arguments;
//
//     switch (settings.name) {
//     // case AppRoutes.splash:
//     //   return MaterialPageRoute(builder: (_) => const SplashScreen());
//
//     case AppRoutes.home:
//       return MaterialPageRoute(builder: (_) => const MainLayout());
//
//     case AppRoutes.cart:
//       return MaterialPageRoute(builder: (_) => const CartScreen());
//
//     // case AppRoutes.checkout:
//     //   return MaterialPageRoute(builder: (_) => const CheckoutScreen());
//
//     /*
//        * مثال على شاشة تستقبل Arguments:
//        *
//        * case '/product_details':
//        *   if (args is ProductDetailsArgs) {
//        *     return MaterialPageRoute(
//        *       builder: (_) => ProductDetailsScreen(args: args),
//        *     );
//        *   }
//        *   return MaterialPageRoute(builder: (_) => const RouteErrorScreen());
//        */
//
//       default:
//       // إذا كان المسار غير معروف
//         return MaterialPageRoute(builder: (_) => const RouteErrorScreen());
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos/presentation/screens/invoices/invoices_list_screen.dart';
import 'package:pos/presentation/screens/main_layout.dart';
import '../../presentation/screens/cart/cart_screen.dart';
import '../../presentation/screens/checkout/checkout_screen.dart';
import '../../presentation/screens/customers/add_customer_screen.dart';
import '../../presentation/screens/customers/customer_details_screen.dart';
import '../../presentation/screens/customers/customers_list_screen.dart';
import '../../presentation/screens/debt/payment_entry_screen.dart';
import '../../presentation/screens/debt/quick_debt_entry_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/invoices/custom_invoice_screen.dart';
import '../../presentation/screens/invoices/invoice_details_screen.dart';
import '../../presentation/screens/payments/payments_history_screen.dart';
import '../../presentation/screens/products/add_product_screen.dart';
import '../../presentation/screens/products/product_details_screen.dart';
import '../../presentation/screens/products/products_list_screen.dart';
import '../../presentation/screens/products/scan_barcode_screen.dart';
import '../../presentation/screens/reports/reports_screen.dart';
import '../../presentation/screens/settings/backup_restore_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import 'app_routes.dart';
import 'route_arguments.dart';
import 'error_screens.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? routeName = settings.name;
    final Object? arguments = settings.arguments;

    try {
      switch (routeName) {
      // ============= POS Routes =============
        case AppRoutes.splash:
         return MaterialPageRoute(builder: (_) => const SplashScreen());

        case AppRoutes.home:
          return _buildRoute(const HomeScreen(), settings);

        case AppRoutes.cart:
          return _buildRoute(const CartScreen(), settings);

        case AppRoutes.checkout:
          return _buildRoute(const CheckoutScreen(), settings);

        case AppRoutes.products:
          return _buildRoute(const ProductsListScreen(), settings);

        case AppRoutes.addProduct:
          return _buildRoute(const AddProductScreen(), settings);
          
        case AppRoutes.productDetails:
          if (arguments is ProductDetailsArgs) {
            return _buildRoute(ProductDetailsScreen(productId: arguments.productId,), settings);
          }
          return _buildRoute(const RouteErrorScreen(message: 'تحتاج ProductDetailsArgs'), settings);


        case AppRoutes.scanBarcode:
          return _buildRoute(const ScanBarcodeScreen(), settings);

        case AppRoutes.reportsScreen:
          return _buildRoute(const ReportsScreen(), settings);

      // ============= Customers & Invoices =============
        case AppRoutes.customers:
          return _buildRoute(const CustomersListScreen(), settings);

        case AppRoutes.addCustomer:
          return _buildRoute(const AddCustomerScreen(), settings);

        case AppRoutes.customerDetails:
          if (arguments is CustomerDebtsArgs) {
            return _buildRoute(CustomerDetailsScreen(customerId: arguments.customerId), settings); //customerId: arguments.customerId
         }
         return _buildRoute(const RouteErrorScreen(message: 'تحتاج CustomerDebtsArgs'), settings);

        case AppRoutes.invoices:
          return _buildRoute(const InvoicesListScreen(), settings);

        case AppRoutes.invoicesDetails:
          if (arguments is InvoiceDetailsArgs) {
            return _buildRoute(InvoiceDetailsScreen(invoiceId: arguments.invoiceId), settings); //args: arguments
          }
          return _buildRoute(const RouteErrorScreen(message: 'تحتاج InvoiceDetailsArgs'), settings);

        case AppRoutes.paymentsHistory:
          return _buildRoute(const PaymentsHistoryScreen(), settings);

        case AppRoutes.quickDebt: 
          return _buildRoute(const QuickDebtEntryScreen(), settings);

        // case AppRoutes.paymentEntry: //PaymentEntry
        //   return _buildRoute(const PaymentEntryScreen(customerId: null,), settings);

        case AppRoutes.paymentEntry:
          if (arguments is PaymentEntryArgs) {
            return _buildRoute(PaymentEntryScreen(customerId: arguments.customerId), settings); //customerId: arguments.customerId
          }
          return _buildRoute(PaymentEntryScreen(), settings); //customerId: arguments.customerId

        case AppRoutes.customInvoice:
          return _buildRoute(const CustomInvoiceScreen(), settings);


      // ============= Settings & Utils =============
        case AppRoutes.dashboard:
          return _buildRoute(const MainLayout(), settings);

        case AppRoutes.settings:
          return _buildRoute(const SettingsScreen(), settings);

        case AppRoutes.backup:
          return _buildRoute(const BackupRestoreScreen(), settings);

      // ============= Error Routes =============
        case AppRoutes.notFound:
          return _buildRoute(const RouteErrorScreen(message: 'الشاشة غير موجودة'), settings);

        case AppRoutes.error:
          return _buildRoute(RouteErrorScreen(message: arguments?.toString() ?? 'خطأ'), settings);

        default:
          return _buildRoute(const RouteErrorScreen(message: 'الشاشة غير موجودة'), settings);
      }
    } catch (e) {
      return _buildRoute(RouteErrorScreen(message: e.toString()), settings);
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
