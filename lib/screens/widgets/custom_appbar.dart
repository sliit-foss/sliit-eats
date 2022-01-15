import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/colors.dart';

customAppBar({required String title, bool showBackArrow = true, required Function onBackPressed}) {
  return AppBar(
    backgroundColor: AppColors.backgroundGradient['top']!,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.fromLTRB(0,5,0,0),
      child: Stack(
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  onBackPressed();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Spacer(),
            ],
          )
        ],
      ),
    ),
  );
}