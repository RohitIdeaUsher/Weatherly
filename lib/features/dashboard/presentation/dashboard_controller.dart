import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/features/dashboard/application/dashboard_services_impl.dart';
import 'package:weatherly/features/dashboard/domain/forecast_model.dart';
import 'package:weatherly/features/dashboard/domain/prediction.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';
import 'package:weatherly/util/location_service.dart';

part 'dashboard_controller.g.dart';

class DasboardScreenState {
  DasboardScreenState({this.weatherData, this.forecastData = const []});
  final WeatherModel? weatherData;
  final List<ForecastModel> forecastData;
}

@riverpod
class DashboardController extends _$DashboardController {
  @override
  Future<DasboardScreenState> build() async {
    final weatherData = await ref
        .read(dashbaordServicesImplProvider)
        .getCurrentWeatherData(
            lat: LocationService.position?.latitude ?? 0.0,
            long: LocationService.position?.longitude ?? 0.0);
    final foreCastList = await ref
        .read(dashbaordServicesImplProvider)
        .getFiveDaysWeatherForecast(
            lat: LocationService.position?.latitude ?? 0.0,
            long: LocationService.position?.longitude ?? 0.0);

    return DasboardScreenState(
      weatherData: weatherData,
      forecastData: foreCastList,
    );

    // return  ref.read(dashbaordServicesImplProvider).getCurrentWeatherData(lat: 0.0, long: 0,0);
  }

  /// Fetches current weather data based on the provided latitude and longitude.
  Future<WeatherModel?> getCurrentWeatherData({
    required double lat,
    required double long,
  }) async {
    return await ref.read(dashbaordServicesImplProvider).getCurrentWeatherData(
          lat: lat,
          long: long,
        );
  }

  /// Fetches a 5-day weather forecast based on the provided latitude and longitude.
  Future<List<ForecastModel>> getFiveDaysWeatherForecast({
    required double lat,
    required double long,
  }) async {
    return await ref
        .read(dashbaordServicesImplProvider)
        .getFiveDaysWeatherForecast(lat: lat, long: long);
  }

  /// Public method to fetch current weather independently
  Future<void> getLocationWiseWeather({double? lat, double? long}) async {
    state = const AsyncValue.loading();
    try {
      // final currentWeather = await getCurrentWeatherData(lat: lat, long: long);
      final newState = DasboardScreenState(
          weatherData: await getCurrentWeatherData(
              lat: lat ?? LocationService.position?.latitude ?? 0.0,
              long: long ?? LocationService.position?.longitude ?? 0.0),
          forecastData: await getFiveDaysWeatherForecast(
              lat: lat ?? LocationService.position?.latitude ?? 0.0,
              long: long ?? LocationService.position?.longitude ?? 0.0));
      state = AsyncValue.data(newState);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<List<Prediction>> placeApi({String searchQuery = ''}) async {
    return await ref
        .read(dashbaordServicesImplProvider)
        .placeApi(input: searchQuery);
  }
}
