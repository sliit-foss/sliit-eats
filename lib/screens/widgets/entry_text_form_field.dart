import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntryTextFormField extends StatelessWidget {
  const EntryTextFormField({Key? key, required this.controller, required this.prefixIcon, required this.labelText, this.textInputType = TextInputType.name, this.inputFormatters}) : super(key: key);
  final TextEditingController controller;
  final Icon prefixIcon;
  final String labelText;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'This is a required field';
        }
        return null;
      },
      style: TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 2),
      keyboardType: textInputType,
      inputFormatters: inputFormatters != null ? inputFormatters : <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
      controller: controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 2),
        icon: prefixIcon,
        labelText: labelText,
      ),
    );
  }
}
