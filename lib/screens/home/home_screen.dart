import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/bajar_controller.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/screens/home/house_stats.dart';
import 'package:meal_manager/screens/home/room_details.dart';
import 'package:meal_manager/screens/bajar/add_bajar_dialog.dart';
import 'package:meal_manager/screens/bajar/bazar_screen.dart';
import 'package:meal_manager/screens/manager-money/manager_money_screen.dart';
import 'package:meal_manager/screens/meals/meal_screen.dart';
import 'package:meal_manager/screens/member/member_screen.dart';
import 'package:meal_manager/screens/widgets/bigtext_widget.dart';
import 'package:meal_manager/screens/widgets/table_widget.dart';
import 'package:meal_manager/service/database.dart';
import 'package:meal_manager/utils/theme_data.dart';
import 'package:meal_manager/utils/ui_parameter.dart';

class HomeScreen extends GetView<DataController> {
  HomeScreen({super.key});
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    Database().getMemberData();
    // Database().getbajarData();
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Bachelor\'s Meals'),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            label: 'Member',
            child: Icon(Icons.person),
            onTap: () {
              Get.toNamed(MemberScreen.routeName);
            },
          ),
          SpeedDialChild(
            label: 'Manager Money',
            child: Icon(Icons.attach_money_outlined),
            onTap: () {
              Get.toNamed(ManagerMoneyScreen.routeName);
            },
          ),
          SpeedDialChild(
            label: 'Meal Entry',
            child: Icon(Icons.fastfood),
            onTap: () {
              Get.toNamed(MealScreen.routeName);
            },
          ),
          SpeedDialChild(
            label: 'Bajar Entry',
            child: Icon(Icons.card_travel_rounded),
            onTap: () {
              Get.toNamed(BazarScreen.routeName);
            },
          ),
        ],
      ),
      body: Obx(
        () => ((!controller.isLoaded1.value) && (!controller.isLoaded2.value) )
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         RoomDetails(),
                        const SizedBox(
                          height: 10,
                        ),
                        const BigText(
                          text: 'House Stat: ',
                          size: 17,
                        ),
                        HouseStats(),
                        const SizedBox(
                          height: 10,
                        ),
                        const BigText(
                          text: 'Member Stat: ',
                          size: 17,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          textDirection: TextDirection.ltr,
                          // defaultVerticalAlignment: TableCellVerticalAlignment.,
                          border:
                              TableBorder.all(width: 1, color: Colors.black),
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[400]),
                                children: [
                                  titleTableCell('Name'),
                                  titleTableCell('Meal'),
                                  titleTableCell('Cost'),
                                  titleTableCell('Deposit'),
                                  titleTableCell('Balance'),
                                  //tableCell('hello')
                                ]),
                            ...List.generate(
                              controller.memberAllDetails.value.length,
                              (index) => TableRow(
                                  decoration: BoxDecoration(
                                    color: (index + 1) % 2 == 0
                                        ? Colors.white
                                        : Colors.white30,
                                  ),
                                  children: [
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: ColoredBox(
                                          // decoration: BoxDecoration(),/
                                          color: Colors.white,
                                          child: Obx(
                                            () => Text(
                                              controller.memberAllDetails
                                                  .value[index].name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: ColoredBox(
                                          // decoration: BoxDecoration(),/
                                          color: Colors.white,
                                          child: Obx(
                                            () => Text(
                                              controller.memberAllDetails
                                                  .value[index].meal_amount
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: ColoredBox(
                                          // decoration: BoxDecoration(),/
                                          color: Colors.white,
                                          child: Text(
                                            controller
                                                .eachCostallMeal(index)
                                                .toStringAsFixed(0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: ColoredBox(
                                          // decoration: BoxDecoration(),/
                                          color: Colors.white,
                                          child: Obx(
                                            () => Text(
                                              controller.memberAllDetails
                                                  .value[index].deposit
                                                  .toString(),
                                              style: TextStyle(),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: ColoredBox(
                                        // decoration: BoxDecoration(),/
                                        color: controller.balance(index) > 0
                                            ? Colors.green
                                            : Colors.red,
                                        child: Text(
                                          controller
                                              .balance(index)
                                              .toStringAsFixed(0),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
      ),
    );
  }
}
