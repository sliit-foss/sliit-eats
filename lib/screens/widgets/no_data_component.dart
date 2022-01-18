import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataComponent extends StatelessWidget {
  const NoDataComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.7 : MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.3,
        child: Lottie.asset(
          "assets/animations/no_data.json",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
