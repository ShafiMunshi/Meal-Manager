import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meal_manager/constants/reference.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/controller/meal_controller.dart';
import 'package:meal_manager/model/deposit_model.dart';
import 'package:meal_manager/model/member_model.dart';
import 'package:meal_manager/service/database.dart';

class ManagerMoneyController extends GetxController {
  static ManagerMoneyController get to => Get.find();

  RxList<DepositModel> allMemberDepositData = RxList<DepositModel>();

  List<DepositModel> get getAllDeposits => allMemberDepositData.value;

  @override
  void onReady() {
    getMemberDeposit();
    super.onReady();
  }

  List<Map<String, dynamic>> depostedData = [];

  void postMemberMoneyData(String sname, int tk, String depositDate) {
    houseRf.doc('G19z5NxB2v1stFsQw2ng').collection('member-deposits').add({
      'name': sname,
      'amount': tk,
      'deposit-date': MealController.to.monthName.value
    }).whenComplete(() {
      getMemberDeposit();
      print('Member amount added successfully');
    });

// remove these
    List<MemberModel> memberAllData = DataController.to.getMemberAllDetails;


    for (var memModel in memberAllData) {
      if (memModel.name == sname) {
        

        int total = memModel.deposit == null ? (tk) : (memModel.deposit! + tk);
        memModel.deposit = total;
      }
    }
    houseRf.doc('G19z5NxB2v1stFsQw2ng').update({
      'member-details': jsonDecode(
          jsonEncode(memberAllData)) // possting each deposit amount data
    }).whenComplete(() async {
      print('member money amount updated');
      await Database()
          .getMemberData(); // getting the updated data from the server
    });
  }

  RxBool isLoaded = RxBool(false);

  Future<void> getMemberDeposit() async {
    allMemberDepositData.value.clear();
    isLoaded.value = false;
    QuerySnapshot<Map<String, dynamic>> snapshot = await houseRf
        .doc('G19z5NxB2v1stFsQw2ng')
        .collection('member-deposits')
        .orderBy(
          'deposit-date',
          descending: false,
        )
        .get();

    snapshot.docs.forEach((element) {
      print(element.data());
      allMemberDepositData.value
          .add(DepositModel.fromJson(element.data() as Map<String, dynamic>));
      allMemberDepositData.refresh();
    });
    isLoaded.value = true;
    update();
  }

  void removeDeposit(int id) {
    houseRf
        .doc('G19z5NxB2v1stFsQw2ng')
        .collection('member-deposits')
        .doc(id.toString())
        .delete();
  }
}
