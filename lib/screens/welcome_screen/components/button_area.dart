import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/routes/app_routes.dart';

class ButtonArea extends StatefulWidget {
  const ButtonArea({Key? key}) : super(key: key);

  @override
  _ButtonAreaState createState() => _ButtonAreaState();
}

class _ButtonAreaState extends State<ButtonArea> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, AppRoutes.SIGNUP);
          },
          child: Container(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.07
                : MediaQuery.of(context).size.height * 0.14,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppColors.primary.withAlpha(100),
                    offset: Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2),
              ],
            ),
            child: Center(
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
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
                Navigator.pushReplacementNamed(context, AppRoutes.LOGIN);
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
    ]);
  }
}
