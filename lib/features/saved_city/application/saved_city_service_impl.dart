import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/features/saved_city/application/saved_city_services.dart';
import 'package:weatherly/features/saved_city/data/saved_city_repository_impl.dart';
import 'package:weatherly/features/saved_city/domain/saved_city_model.dart';
part 'saved_city_service_impl.g.dart';

class SavedCityServiceImpl extends SavedCityService {
  SavedCityServiceImpl(this._savedCityRepositoryImpl);
  final SavedCityRepositoryImpl _savedCityRepositoryImpl;

  @override
  Future<List<SavedCityModel>> getCities() async {
    return await _savedCityRepositoryImpl.getCities();
  }

  @override
  Future<void> removeCity(int cityId) async {
    return await _savedCityRepositoryImpl.removeCity(cityId);
  }
}

@riverpod
SavedCityServiceImpl savedCityServiceImpl(Ref ref) {
  return SavedCityServiceImpl(ref.read(savedCityRepositoryImplProvider));
}
