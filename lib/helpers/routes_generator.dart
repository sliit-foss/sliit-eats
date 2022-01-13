import 'package:flutter/material.dart';
import 'package:sliit_eats/constants.dart';
import 'package:sliit_eats/screens/user/login_screen.dart';
import 'package:sliit_eats/screens/user/signup_screen.dart';
import '../screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.HOME:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      case AppRoutes.LOGIN:
        return MaterialPageRoute(builder: (_) => Login(), settings: settings);
      case AppRoutes.SIGNUP:
        return MaterialPageRoute(builder: (_) => SignUp(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR!'),
        ),
      );
    });
  }
}
