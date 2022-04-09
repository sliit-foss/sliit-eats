import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/management/category_management/category_management.dart';
import 'package:sliit_eats/screens/management/order_management/active_orders.dart';
import 'package:sliit_eats/screens/management/user_management/user_management.dart';
import 'package:sliit_eats/screens/product/components/product_add_update.dart';
import 'package:sliit_eats/screens/product/product_detail_screen.dart';
import 'package:sliit_eats/screens/product_management/product_management.dart';
import 'package:sliit_eats/screens/user/auth/auth_screen.dart';
import 'package:sliit_eats/screens/welcome_screen/welcome_screen.dart';
import '../screens/home_screen/home_screen.dart';

class RouteGenerator {
  static dynamic getRoutes() {
    return {
      AppRoutes.HOME: (context) => HomeScreen(),
      AppRoutes.WELCOME: (context) => WelcomeScreen(),
      AppRoutes.AUTH: (context) => AuthScreen(),
      AppRoutes.USER_MANAGEMENT: (context) => UserManagement(),
      AppRoutes.CATEGORY_MANAGEMENT: (context) => CategoryManagement(),
      AppRoutes.ORDER_MANAGEMENT: (context) => OrderManagement(),
      AppRoutes.PRODUCT_MANAGEMENT: (context) => ProductManagement(),
      AppRoutes.PRODUCT_ADD_UPDATE: (context) => ProductAddUpdate(),
      AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen(),
    };
  }
}
