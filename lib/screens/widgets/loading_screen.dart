import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sliit_eats/helpers/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDualRing(
        color: AppColors.primary,
        size: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.15 : MediaQuery.of(context).size.width * 0.06,
      ),
    );
  }
}
