import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meal_manager/constants/reference.dart';
import 'package:meal_manager/controller/bajar_controller.dart';
import 'package:meal_manager/model/house_model.dart';
import 'package:meal_manager/model/house_model.dart';
import 'package:meal_manager/model/house_model.dart';
import 'package:meal_manager/model/member_model.dart';
import 'package:meal_manager/screens/home/home_screen.dart';
import 'package:meal_manager/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String docId;

class DataController extends GetxController {
  static DataController get to => Get.find();

  RxString houseName = ''.obs;
  RxString houseId = ''.obs;

  RxList<MemberModel> memberAllDetails = RxList<MemberModel>();

  List<MemberModel> get getMemberAllDetails => memberAllDetails.value;
  RxBool isLoaded1 = RxBool(false);
  RxBool isLoaded2 = RxBool(false);
  RxBool isLoaded3 = RxBool(false);

  @override
  onReady() async {
    await Database().getRoomDetails();
    await Database().getbajarData();
    await Database().getMemberData();

    getTotalBajarsssss();

    super.onReady();
  }

  int totalBajarAmount = 0;
  void getTotalBajarsssss() {
    totalBajarAmount = BazarController.to.totalBajarAmount;
  }

  void setMemberAllData(List<MemberModel> memberAllData) {
    memberAllDetails.value = memberAllData;
    memberAllDetails.refresh();
  }

// Home screen all data

  Rxn<HouseModel> houseeeData = Rxn<HouseModel>();

  void setHouseDetails(HouseModel houseDet) {
    houseeeData.value = houseDet;
    // update();
  }

  // Member Screen all operations

  RxList<String> memberList = new RxList<String>(); // member name list
  List<String> get memberNameList => memberList.value;

  RxList<MemberModel> memberDetails =
      new RxList<MemberModel>(); // member all data

  void setMemberName(List<String> memberName) {
    memberList.value = memberName;

    update();
  }

  void addMember(String name) {
    memberList.add(name);
    memberList.refresh();
  }

  void removeMember(int index) {
    memberList.removeAt(index);
    memberList.refresh();
  }

  // Local Storage functionalities

  Future<void> createHouse(String name) async {
    houseName.value = name;

    var box = await SharedPreferences.getInstance();

    await houseRf.add({
      'house-name': houseName.value,
    }).then((DocumentReference doc) {
      docId = doc.id;
      box.setString('admin-doc-id', doc.id);

      houseRf
          .doc(doc.id)
          .set({'house-name': houseName.value, 'house-id': doc.id});
    });
    navigateToHomeScreen();
  }

  void navigateToHomeScreen() {
    Get.offAndToNamed(HomeScreen.routeName);
  }

  Future<void> joinHouse(String roomId) async {
    var box = await SharedPreferences.getInstance();
    box.setString('user-doc-id', roomId);
    String? idd = box.getString('user-doc-id');
    print('Local storage user doc id: ' + idd.toString());
    navigateToHomeScreen();
  }

  int get totalMeal => getTotalMeal();
  int getTotalMeal() {
    int total = 0;
    for (var kMem in memberAllDetails.value) {
      kMem.meal_amount ?? 0;
      total += kMem.meal_amount ?? 0;
    }
    return total;
  }

  double get costPerMeal => totalBajarAmount / totalMeal;

  double eachCostallMeal(int index) {
    int? _totalMeal = memberAllDetails.value[index].meal_amount;
    return (_totalMeal ?? 1) * costPerMeal;
  }

  int remainMoney() {
    int _totalDep = 0;
    for (var mem in memberAllDetails.value) {
      _totalDep += (mem.deposit ?? 0);
    }

    return _totalDep - totalBajarAmount;
  }

  double balance(int index) {
    double _costAllMeal = eachCostallMeal(index);
    int _deposit = memberAllDetails.value[index].deposit ?? 0;

    return (_deposit) - _costAllMeal;
  }
}
