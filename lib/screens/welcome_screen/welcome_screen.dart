import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/screens/widgets/wavy_header/wavy_header.dart';
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
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -MediaQuery.of(context).size.height * .52,
                      right: MediaQuery.of(context).size.width * 0.5,
                      child: Transform.scale(
                        scale: 2.0,
                        alignment: Alignment.centerLeft,
                        child: Transform.rotate(
                          angle: math.pi * 1.8,
                          child: WavyHeader(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -MediaQuery.of(context).size.height * .6,
                      right: MediaQuery.of(context).size.width * 0.2,
                      child: Transform.scale(
                        scale: 2.0,
                        alignment: Alignment.centerLeft,
                        child: Transform.rotate(
                          angle: math.pi * 2.7,
                          child: Opacity(
                            opacity: 0.5,
                            child: WavyHeader(),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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
                  ],
                ),
              ),
            ),
            Positioned(
              top: 75,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to SLIIT EATS",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
