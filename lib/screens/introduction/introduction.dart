import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/screens/widgets/bigtext_widget.dart';
import 'package:meal_manager/utils/ui_parameter.dart';

class Introduction extends GetView<DataController> {
  Introduction({super.key});

  TextEditingController _houseName = TextEditingController();
  TextEditingController _houseId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bachelor Meal Manager')),
        body: Column(
          children: [
            Card(
              child: ListTile(
                leading: CircleAvatar(
                    // backgroundImage: ,
                    ),
                title: Text('Welcome '),
                subtitle: Text('shafi'),
              ),
            ),
            SizedBox(
              height: 13,
            ),
            BigText(text: 'Please join or create e house first'),
            SizedBox(
              height: 12,
            ),
            Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.12),
                  borderRadius: UiParameters.cardBorderRadius()),
              child: Column(
                children: [
                  BigText(text: 'Create House'),
                  TextField(
                    controller: _houseName,
                    decoration: InputDecoration(
                        hintText: 'House Name',
                        fillColor: Colors.white,
                        focusedBorder: UiParameters.textInputBorder(),
                        enabledBorder: UiParameters.textInputBorder()),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.createHouse(_houseName.text);
                },
                child: Text('Create')),
            Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.12),
                  borderRadius: UiParameters.cardBorderRadius()),
              child: Column(
                children: [
                  BigText(text: 'Join a House'),
                  TextField(
                    controller: _houseId,
                    decoration: InputDecoration(
                        hintText: 'Enter House ID',
                        fillColor: Colors.white,
                        focusedBorder: UiParameters.textInputBorder(),
                        enabledBorder: UiParameters.textInputBorder()),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.joinHouse(_houseId.text);
                },
                child: Text('Join')),
          ],
        ));
  }
}
