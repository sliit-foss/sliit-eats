import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/general/success_message.dart';
import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/entry_field.dart';
import 'package:sliit_eats/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.progress}) : super(key: key);
  final dynamic progress;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
          child: Column(
            children: <Widget>[
              EntryField(
                controller: _emailController,
                placeholder: 'Email',
                isPassword: false,
                prefixIcon: FontAwesomeIcons.solidEnvelope,
              ),
              EntryField(
                controller: _passwordController,
                placeholder: 'Password',
                isPassword: true,
                prefixIcon: FontAwesomeIcons.lock,
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () async {
            String email = _emailController.text;
            String password = _passwordController.text;
            if (email != "" && password != "") {
              widget.progress!.show();
              dynamic res = await AuthService.signIn(email, password);
              widget.progress.dismiss();
              if (res.runtimeType == SuccessMessage) {
                Navigator.pushReplacementNamed(context, AppRoutes.HOME, arguments: {'selectedTabIndex': 0});
              } else {
                await showCoolAlert(context, false, res.message);
              }
            } else {
              await showCoolAlert(context, false, "Please enter a valid email and password");
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: AppColors.primary.withAlpha(100), offset: Offset(2, 4), blurRadius: 8, spreadRadius: 2),
                ],
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 200,
          width: 200,
          child: Lottie.asset(
            'assets/animations/login_screen/fingerprint.json',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
