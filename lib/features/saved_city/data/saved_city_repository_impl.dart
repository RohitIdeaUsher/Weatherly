import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/services/db/hive_services/hive_service.dart';
import 'package:weatherly/features/saved_city/domain/saved_city_model.dart';

import 'saved_city_repository.dart';

part 'saved_city_repository_impl.g.dart';

class SavedCityRepositoryImpl implements SavedCityRepository {
  final HiveClient _hiveClient;
  SavedCityRepositoryImpl(this._hiveClient);

  @override
  Future<List<SavedCityModel>> getCities() async {
    return _hiveClient.getAllCities();
  }

  @override
  Future<void> removeCity(int cityId) async {
    _hiveClient.removeCity(cityId);
  }
}

@riverpod
SavedCityRepositoryImpl savedCityRepositoryImpl(Ref ref) {
  return SavedCityRepositoryImpl(ref.read(hiveClientProvider).value!);
}
