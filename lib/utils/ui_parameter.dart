import 'package:flutter/material.dart';

class UiParameters {
  static BorderRadius cardBorderRadius() => BorderRadius.circular(12);
  static OutlineInputBorder textInputBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black));
}

cardPadding() => EdgeInsets.symmetric(vertical: 10, horizontal: 12);
