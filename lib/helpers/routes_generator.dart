import 'package:sliit_eats/screens/login_screen/login_screen.dart';
import 'package:sliit_eats/screens/signup_screen/signup_screen.dart';
import 'package:sliit_eats/screens/welcome_screen/welcome_screen.dart';
import '../screens/home_screen/home_screen.dart';

class RouteGenerator {
  static dynamic getRoutes () {
    return {
      '/home' : (context) =>  HomeScreen(),
      '/welcome' : (context) =>  WelcomeScreen(),
      '/login' : (context) =>  Login(),
      '/signup' : (context) =>  SignUp(),
    };
  }
}
