import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({Key? key, required this.icon, required this.size, required this.name}) : super(key: key);
  final IconData icon;
  final double size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Tab(
        iconMargin: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: size,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(name, style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
