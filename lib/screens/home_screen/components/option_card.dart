import 'package:flutter/material.dart';
import 'package:sliit_eats/screens/widgets/custom_card.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({Key? key, required this.title, required this.subtitle, required this.icon, this.iconSize = 25}) : super(key: key);
  final String title;
  final String subtitle;
  final dynamic icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Colors.white.withOpacity(0.05),
      child: Column(
        children: [
          SizedBox(height: 20),
          title != ""
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                )
              : Container(),
          SizedBox(height: title != "" ? 10 : 0),
          icon != null
              ? Icon(
                  icon,
                  size: iconSize,
                  color: Colors.white,
                )
              : Container(),
          SizedBox(height: icon != null ? 20 : 0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
