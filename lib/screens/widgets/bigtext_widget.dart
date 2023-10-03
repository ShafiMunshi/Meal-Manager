import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  const BigText(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.size = 22,
      this.isBold = false});
  final String text;
  final Color color;
  final double size;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w800),
    );
  }
}
