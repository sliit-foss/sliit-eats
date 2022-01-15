import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({Key? key, required this.text, required this.buttonColor, required this.onPressed, this.horizontalPadding = 25, this.paddingTop = 20, this.borderRadius = 25}) : super(key: key);
  final String text;
  final Color buttonColor;
  final Function onPressed;
  final double horizontalPadding;
  final double paddingTop;
  final double borderRadius;

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.fromLTRB(0, widget.paddingTop, 0, 0),
        padding: EdgeInsets.fromLTRB(widget.horizontalPadding, 13, widget.horizontalPadding, 13),
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
          boxShadow: [
            BoxShadow(
              color: widget.buttonColor.withOpacity(0.25),
              blurRadius: 12,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          widget.text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }
}
