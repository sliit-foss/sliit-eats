import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lottie/lottie.dart';
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
            Navigator.pushReplacementNamed(context, AppRoutes.AUTH);
          },
          child: Container(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.065
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: -90 * math.pi / 180,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Lottie.asset(
                      'assets/animations/welcome_screen/arrow-right.json',
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 25)
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
