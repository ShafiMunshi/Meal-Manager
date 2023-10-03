class UserMealModel {
  List<NameModel>? name;

  UserMealModel({this.name});

  UserMealModel.fromJson(Map<String, dynamic> json) {
    if (json['name'] != null) {
      name = <NameModel>[];
      json['name'].forEach((v) {
        name!.add(new NameModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NameModel {
  List<DayModel>? day;

  NameModel({
    this.day,
  });

  NameModel.fromJson(Map<String, dynamic> json) {
    if (json['day'] != null) {
      day = <DayModel>[];
      json['day'].forEach((v) {
        day!.add(new DayModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.day != null) {
      data['day'] = this.day!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayModel {
  int? sokal;
  int? lunch;
  int? dinner;

  DayModel({this.sokal, this.lunch, this.dinner});

  DayModel.fromJson(Map<String, dynamic> json) {
    json['sokal'] != null ? sokal = int.parse(json['sokal'] ): sokal = 0;
    json['sokal'] != null ? lunch = int.parse(json['lunch']) : lunch = 0;
    json['sokal'] != null ? dinner = int.parse(json['dinner'] ): dinner = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sokal'] = this.sokal;
    data['lunch'] = this.lunch;
    data['dinner'] = this.dinner;
    return data;
  }
}
