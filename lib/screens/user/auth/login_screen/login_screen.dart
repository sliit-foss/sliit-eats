import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/general/sucess_message.dart';
import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/entry_field.dart';
import 'package:sliit_eats/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _title() {
    return Text(
      "Sign In",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) {
          final progress = ProgressHUD.of(context);
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.backgroundGradient['top']!,
                    AppColors.backgroundGradient['bottom']!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.1
                            : MediaQuery.of(context).size.height * 0.2,
                      ),
                      _title(),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05),
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
                            progress!.show();
                            dynamic res =
                                await AuthService.signIn(email, password);
                            progress.dismiss();
                            if (res.runtimeType == SuccessMessage) {
                              print('sdf');
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.HOME,
                                  arguments: {'selectedTabIndex': 0});
                            } else {
                              await showCoolAlert(context, false, res.message);
                            }
                          } else {
                            await showCoolAlert(context, false,
                                "Please enter a valid email and password");
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.primary.withAlpha(100),
                                    offset: Offset(2, 4),
                                    blurRadius: 8,
                                    spreadRadius: 2),
                              ],
                            ),
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.SIGNUP);
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
