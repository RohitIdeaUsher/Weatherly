import 'package:hive/hive.dart';

part 'saved_city_model.g.dart';

@HiveType(typeId: 0) // Assign a unique ID for your model
class SavedCityModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  double? lat;

  @HiveField(3)
  double? long;

  SavedCityModel({this.id, this.name, this.lat, this.long});
  SavedCityModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    lat = json['lat']?.toDouble();
    long = json['long']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
