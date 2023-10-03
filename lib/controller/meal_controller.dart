import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meal_manager/constants/reference.dart';
import 'package:meal_manager/model/meal_model.dart';
import 'package:meal_manager/service/database.dart';

class MealController extends GetxController {
  static MealController get to => Get.find();

  RxList<String> allMemName = RxList<String>();
  List<String> get getMemAllName => allMemName.value;

  RxList<NameModel> allMealdayData = RxList<NameModel>();
  List<NameModel> get getAllMealdayData => allMealdayData.value;

  @override
  void onReady() {

    dateTime = DateTime.now();
    getMealEntryData();
    super.onReady();
  }

  RxList<NameModel> nameList = RxList<NameModel>();

  uploadMealDatatoServer(
      String sokal, String lunch, String dinner, String date, String name) {
    int sokalV = int.parse(sokal);
    int lunchV = int.parse(lunch);
    int dinnerV = int.parse(dinner);

    postMealEntryData(sokal, lunch, dinner, date, name);
  }

  DateTime dateTime = DateTime.now();

  RxString monthName = RxString(DateFormat.MMMMEEEEd().format(DateTime.now()));

  void updateDate(DateTime date) {
    dateTime = date;
    monthName.value = DateFormat.MMMMEEEEd().format(date);
    update();
  }

  Future<void> postMealEntryData(String sokal, String lunch, String dinner,
      String date, String name) async {

    await houseRf
        .doc('G19z5NxB2v1stFsQw2ng')
        .collection('entry')
        .doc(name)
        .set({'reason': 'demo data'});

    await houseRf
        .doc('G19z5NxB2v1stFsQw2ng')
        .collection('entry')
        .doc(name)
        .collection('day-meals')
        .doc(date)
        .set({'sokal': sokal, 'lunch': lunch, 'dinner': dinner})
        .whenComplete(() => print('successfully updtaed'))
        .catchError((e) => print(e));

    allMemName.value.clear();
    allMealdayData.value.clear(); //clear all the previous data
    getMealEntryData();
  }

  RxBool isLoaded = RxBool(false);
  int total_meal_amount = 0;
  String sName = '';
  List<Map<String, int>> allMemberTotalMealAmount = [];

  Future<void> getMealEntryData() async {
    isLoaded.value = false;
    try {
      print('getting meal entry data...');
      QuerySnapshot<Map<String, dynamic>> memberName =
          await houseRf.doc('G19z5NxB2v1stFsQw2ng').collection('entry').get();
      //memberName.docs.map((e) => print(e.toString())).toList();

      memberName.docs.forEach((element) async {
        QuerySnapshot snapshot = await houseRf
            .doc('G19z5NxB2v1stFsQw2ng')
            .collection('entry')
            .doc(element.id)
            .collection('day-meals')
            .get();

        allMemName.value.add(element.id); // adding member string to list
        sName = element.id;

        allMemName.refresh();
        total_meal_amount = 0;

        List<DayModel> _dayModel = List.generate(32, (index) => DayModel());
        snapshot.docs.forEach((e) {
          int ln = e.id.length; // 24 sep,2023

          int indx_date = int.parse(e.id.substring(ln - 2, ln)); // 24

          final _eachDay =
              (DayModel.fromJson(jsonDecode(jsonEncode(e.data()))));

          // assigning each day to the current date.
          _dayModel[indx_date] = _eachDay;

          // total meal amount of each member
          total_meal_amount += ((_eachDay.dinner ?? 0) +
              (_eachDay.sokal ?? 0) +
              (_eachDay.lunch ?? 0));
        });
        updateDataOfEntry(_dayModel); // total month day model data
        allMemberTotalMealAmount.add({sName: total_meal_amount});
        print(allMemberTotalMealAmount); // printing correct data

         // post meal amount to server
        await Database().postTotalMealAmount(allMemberTotalMealAmount);
      });
     
      
    } catch (e) {
      print(e.toString());
    }

    //TODO: here is the bug

    allMemberTotalMealAmount.clear(); // clearing previous data

    isLoaded.value = true;
  }

  void updateDataOfEntry(List<DayModel> _dayModel) {
    allMealdayData.value.add(NameModel(
        day: _dayModel)); // allMealdayData[person_index].[day_index].sokal
    // update();
    allMealdayData.refresh();
  }

  
}
