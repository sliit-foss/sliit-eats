import 'package:flutter/material.dart';
import 'package:sliit_eats/screens/login_screen.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/services/auth/impl/authentication.dart';
import 'helpers/app_http_overrides.dart';
import 'helpers/cache_service.dart';
import 'helpers/colors.dart';
import 'helpers/state_helpers.dart';
import 'helpers/routes_generator.dart';
import 'dart:convert';
import 'dart:io';

void main() async {
  HttpOverrides.global = new AppHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  String? appSettings = await CacheService.getAppSettings();
  if (appSettings != null) {
    StateHelpers.appSettings = ;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> checkLoginStatus() async {
    await CacheService.checkFirstRun();
    bool status = await CacheService.getLoggedInStatus();
    if (status != true) {
      status = false;
    }
    return status;
  }

  loginProcedure(BuildContext context) async {
    String? userData = await CacheService.getUserData();
    String email = jsonDecode(userData!)['email'];
    String? password = await CacheService.getUserPassword();
    Authentication auth = Authentication();
    bool? loginState = await auth.signIn(email, password!);
    if (loginState!) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SLIIT Eats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primary,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              loginProcedure(context);
              return LoadingIndicator();
            } else {
              return Login();
            }
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}

