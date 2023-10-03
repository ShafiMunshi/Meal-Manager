import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/bajar_controller.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/controller/meal_controller.dart';
import 'package:meal_manager/model/bajar_model.dart';
import 'package:meal_manager/screens/widgets/dialog/custom_snackbar.dart';
import 'package:meal_manager/utils/ui_parameter.dart';

import '../widgets/date_picker_widget.dart';
import '../widgets/new_date_picker.dart';

// ignore: must_be_immutable
class AddMealScreen extends StatefulWidget {
  AddMealScreen({super.key});
  static const String routeName = '/add-meal-screen';

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  String selectedValue = 'shafi';
  var controller = Get.find<MealController>();
  late String dropdownValue;

  late List<String> memberList;

  @override
  void initState() {
    super.initState();
    var dController = Get.find<DataController>();
    memberList = dController.memberList;
    dropdownValue = dController.memberList.first;
  }

  // final String date;
  final data = Get.arguments;

  TextEditingController sokalController = TextEditingController();

  TextEditingController lunchController = TextEditingController();

  TextEditingController dinnerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Member Meal Item'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12, right: 10, left: 10),
        child: Column(
          children: [
            Container(
              padding: cardPadding(),
              decoration: BoxDecoration(
                // color: Colors.red,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: UiParameters.cardBorderRadius(),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      TextButton(
                          onPressed: () {
                            myDateTimePicker(context);
                          },
                          child: Obx(() => Text(controller.monthName.value)))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      milTextFiesd(controller: sokalController, text: 'sokal'),
                      milTextFiesd(controller: lunchController, text: 'lunch'),
                      milTextFiesd(
                          controller: dinnerController, text: 'dinner'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(Icons.monetization_on),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: Get.width - 100,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            items: memberList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 17),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  dropdownValue = newValue;
                                }
                              });
                            },
                          ))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if(sokalController.text.length ==0) sokalController.text='0';
                  if(lunchController.text.length ==0) lunchController.text='0';
                  if(dinnerController.text.length ==0) dinnerController.text='0';

                  controller.uploadMealDatatoServer(
                      sokalController.text,
                      lunchController.text,
                      dinnerController.text,
                      controller.monthName.value,
                      dropdownValue);

                  // showSnacker();
                  ScaffoldMessenger.of(Get.context!).showSnackBar(
                      customSnackBar('$dropdownValue meal has been added'));
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }

  Widget milTextFiesd(
      {required TextEditingController controller, required String text}) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
            // border: InputBorder.none,
            enabledBorder: UiParameters.textInputBorder(),
            focusedBorder: UiParameters.textInputBorder(),
            hintText: text),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
