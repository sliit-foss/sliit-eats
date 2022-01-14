import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/sucess_message.dart';
import 'package:sliit_eats/routes/app_routes.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/dropdown.dart';
import 'package:sliit_eats/screens/widgets/entry_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sliit_eats/services/AuthService.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  dynamic userType;

  Widget _title() {
    return Text(
      "Sign Up",
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
    _nameController.dispose();
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
              height: MediaQuery.of(context).size.height,
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
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06),
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
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: Column(
                            children: <Widget>[
                              EntryField(
                                controller: _nameController,
                                placeholder: 'Username',
                                isPassword: false,
                                prefixIcon: FontAwesomeIcons.solidUser,
                              ),
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
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: CustomDropdown(
                              selectedValue: userType,
                              itemList: ['Lecturer', 'Student'],
                              hint: 'Select User Type',
                              onChanged: (String? newValue) {
                                setState(() {
                                  userType = newValue;
                                });
                              }),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: GestureDetector(
                            onTap: () async {
                              String name = _nameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              if (name != "") {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)) {
                                  if (password != "") {
                                    if (userType != null) {
                                      progress!.show();
                                      dynamic res = await AuthService.signUp(
                                          email,
                                          password,
                                          name,
                                          false,
                                          userType);
                                      progress.dismiss();
                                      if (res.runtimeType == SuccessMessage) {
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.LOGIN);
                                        await showCoolAlert(
                                            context, true, res.message,
                                            noAutoClose: true);
                                      } else {
                                        await showCoolAlert(
                                            context, false, res.message);
                                      }
                                    } else {
                                      await showCoolAlert(context, false,
                                          "Please select a user role");
                                    }
                                  } else {
                                    await showCoolAlert(context, false,
                                        "Please enter a password");
                                  }
                                } else {
                                  await showCoolAlert(context, false,
                                      "Please enter a valid email");
                                }
                              } else {
                                await showCoolAlert(
                                    context, false, "Please enter a username");
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppColors.primary.withAlpha(100),
                                      offset: Offset(2, 4),
                                      blurRadius: 8,
                                      spreadRadius: 2)
                                ],
                              ),
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 30),
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Already have an account ?',
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
                                      context, AppRoutes.LOGIN);
                                },
                                child: Text(
                                  'Sign In',
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
            ),
          );
        },
      ),
    );
  }
}
