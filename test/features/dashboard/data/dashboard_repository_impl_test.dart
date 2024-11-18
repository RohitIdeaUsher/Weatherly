import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherly/dependencies.dart';
import 'package:weatherly/features/dashboard/data/dashboard_repository_impl.dart';
import 'package:weatherly/services/client.dart';
import 'package:weatherly/services/endpoints.dart';
import 'package:weatherly/services/environment.dart';

import '../../../mock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;
  late DioClient mockDioClient;
  late DashboardRepositoryImpl dashboardRepository;
  late EnvironmentService mockEnvironmentServices;
  const apiKey = '';

  setUpAll(() async {
    await Dependencies().setUpDependencyInjection();
    mockEnvironmentServices = getIt<EnvironmentService>();
    mockDioClient = MockDio();
    dashboardRepository = DashboardRepositoryImpl(mockDioClient);
  });

  group('dashboard repository', () {
    test('get getCurrentWeatherData on success response  Future<WeatherModel?>',
        () async {
      when(() => mockEnvironmentServices.getValue('API_KEY'))
          .thenReturn(apiKey);
      when(() => mockDioClient.get(Endpoints.WEATHER,
          queryParameters: any(named: 'queryParameters'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(data: {
            'coord': {'lon': 7.367, 'lat': 45.133},
            'weather': [
              {
                'id': 501,
                'main': 'Rain',
                'description': 'moderate rain',
                'icon': '10d'
              }
            ],
            'base': 'stations',
            'main': {
              'temp': 284.2,
              'feels_like': 282.93,
              'temp_min': 283.06,
              'temp_max': 286.82,
              'pressure': 1021,
              'humidity': 60,
              'sea_level': 1021,
              'grnd_level': 910
            },
            'visibility': 10000,
            'wind': {'speed': 4.09, 'deg': 121, 'gust': 3.47},
            'rain': {'1h': 2.73},
            'clouds': {'all': 83},
            'dt': 1726660758,
            'sys': {
              'type': 1,
              'id': 6736,
              'country': 'IT',
              'sunrise': 1726636384,
              'sunset': 1726680975
            },
            'timezone': 7200,
            'id': 3165523,
            'name': 'Province of Turin',
            'cod': 200
          }),
        ),
      );

      // Act
      final result = await dashboardRepository.getCurrentWeatherData(
          lat: 90.9, long: 66.5);

      // Assert
      // expect(result, isNotNull);
    });
  });
}
