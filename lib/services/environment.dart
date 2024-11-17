import 'dart:convert';
import 'package:flutter/services.dart';

class EnvironmentService {
  EnvironmentService(this.rootBundle);
  AssetBundle rootBundle;

  var configs = {};

  Future<void> loadEnvConfigs() async {
    configs = jsonDecode(await rootBundle.loadString('env.json'));
  }

  void setConfigs(cfgs) {
    configs = cfgs;
  }

  dynamic getValue(name) {
    return configs[name];
  }
}
