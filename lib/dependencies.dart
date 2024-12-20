// import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_it/get_it.dart';
import 'package:weatherly/services/environment.dart';

final getIt = GetIt.instance;

class Dependencies {
  Future<void> setUpDependencyInjection() async {
    await getIt
        .registerSingleton<EnvironmentService>(EnvironmentService(rootBundle))
        .loadEnvConfigs();
  }
}
