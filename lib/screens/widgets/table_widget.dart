 import 'package:flutter/material.dart';

Widget tableCell(String text,
          {bool isBold = false, Color color = Colors.white}) =>
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: ColoredBox(
            // decoration: BoxDecoration(),/
            color: color,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      );
  Widget titleTableCell(
    String text,
  ) =>
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      );