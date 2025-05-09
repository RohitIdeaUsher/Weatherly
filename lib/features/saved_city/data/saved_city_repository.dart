import 'package:weatherly/features/saved_city/domain/saved_city_model.dart';

abstract class SavedCityRepository {
  Future<List<SavedCityModel>> getCities();
  Future<void> removeCity(int cityId);
}
