import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/screens/widgets/bigtext_widget.dart';
import 'package:meal_manager/service/database.dart';
import 'package:meal_manager/utils/ui_parameter.dart';

class MemberScreen extends GetView<DataController> {
  MemberScreen({super.key});

  static const String routeName = '/member-screen';
  TextEditingController memberContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House Member'),
        actions: [
          IconButton(
              onPressed: () {
                // controller.uploadData();
              },
              icon: Icon(Icons.severe_cold))
        ],
      ),
      body: Padding(
        padding: cardPadding(),
        child: Column(children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: UiParameters.cardBorderRadius(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  )
                ]),
            padding: cardPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: 'House Name: namemee'),
                BigText(
                  text: 'House id : iddd', // TODO: add house here
                  size: 16,
                ),
                BigText(
                  text: 'Manager: shafi',
                  size: 15,
                ),
                BigText(
                  text: 'Total Member: 10',
                  size: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: ColoredBox(
              color: Colors.green,
              child: Center(
                child: Text(
                  'Add Member',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: memberContrller,
            decoration: InputDecoration(
              hintText: 'Enter the member name',
              focusedBorder: UiParameters.textInputBorder(),
              enabledBorder: UiParameters.textInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                controller.addMember(memberContrller.text);
                Database().uploadMember(memberContrller.text);
                memberContrller.clear();
              },
              child: Text('Add')),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.memberList.length,
                itemBuilder: (BuildContext context, int index) {
                  var memberName = controller.memberList[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      trailing: IconButton(
                        onPressed: () {
                          controller.removeMember(index);
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                      title: Text(memberName),
                    ),
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
