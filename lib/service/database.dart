import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_manager/constants/reference.dart';
import 'package:meal_manager/controller/bajar_controller.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/model/bajar_model.dart';
import 'package:meal_manager/model/house_model.dart';
import 'package:meal_manager/model/member_model.dart';
import 'package:meal_manager/utils/enum.dart';

class Database {
  Future<void> getRoomDetails() async {
    late HouseModel houseDetails;

    DocumentSnapshot snapshot = await houseRf.doc('G19z5NxB2v1stFsQw2ng').get();

    houseDetails = HouseModel.fromJson(snapshot.data() as Map<String, dynamic>);

    DataController.to.setHouseDetails(houseDetails);
    print('room details gotted');
    DataController.to.isLoaded3.value = true;
    
  }

  uploadMember(String memName) async {
    List<MemberModel> memberData = DataController.to.getMemberAllDetails;

    MemberModel memModel =
        MemberModel(name: memName, deposit: 0, meal_amount: 0);

    memberData.add(memModel);

    await houseRf.doc('G19z5NxB2v1stFsQw2ng').update({
      'member-details': jsonDecode(jsonEncode(memberData))
    }).whenComplete(() async {
      print('member total meal amount updated');
      await getMemberData(); // getting the updated data from the server
    });
  }

  Future<void> getbajarData() async {
    try {
      bool isLoaded = false;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await houseRf.doc('G19z5NxB2v1stFsQw2ng').get();

      final data = snapshot.data();
      List<BazarModel> bajar = [];

      List data1 = snapshot.data()!['bajar'];

      for (var item in data1) {
        bajar.add(BazarModel.fromSnapsot(item));
      }

      BazarController.to.setBajarList(bajar);
      BazarController.to.idLoaded.value = true;

      print('bajar list gotted');
      DataController.to.isLoaded2.value = true;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getMemberData() async {
    print('getting on member  detials');
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await houseRf.doc('G19z5NxB2v1stFsQw2ng').get();

    // print(snapshot.data());
    final data = snapshot.data();

    List<String> memberNameList = [];

    //print(snapshot.data()!['member-details']);

    List data1 = snapshot.data()!['member-details'];
    //print('printing member details...');
    //print(data1);
    List<MemberModel> memberDataList = [];
    for (var item in data1) {
      memberDataList
          .add(MemberModel.fromSnapshot(jsonDecode(jsonEncode(item))));
      memberNameList.add(item['name']);
    }

    DataController.to.setMemberName(memberNameList);
    DataController.to.setMemberAllData(memberDataList);
    DataController.to.isLoaded1.value = true;
  }

  Future<void> postTotalMealAmount(
      List<Map<String, dynamic>> memberTotalMeal) async {
    List<MemberModel> memberData = DataController.to.getMemberAllDetails;

    // print('Incoming values list: ' + memberTotalMeal.toString());

    for (var memModel in memberData) {
      for (var mem in memberTotalMeal) {
        String memberName =
            mem.keys.toString().replaceAll('(', '').replaceAll(')', '');
        String memberTotalMeal =
            mem.values.toString().replaceAll('(', '').replaceAll(')', '');

        if (memModel.name == memberName) {
          memModel.meal_amount = int.parse(memberTotalMeal);
        }
      }
    }

    houseRf.doc('G19z5NxB2v1stFsQw2ng').update({
      'member-details':
          jsonDecode(jsonEncode(memberData)) // possting each meal data
    }).whenComplete(() async {
      print('member total meal amount updated');
      await getMemberData(); // getting the updated data from the server
    }).then((value) => print('data is updated successfully'));
  }
}
