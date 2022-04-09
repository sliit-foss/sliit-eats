import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/colors.dart';
import 'custom_clipper.dart';

class WavyHeader extends StatelessWidget {
  const WavyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
          angle: -pi / 3.5,
          child: ClipPath(
            clipper: ClipPainter(),
            child: Container(
              height: MediaQuery.of(context).size.height *.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary,AppColors.primary.withOpacity(0.2)]
                  )
              ),
            ),
          ),
        )
    );
  }
}