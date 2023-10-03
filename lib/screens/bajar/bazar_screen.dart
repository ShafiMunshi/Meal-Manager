import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/bajar_controller.dart';
import 'package:meal_manager/screens/bajar/add_bajar_dialog.dart';
import 'package:meal_manager/screens/widgets/bigtext_widget.dart';
import 'package:meal_manager/utils/theme_data.dart';
import 'package:meal_manager/utils/ui_parameter.dart';

class BazarScreen extends GetView<BazarController> {
  const BazarScreen({super.key});

  static const String routeName = '/bazar-screen';

  @override
  Widget build(BuildContext context) {
    print('Bajar List length' + controller.bajarList.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Bazar List'),
        actions: [
          IconButton(
              onPressed: () {
                controller.uploadDataToServer();
              },
              icon: Icon(Icons.home)) // icon should be change to option icon
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(AddBazarScreen.routeName);
          },
          label: Row(
            children: [Icon(Icons.add), Text('Add')],
          )),
      body: Padding(
        padding: EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Column(
          children: [
            SizedBox(
              height: 23,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Month: ',
                  ),
                  BigText(
                    text: 'july,2021',
                    color: Colors.red,
                    size: 15,
                    isBold: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.bajarList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cardMoney(index);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cardMoney(int index) {
    var bajarItem = controller.bajarList[index];
    print(bajarItem.itemName);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // cost item
              BigText(
                text: bajarItem.cost.toString() + ' ৳',
                size: 16,
              ),
              BigText(
                text: bajarItem.itemName,
                size: 16,
                color: Colors.red,
              ),
              Text(bajarItem.date),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: 'Bondhon',
                size: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AddBazarScreen.routeName, arguments: index);
                    
                  },
                  child: Text('edit')),
              Text('sample'),
            ],
          )
        ],
      ),
    );
  }
}
