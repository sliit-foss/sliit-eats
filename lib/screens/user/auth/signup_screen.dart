import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/models/general/success_message.dart';
import 'package:sliit_eats/screens/widgets/alert_dialog.dart';
import 'package:sliit_eats/screens/widgets/dropdown.dart';
import 'package:sliit_eats/screens/widgets/entry_field.dart';
import 'package:sliit_eats/services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.progress, required this.setTabIndex}) : super(key: key);
  final dynamic progress;
  final Function setTabIndex;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  dynamic userType;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
              MediaQuery.of(context).size.width * 0.06),
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
              MediaQuery.of(context).size.width * 0.06),
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
              MediaQuery.of(context).size.width * 0.06),
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
                      widget.progress!.show();
                      dynamic res = await AuthService.signUp(
                          email,
                          password,
                          name,
                          false,
                          userType);
                      widget.progress.dismiss();
                      if (res.runtimeType == SuccessMessage) {
                        widget.setTabIndex(0);
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
                      spreadRadius: 2)
                ],
              ),
              child: Text(
                'Register Now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
