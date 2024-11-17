import 'package:weatherly/features/dashboard/domain/forecast_model.dart';
import 'package:weatherly/features/dashboard/domain/prediction.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';

abstract class DashboardServices {
  Future<WeatherModel?> getCurrentWeatherData(
      {required double lat, required double long});
  Future<List<ForecastModel>> getFiveDaysWeatherForecast(
      {required double lat, required double long});
  Future<List<Prediction>> placeApi({required String input});
}
