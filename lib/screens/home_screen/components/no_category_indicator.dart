import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/colors.dart';

class NoCategoryIndicator extends StatelessWidget {
  const NoCategoryIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
      child: Container(        
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.45),
              blurRadius: 12,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "No Categories have been added yet",
            style: TextStyle(
                fontSize: 15,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
