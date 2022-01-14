import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({Key? key, required this.selectedValue, required this.itemList, required this.hint, required this.onChanged}) : super(key: key);
  final dynamic selectedValue;
  final List<String> itemList;
  final String hint;
  final dynamic onChanged;

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFfdfdff),
                contentPadding: EdgeInsets.all(20),
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
              ),
              isEmpty: widget.selectedValue == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: widget.selectedValue,
                  isDense: true,
                  onChanged: widget.onChanged,
                  items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}