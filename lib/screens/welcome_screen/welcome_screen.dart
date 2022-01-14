import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'components/banner_content.dart';
import 'components/button_area.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.09 : MediaQuery.of(context).size.height * 0.10, 0, 30),
                  child: Text(
                    "Welcome to SLIIT EATS",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BannerContent(),
                          ButtonArea(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BannerContent(),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                          ButtonArea(),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
