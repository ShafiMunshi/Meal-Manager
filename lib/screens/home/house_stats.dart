import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/screens/widgets/bigtext_widget.dart';
import 'package:meal_manager/screens/widgets/table_widget.dart';

class HouseStats extends StatefulWidget {
  HouseStats({super.key});

  @override
  State<HouseStats> createState() => _HouseStatsState();
}

class _HouseStatsState extends State<HouseStats> {
  DateTime selectedDate = DateTime.now();
  String monthName = DateFormat.MMM().format(DateTime.now());
  var dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Table(
      // defaultColumnWidth: FlexColumnWidth(12),
      border: TableBorder.all(color: Colors.black, width: 1),
      children: [
        TableRow(children: [
          tableCell('Current Month', color: Colors.green.withOpacity(0.5)),
          TableCell(
              child: SizedBox(
            height: 25,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BigText(
                  text: '${monthName}-${selectedDate.year}',
                  color: Colors.red,
                  size: 15,
                  isBold: true,
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      final DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2030));

                      if (dateTime != null) {
                        setState(() {
                          selectedDate = dateTime;
                          monthName = DateFormat.MMM().format(dateTime);
                        });
                      }
                    },
                    icon: Icon(Icons.add_box_outlined))
              ],
            ),
          ))
        ]),
        TableRow(children: [
          tableCell('Total Meal', color: Colors.green.withOpacity(0.5)),
          tableCell(
            dataController.getTotalMeal().toString(),
          ),
        ]),
        TableRow(children: [
          tableCell('Total Bazar', color: Colors.green.withOpacity(0.5)),
          tableCell(dataController.totalBajarAmount.toString()),
        ]),
        TableRow(children: [
          tableCell('Cost per Meal', color: Colors.green.withOpacity(0.5)),
          tableCell(dataController.costPerMeal.toStringAsFixed(2)),
        ]),

        TableRow(children: [
          tableCell('Remaining money on Manager',
              color: Colors.green.withOpacity(0.5)),
          tableCell(dataController.remainMoney().toString()),
        ]),
      ],
    );
  }
}
