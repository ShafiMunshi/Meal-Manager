import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/constants/reference.dart';
import 'package:meal_manager/model/bajar_model.dart';
import 'package:meal_manager/screens/widgets/dialog/custom_snackbar.dart';


class BazarController extends GetxController {
  static BazarController get to => Get.find();

  RxList<BazarModel> bajarList = <BazarModel>[].obs;
  List<BazarModel> get getBajarList => bajarList.value;

  late BazarModel bajarModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();

  RxBool idLoaded = RxBool(false);
  @override
  Future<void> onReady() async {
    // await Database().getbajarData();
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    costController.dispose();
    super.onClose();
  }

  void addData(String name, int cost, String date) {
    bajarModel = BazarModel(itemName: name, cost: cost, date: date);
    bajarList.value.add(bajarModel);
    bajarList.refresh();
    nameController.clear();
    costController.clear();
    print(bajarList.value);
    ScaffoldMessenger.of(Get.context!)
        .showSnackBar(customSnackBar('$name has been added'));
    // update();/
  }

  void uploadDataToServer() {
    houseRf
        .doc('G19z5NxB2v1stFsQw2ng') // document id
        .update({'bajar': jsonDecode(jsonEncode(bajarList))})
        .catchError((e) => print(e))
        .whenComplete(() => print('bajar list uploaded'));
  }

  int totalBajarAmount = 0;
  void setBajarList(List<BazarModel> bajar) {
    bajarList.value = bajar;
    bajarList.refresh();
    if (bajarList.value.isEmpty) print('Bajarrr is empty from bajarController');
    for (var kBajar in bajarList.value) {
      totalBajarAmount += kBajar.cost;
    }

    print('totalBajarAmount from bajarcontorller: ' + totalBajarAmount.toString());
  }

  void editBajarList(int index) {
    nameController.text = bajarList.value[index].itemName;
    costController.text = bajarList.value[index].cost.toString();
  }

  void updateOnEdit(int index) {
    bajarList.value[index].itemName = nameController.text;
    bajarList.value[index].cost = int.parse(costController.text);
    bajarList.refresh();
  }
}
