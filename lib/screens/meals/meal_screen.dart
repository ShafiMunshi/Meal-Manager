import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/controller/meal_controller.dart';
import 'package:meal_manager/screens/meals/add_meal_screen.dart';
import 'package:meal_manager/screens/meals/decorated_table_widget.dart';

import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:table_sticky_headers/src/custom_properties/cell_alignments.dart';
import 'package:table_sticky_headers/src/custom_properties/cell_dimensions.dart';
import 'package:table_sticky_headers/src/custom_properties/scroll_controllers.dart';

class MealScreen extends StatefulWidget {
  static const String routeName = '/meal-screen';

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  int _selectedIndex = 0;

  var controller = Get.find<MealController>();

  late List<String> titleCol;

  @override
  void initState() {
    titleCol = MealController.to.allMemName.value;
    print('conntroller name length: ' +
        MealController.to.allMemName.value.length.toString());
    super.initState();
  }

  List<String> titleRow = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];

  List<List<String>> titledata = [
    ['happy', 'no', 'yes', 'good', 'better'],
    ['sad', 'seg', 'sell', 'no', 'yes'], // full column data..
    ['good', 'no', 'yes', 'yes', 'good'],
    ['happy', 'no', 'yes', 'good', 'better'],
    ['sad', 'seg', 'sell', 'no', 'yes'],
  ];

  Widget _widgetOptions() {
    print('Name list length= ' + titleCol.length.toString());
    return StickyHeadersTable(
      columnsLength: titleCol.length,
      rowsLength: titleRow.length,
      columnsTitleBuilder: (i) => Text(titleCol[i]),
      rowsTitleBuilder: (i) => Text(titleRow[i]),
      contentCellBuilder: (i, j) => Text(titledata[i][j]),
      legendCell: Text('Sticky Legend'),
    );
  }

  Widget _option2() {
    return DecoratedTablePage(
      titleColumn: titleCol,
      titleRow: titleRow,
      data: titledata,
    );
  }

  @override
  Widget build(BuildContext context) {
    int person = 0;
    int date = 0;
    int bela = 0;
    // print(memberMeal[person]['shafi']![date]['day1']![bela]['lunch']);
    print('Name list length= ' + titleCol.length.toString());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Get.toNamed(AddMealScreen.routeName),
        ),
        body: SafeArea(
          child: Obx(
            (() => controller.isLoaded.value
                ? Center(child: _option2())
                : Center(child: CircularProgressIndicator())),
          ),
        ));
  }
}
