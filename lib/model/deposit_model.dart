class DepositModel {
  // String id;
  String name;
  int deposit_amount;
  String deposit_date;

  DepositModel(
      {
        // required this.id,
      required this.name,
      required this.deposit_amount,
      required this.deposit_date});

  DepositModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        // id = json['id'],
        deposit_amount = json['amount'] ,
        deposit_date = json['deposit-date'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['deposit_amount'] = this.deposit_amount;
    data['deposit_date'] = this.deposit_date;
    return data;
  }
}
