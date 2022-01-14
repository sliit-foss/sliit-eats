import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'package:sliit_eats/services/AuthService.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.title, this.progress, required this.borderRadius, required this.showArrow, this.icon = null, this.iconColor = null}) : super(key: key);
  final String title;
  final dynamic progress;
  final BorderRadius borderRadius;
  final bool showArrow;
  final dynamic icon;
  final dynamic iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (title == "Sign Out") {
          progress.show();
          await AuthService.signOut();
          progress.dismiss();
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              icon != null
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Icon(
                        icon,
                        color: iconColor,
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Spacer(),
              showArrow
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(
                        FontAwesomeIcons.arrowRight,
                        color: AppColors.primary,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
