class Sys {
  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});
  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toInt();
    id = json['id']?.toInt();
    country = json['country']?.toString();
    sunrise = json['sunrise']?.toInt();
    sunset = json['sunset']?.toInt();
  }
  /*
{
  "type": 1,
  "id": 6736,
  "country": "IT",
  "sunrise": 1726636384,
  "sunset": 1726680975
} 
*/

  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}

class Clouds {
  Clouds({this.all});
  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all']?.toInt();
  }
  /*
{
  "all": 83
} 
*/

  int? all;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class Rain {
  Rain({this.the1h});
  Rain.fromJson(Map<String, dynamic> json) {
    the1h = json['1h']?.toDouble();
  }
  /*
{
  "1h": 2.73
} 
*/

  double? the1h;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['1h'] = the1h;
    return data;
  }
}

class Wind {
  Wind({this.speed, this.deg, this.gust});
  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed']?.toDouble();
    deg = json['deg']?.toInt();
    gust = json['gust']?.toDouble();
  }
  /*
{
  "speed": 4.09,
  "deg": 121,
  "gust": 3.47
} 
*/

  double? speed;
  int? deg;
  double? gust;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });
  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like']?.toDouble();
    tempMin = json['temp_min']?.toDouble();
    tempMax = json['temp_max']?.toDouble();
    pressure = json['pressure']?.toInt();
    humidity = json['humidity']?.toInt();
    seaLevel = json['sea_level']?.toInt();
    grndLevel = json['grnd_level']?.toInt();
  }
  /*
{
  "temp": 284.2,
  "feels_like": 282.93,
  "temp_min": 283.06,
  "temp_max": 286.82,
  "pressure": 1021,
  "humidity": 60,
  "sea_level": 1021,
  "grnd_level": 910
} 
*/

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }
}

class Weather {
  Weather({this.id, this.main, this.description, this.icon});
  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    main = json['main']?.toString();
    description = json['description']?.toString();
    icon = json['icon']?.toString();
  }
  /*
{
  "id": 501,
  "main": "Rain",
  "description": "moderate rain",
  "icon": "10d"
} 
*/

  int? id;
  String? main;
  String? description;
  String? icon;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Coord {
  Coord({this.lon, this.lat});
  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon']?.toDouble();
    lat = json['lat']?.toDouble();
  }
  /*
{
  "lon": 7.367,
  "lat": 45.133
} 
*/

  double? lon;
  double? lat;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}

class WeatherModel {
  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });
  WeatherModel.fromJson(Map<String, dynamic> json) {
    coord = (json['coord'] != null) ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      final v = json['weather'];
      final arr0 = <Weather>[];
      v.forEach((v) {
        arr0.add(Weather.fromJson(v));
      });
      weather = arr0;
    }
    base = json['base']?.toString();
    main = (json['main'] != null) ? Main.fromJson(json['main']) : null;
    visibility = json['visibility']?.toInt();
    wind = (json['wind'] != null) ? Wind.fromJson(json['wind']) : null;
    rain = (json['rain'] != null) ? Rain.fromJson(json['rain']) : null;
    clouds = (json['clouds'] != null) ? Clouds.fromJson(json['clouds']) : null;
    dt = json['dt']?.toInt();
    sys = (json['sys'] != null) ? Sys.fromJson(json['sys']) : null;
    timezone = json['timezone']?.toInt();
    id = json['id']?.toInt();
    name = json['name']?.toString();
    cod = json['cod']?.toInt();
  }
  /*
{
  "coord": {
    "lon": 7.367,
    "lat": 45.133
  },
  "weather": [
    {
      "id": 501,
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 284.2,
    "feels_like": 282.93,
    "temp_min": 283.06,
    "temp_max": 286.82,
    "pressure": 1021,
    "humidity": 60,
    "sea_level": 1021,
    "grnd_level": 910
  },
  "visibility": 10000,
  "wind": {
    "speed": 4.09,
    "deg": 121,
    "gust": 3.47
  },
  "rain": {
    "1h": 2.73
  },
  "clouds": {
    "all": 83
  },
  "dt": 1726660758,
  "sys": {
    "type": 1,
    "id": 6736,
    "country": "IT",
    "sunrise": 1726636384,
    "sunset": 1726680975
  },
  "timezone": 7200,
  "id": 3165523,
  "name": "Province of Turin",
  "cod": 200
} 
*/

  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Rain? rain;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    if (weather != null) {
      final v = weather;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v.toJson());
      }
      data['weather'] = arr0;
    }
    data['base'] = base;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    data['visibility'] = visibility;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    if (rain != null) {
      data['rain'] = rain!.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    data['dt'] = dt;
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    return data;
  }

  static String getWeatherIcon(String icon) {
    switch (icon) {
      case '01d':
        return 'assets/img/01d.png';
      case '01n':
        return 'assets/img/01n.png';
      case '02d':
        return 'assets/img/02d.png';
      case '02n':
        return 'assets/img/02n.png';
      case '03d':
        return 'assets/img/03d.png';
      case '03n':
        return 'assets/img/03n.png';
      case '04d':
        return 'assets/img/04d.png';
      case '04n':
        return 'assets/img/04n.png';
      case '09d':
        return 'assets/img/09d.png';
      case '09n':
        return 'assets/img/09n.png';
      case '10d':
        return 'assets/img/10d.png';
      case '10n':
        return 'assets/img/10n.png';
      case '11d':
        return 'assets/img/11d.png';
      case '11n':
        return 'assets/img/11n.png';
      case '13d':
        return 'assets/img/13d.png';
      case '13n':
        return 'assets/img/13n.png';
      default:
        return 'assets/img/04d.png';
    }
  }

  static String getWeatherIconSvg(String icon) {
    switch (icon) {
      case '01d':
        return 'assets/svg/01d.svg';
      case '01n':
        return 'assets/svg/01n.svg';
      case '02d':
        return 'assets/svg/02d.svg';
      case '02n':
        return 'assets/svg/02n.svg';
      case '03d':
        return 'assets/svg/03d.svg';
      case '03n':
        return 'assets/svg/03n.svg';
      case '04d':
        return 'assets/svg/04d.svg';
      case '04n':
        return 'assets/svg/04n.svg';
      case '09d':
        return 'assets/svg/09d.svg';
      case '09n':
        return 'assets/svg/09n.svg';
      case '10d':
        return 'assets/svg/10d.svg';
      case '10n':
        return 'assets/svg/10n.svg';
      case '11d':
        return 'assets/svg/11d.svg';
      case '11n':
        return 'assets/svg/11n.svg';
      case '13d':
        return 'assets/svg/13d.svg';
      case '13n':
        return 'assets/svg/13n.svg';
      case '50d':
        return 'assets/svg/50n.svg';
      case '50n':
        return 'assets/svg/50n.svg';
      default:
        return 'assets/svg/04d.svg';
    }
  }
}
