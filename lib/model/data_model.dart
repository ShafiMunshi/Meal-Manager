


import 'package:cloud_firestore/cloud_firestore.dart';

class MealModel {
  String roomName;
  String managerName;
  String currentMonth;
  int totalBazar;
  int totalMeal;
  List<UserData>? userData;

  MealModel({
    required this.roomName,
    required this.managerName,
    required this.currentMonth,
    required this.totalBazar,
    required this.totalMeal,
    this.userData,
  });

  Map<String, dynamic> toSnapshot() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['room-name'] = roomName;
    data['manager-name'] = managerName;
    data['current-month'] = currentMonth;
    data['total-bazar'] = totalBazar;
    data['total-meal'] = totalMeal;
    if(userData!=null){

      data['user-data']=userData!.map((e) => e.toSnapshot()).toList();
    }

    return data;
  }

  MealModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : roomName = json['room-name'],
        managerName = json['manager-name'],
        currentMonth = json['current-month'],
        totalBazar = json['total-bazar'],
        totalMeal = json['total-meal'],
        userData =[];
}

class UserData {
  String name;
  int mealCount;
  int depositAmount;

  UserData.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> json)
      : name = json['name'],
        mealCount = json['meal-count'],
        depositAmount = json['deposit-amount'];

  Map<String, dynamic> toSnapshot() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['name'] = name;
    data['meal-count'] = mealCount;
    data['deposit-amount'] = depositAmount;

    return data;
  }
}
