import 'package:enhanced_http/enhanced_http.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/welcome_screen/welcome_screen.dart';
import 'package:sliit_eats/screens/widgets/loading_screen.dart';
import 'package:sliit_eats/services/auth_service.dart';
import 'package:sliit_eats/services/firebase_services/fcm_service.dart';
import 'helpers/app_http_overrides.dart';
import 'helpers/cache_service.dart';
import 'helpers/colors.dart';
import 'helpers/constants.dart';
import 'helpers/firebase_options.dart';
import 'helpers/state_helpers.dart';
import 'models/user.dart';
import 'routes/routes_generator.dart';
import 'dart:convert';
import 'dart:io';

late UserModel currentLoggedInUser;

void main() async {
  Paint.enableDithering = true;
  HttpOverrides.global = new AppHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp(name: 'temporaryregister', options: DefaultFirebaseOptions.currentPlatform);
  EnhancedHttp.initialize(baseURL: dotenv.env['SLIIT_EATS_SERVER_URL']!, defaultErrorMessage: Constants.errorMessages['default']!);
  if (StateHelpers.appSettings['notifications']) await FCMService.initialize();
  String? appSettings = await CacheService.getAppSettings();
  if (appSettings != null) StateHelpers.appSettings = jsonDecode(appSettings);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      currentLoggedInUser = await AuthService.getCurrentUserDetails();
      if (currentLoggedInUser.isActive) return true;
    }
    return false;
  }

  void toHome(context) async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, AppRoutes.HOME, arguments: {'selectedTabIndex': 0});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SLIIT Eats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primary,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routes: RouteGenerator.getRoutes(),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              toHome(context);
              return LoadingIndicator();
            } else {
              return WelcomeScreen();
            }
          } else {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
