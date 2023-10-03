class HouseModel {
  String houseName='';
  String houseID='';
  String monthName='';
  String managerName='';

  HouseModel(
      {required this.houseName,
      required this.houseID,
      required this.monthName,
      required this.managerName});

  HouseModel.fromJson(Map<String, dynamic> json)
      : houseID = json['room_id'],
        houseName = json['room-name'],
        monthName = json['month'],
        managerName = json['manager-name'];

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();

    data['room_id'] = this.houseID;
    data['room-name'] = this.houseName;
    data['month'] = this.monthName;
    data['manager-name'] = this.managerName;

    return data;
  }
}
