class ForecastModel {
  ForecastModel({
    this.temp,
    this.date,
    this.maxTemp,
    this.minTemp,
    this.main,
    this.icon,
  });
  ForecastModel.fromJson(Map<String, dynamic> json) {
    temp = json['temp']?.toString();
    date = json['date']?.toString();
    maxTemp = json['maxTemp']?.toString();
    minTemp = json['minTemp']?.toString();
    main = json['main']?.toString();
    icon = json['icon']?.toString();
  }
  /*
{
  "temp": "temp",
  "date": "entry.key",
  "maxTemp": "",
  "minTemp": "minTemp",
  "main": "main",
  "icon": "icon"
} 
*/

  String? temp;
  String? date;
  String? maxTemp;
  String? minTemp;
  String? main;
  String? icon;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['date'] = date;
    data['maxTemp'] = maxTemp;
    data['minTemp'] = minTemp;
    data['main'] = main;
    data['icon'] = icon;
    return data;
  }
}
