import 'package:flutter/material.dart';
import 'package:sliit_eats/routes/app_routes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.SIGNUP),
              child: Text('Don\'t have an account? Sign up'))
        ],
      ),
    );
  }
}
