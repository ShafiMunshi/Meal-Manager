import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/bajar_controller.dart';
import 'package:meal_manager/model/bajar_model.dart';
import 'package:meal_manager/utils/ui_parameter.dart';

class AddBazarScreen extends GetView<BazarController> {
  AddBazarScreen({super.key});
  static const String routeName = '/add-bazar-screen';
  // final String date;

  final data = Get.arguments;

  String? date;

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      controller.editBajarList(data);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bazar Item'),
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
                          onPressed: () {}, child: Text('Select the date'))
                      //  DatePickerDialog(initialDate: DateTime.now(), firstDate: firstDate, lastDate: lastDate)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.shop),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: Get.width - 100,
                        child: TextField(
                          controller: controller.nameController,
                          autofocus: true,
                          decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText: 'Enter Bajar items name'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.monetization_on),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: Get.width - 100,
                        child: TextField(
                          controller: controller.costController,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                              // border: InputBorder.none,
                              hintText: 'Cost'),
                        ),
                      )
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
                  if (data != null) {
                    controller.updateOnEdit(data);
                    Get.back();
                  } else {
                    controller.addData(controller.nameController.text,
                        int.parse(controller.costController.text), '023342');
                  }
                  // print('added 1 ${controller.bajarList.value.length}');

                  controller.uploadDataToServer();
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
