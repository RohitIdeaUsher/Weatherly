import '../domain/saved_city_model.dart';

abstract class SavedCityService {
  Future<List<SavedCityModel>> getCities();
  Future<void> removeCity(int cityId);
}
