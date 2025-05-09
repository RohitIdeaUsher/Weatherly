import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/features/dashboard/application/dashboard_services_impl.dart';
import 'package:weatherly/features/dashboard/domain/forecast_model.dart';
import 'package:weatherly/features/dashboard/domain/prediction.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';
import 'package:weatherly/core/location_service.dart';

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
          long: LocationService.position?.longitude ?? 0.0,
        );
    final foreCastList = await ref
        .read(dashbaordServicesImplProvider)
        .getSevenDaysWeatherForecast(
          lat: LocationService.position?.latitude ?? 0.0,
          long: LocationService.position?.longitude ?? 0.0,
        );

    return DasboardScreenState(
      weatherData: weatherData,
      forecastData: foreCastList,
    );
  }

  Future<WeatherModel?> getCurrentWeatherData({
    required double lat,
    required double long,
  }) async {
    return await ref
        .read(dashbaordServicesImplProvider)
        .getCurrentWeatherData(lat: lat, long: long);
  }

  Future<List<ForecastModel>> getSevenDaysWeatherForecast({
    required double lat,
    required double long,
  }) async {
    return await ref
        .read(dashbaordServicesImplProvider)
        .getSevenDaysWeatherForecast(lat: lat, long: long);
  }

  Future<void> getLocationWiseWeather({double? lat, double? long}) async {
    state = const AsyncValue.loading();
    try {
      final newState = DasboardScreenState(
        weatherData: await getCurrentWeatherData(
          lat: lat ?? LocationService.position?.latitude ?? 0.0,
          long: long ?? LocationService.position?.longitude ?? 0.0,
        ),
        forecastData: await getSevenDaysWeatherForecast(
          lat: lat ?? LocationService.position?.latitude ?? 0.0,
          long: long ?? LocationService.position?.longitude ?? 0.0,
        ),
      );
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
