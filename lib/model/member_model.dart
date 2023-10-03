import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  String? name;
  int? deposit;

  int? meal_amount;

  MemberModel({this.name, this.deposit, this.meal_amount});

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['name'] = name;
    data['deposit'] = deposit;

    data['meal_amount'] = meal_amount;

    return data;
  }

   MemberModel.fromSnapshot(Map<String, dynamic> snapshot) {
    name = snapshot['name'];
    deposit = snapshot['deposit'];

    meal_amount = snapshot['meal_amount'];
  }
}
