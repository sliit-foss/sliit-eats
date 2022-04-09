import 'package:flutter/material.dart';
import 'package:sliit_eats/helpers/colors.dart';

class EntryField extends StatelessWidget {
  const EntryField({Key? key, required this.controller, required this.placeholder, required this.isPassword, this.prefixIcon}) : super(key: key);
  final TextEditingController controller;
  final String placeholder;
  final dynamic prefixIcon;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              enabledBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 0,
                ),
              ),
              fillColor: Colors.white.withOpacity(0.85),
              filled: true,
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: Colors.black,
                    )
                  : null,
            ),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
