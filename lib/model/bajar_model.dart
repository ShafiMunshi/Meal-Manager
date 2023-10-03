
class BazarModel {
  String date;
  String itemName;
  int cost;
  BazarModel({required this.itemName, required this.cost, required this.date});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['item-name'] = itemName;
    data['cost'] = cost;

    return data;
  }

  

  BazarModel.fromSnapsot(Map<String, dynamic>snapshot)

      : date = snapshot['date'],
        itemName = snapshot['item-name'],
        cost = snapshot['cost'];
}
