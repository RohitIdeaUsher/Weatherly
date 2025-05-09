import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/features/dashboard/application/dashboard_services.dart';
import 'package:weatherly/features/dashboard/data/dashboard_repository_impl.dart';
import 'package:weatherly/features/dashboard/domain/forecast_model.dart';
import 'package:weatherly/features/dashboard/domain/prediction.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';
part 'dashboard_services_impl.g.dart';

class DashboardServicesImpl extends DashboardServices {
  DashboardServicesImpl(this._dashboardRepositoryImpl);
  final DashboardRepositoryImpl _dashboardRepositoryImpl;
  @override
  Future<WeatherModel?> getCurrentWeatherData({
    required double lat,
    required double long,
  }) async {
    return await _dashboardRepositoryImpl.getCurrentWeatherData(
      lat: lat,
      long: long,
    );
  }

  @override
  Future<List<ForecastModel>> getSevenDaysWeatherForecast({
    required double lat,
    required double long,
  }) async {
    return await _dashboardRepositoryImpl.getSevenDaysWeatherForecast(
      lat: lat,
      long: long,
    );
  }

  @override
  Future<List<Prediction>> placeApi({required String input}) async {
    return await _dashboardRepositoryImpl.placeApi(input: input);
  }
}

@riverpod
DashboardServicesImpl dashbaordServicesImpl(Ref ref) {
  return DashboardServicesImpl(ref.read(dashbaordRepositoryImplProvider));
}
