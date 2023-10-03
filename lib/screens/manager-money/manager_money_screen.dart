import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/controller/manager_money_conntroller.dart';
import 'package:meal_manager/controller/meal_controller.dart';
import 'package:meal_manager/screens/widgets/new_date_picker.dart';
import 'package:meal_manager/utils/ui_parameter.dart';

class ManagerMoneyScreen extends StatefulWidget {
  const ManagerMoneyScreen({super.key});

  static const String routeName = '/manager_money-screen';

  @override
  State<ManagerMoneyScreen> createState() => _ManagerMoneyScreenState();
}

class _ManagerMoneyScreenState extends State<ManagerMoneyScreen> {
  TextEditingController moneyController = TextEditingController();

  DataController controller = Get.find<DataController>();
  ManagerMoneyController mnControllerr = Get.find<ManagerMoneyController>();

  late String dropdownValue;
  String date = DateTime.now().toString();

  @override
  void initState() {
    super.initState();

    List<String> memberList = controller.memberList;

    dropdownValue = controller.memberList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // var controller = Get.find<DataController>();
      appBar: AppBar(
        title: Text('Manager Money'),
      ),
      body: controller.memberList.isEmpty
          ? Center(
              child: Text(
                  'There are no person have not added yet'), // TODO: a condtio will use in this body,, otherwise it error bad state...
            )
          : Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
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
                        Row(
                          children: [
                            Icon(Icons.calendar_month),
                            TextButton(
                                onPressed: () async {
                                  final DateTime? dateTime =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2023),
                                          lastDate: DateTime(2030));
                                  MealController.to.updateDate(dateTime!);
                                  setState(() {});
                                },
                                child: Text(MealController.to.monthName.value
                                    .toString()))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.attach_money_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: Get.width - 100,
                              child: TextField(
                                controller: moneyController,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    focusedBorder:
                                        UiParameters.textInputBorder(),
                                    enabledBorder:
                                        UiParameters.textInputBorder(),
                                    hintText: 'Enter Amount'),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(Icons.person_add_alt_sharp),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                                width: Get.width - 100,
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: Icon(Icons.arrow_drop_down),
                                  items: controller.memberList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        int money = int.parse(moneyController.text);
                        // controller.memberDeposits.add({dropdownValue: money});
                        ManagerMoneyController.to.postMemberMoneyData(
                            dropdownValue,
                            money,
                            MealController.to.monthName.value);
                        moneyController.clear();
                        print('name: $dropdownValue taka: $money');
                      },
                      child: Text('Add')),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Obx(
                      () => !mnControllerr.isLoaded.value
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: mnControllerr
                                  .allMemberDepositData.value.length,
                              itemBuilder: (BuildContext context, int index) {
                                String name = mnControllerr
                                    .allMemberDepositData.value[index].name
                                    .toString();

                                String tk = mnControllerr.allMemberDepositData
                                    .value[index].deposit_amount
                                    .toString();
                                String datee = mnControllerr
                                    .allMemberDepositData
                                    .value[index]
                                    .deposit_date
                                    .toString();
                                if (tk == 'null') tk = '0';
                                return Card(
                                  child: ListTile(
                                    title: Text(name),
                                    leading:
                                        Icon(Icons.monetization_on_outlined),
                                    trailing: Text(tk + ' tk'),
                                    subtitle: Text(datee),
                                  ),
                                );
                              },
                            ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
