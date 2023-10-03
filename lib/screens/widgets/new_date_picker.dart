import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/meal_controller.dart';

Future<void> myDateTimePicker(BuildContext context) async {
  final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030));
  // MealController.to.update();
  MealController.to.updateDate(dateTime!);
  

}
