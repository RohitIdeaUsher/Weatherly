import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/services/dependencies.dart';
import 'package:weatherly/features/dashboard/data/dashboard_repository.dart';
import 'package:weatherly/features/dashboard/domain/forecast_model.dart';
import 'package:weatherly/features/dashboard/domain/prediction.dart';
import 'package:weatherly/features/dashboard/domain/weather_model.dart';
import 'package:weatherly/services/dio/client.dart';
import 'package:weatherly/services/dio/endpoints.dart';
import 'package:weatherly/services/dio/environment.dart';
import 'package:weatherly/core/uuid_token.dart';
part 'dashboard_repository_impl.g.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  DashboardRepositoryImpl(this._dioClient);
  final DioClient _dioClient;

  @override
  Future<WeatherModel?> getCurrentWeatherData({
    required double lat,
    required double long,
  }) async {
    WeatherModel? currentWeatherData;
    try {
      //lat={lat}&lon={lon}&appid={API key}
      final param = {
        'lat': lat,
        'lon': long,
        'appid': getIt<EnvironmentService>().getValue('API_KEY'),
        'units': 'metric',
      };
      final response = await _dioClient.get(
        Endpoints.WEATHER,
        queryParameters: param,
      );
      currentWeatherData = WeatherModel.fromJson(response.data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return currentWeatherData;
  }

  @override
  Future<List<ForecastModel>> getSevenDaysWeatherForecast({
    required double lat,
    required double long,
  }) async {
    var currentWeatherData = <ForecastModel>[];
    try {
      //lat={lat}&lon={lon}&appid={API key}
      final param = {
        'lat': lat,
        'lon': long,
        // 'exclude': 'minutely,hourly,alerts',
        'units': 'metric',
        'appid': getIt<EnvironmentService>().getValue('API_KEY'),
      };
      final response = await _dioClient.get(
        Endpoints.FORECAST,
        queryParameters: param,
      );
      // final List<dynamic> data = response.data['list'];

      // currentWeatherData = data.map((e) => ForecastModel.fromJson(e)).toList();

      // Group data by day

      final List<dynamic> forecastList = response.data['list'];
      final groupedByDay = <String, List<dynamic>>{};
      for (final item in forecastList) {
        final date =
            DateTime.fromMillisecondsSinceEpoch(
              item['dt'] * 1000,
            ).toString().split(' ')[0];
        groupedByDay.putIfAbsent(date, () => []).add(item);
      }

      // Calculate daily high/low temperatures with icons
      final sevenDayForecast =
          groupedByDay.entries.take(7).map((entry) {
            final temp = entry.value.map((e) => e['main']['temp']);
            final maxTemp = temp.reduce((a, b) => a > b ? a : b);
            final minTemp = temp.reduce((a, b) => a < b ? a : b);

            final main = entry.value[0]['weather'][0]['main'];
            final icon = entry.value[0]['weather'][0]['icon']; // Weather icon

            return {
              'temp': temp.first,
              'date': entry.key,
              'maxTemp': maxTemp,
              'minTemp': minTemp,
              'main': main,
              'icon': icon,
            };
          }).toList();
      currentWeatherData =
          sevenDayForecast.map((e) => ForecastModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return currentWeatherData;
  }

  //place api....................
  @override
  Future<List<Prediction>> placeApi({required String input}) async {
    final queryParams = <String, dynamic>{
      'input': input,
      'key': getIt<EnvironmentService>().getValue('PLACE_KEY'),
      'sessiontoken': Uuid().generateV4(),
    };
    var dataList = <Prediction>[];
    if (input.isEmpty) {
      return Future.value([]);
    }
    try {
      await _dioClient
          .get(
            'https://maps.googleapis.com/maps/api/place/autocomplete/json',
            queryParameters: queryParams,
          )
          .then((response) {
            final data = response.data;
            dataList =
                (data['predictions'] as List)
                    .map((e) => Prediction.fromJson(e))
                    .toList();
          });
    } catch (e) {
      // UtilWidgets.hideLoading();
      // UtilWidgets.showToast(message: e.toString(), isError: true);
    }

    return dataList;
  }
}

@riverpod
DashboardRepositoryImpl dashbaordRepositoryImpl(Ref ref) {
  return DashboardRepositoryImpl(ref.read(dioClientProvider));
}
