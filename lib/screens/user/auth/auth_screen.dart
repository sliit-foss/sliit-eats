import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/screens/user/auth/signup_screen.dart';
import 'package:sliit_eats/screens/widgets/wavy_header/wavy_header.dart';
import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Tab _buildTab(String title) {
    return Tab(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
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
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -MediaQuery.of(context).size.height * .22,
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
                      Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.12, 0, 0),
                          child: Container(
                            height: 520,
                            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.backgroundGradient['top']!,
                                  Color(0xFF000712),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 60,
                                      child: TabBar(
                                        indicator: BoxDecoration(
                                          color: AppColors.primary,
                                        ),
                                        tabs: [
                                          _buildTab("Sign In"),
                                          _buildTab("Sign Up"),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(children: [
                                        Login(progress: progress),
                                        SignUp(progress: progress),
                                      ]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -MediaQuery.of(context).size.height * .5,
                        right: MediaQuery.of(context).size.width * 0.2,
                        child: Transform.scale(
                          scale: 2.0,
                          alignment: Alignment.centerLeft,
                          child: Transform.rotate(
                            angle: math.pi * 2.7,
                            child: Opacity(
                              opacity: 0.85,
                              child: WavyHeader(),
                            ),
                          ),
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
