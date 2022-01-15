import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/user/auth/login_screen/login_screen.dart';
import 'package:sliit_eats/screens/user/auth/signup_screen/signup_screen.dart';
import 'package:sliit_eats/screens/welcome_screen/welcome_screen.dart';
import '../screens/home_screen/home_screen.dart';

class RouteGenerator {
  static dynamic getRoutes() {
    return {
      AppRoutes.HOME: (context) => HomeScreen(),
      AppRoutes.WELCOME: (context) => WelcomeScreen(),
      AppRoutes.LOGIN: (context) => Login(),
      AppRoutes.SIGNUP: (context) => SignUp(),
    };
  }
}