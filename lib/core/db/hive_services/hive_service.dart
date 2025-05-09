import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/features/saved_city/domain/saved_city_model.dart';
part 'hive_service.g.dart';

class HiveClient {
  HiveClient(this._box);

  final Box<SavedCityModel> _box;

  Future<bool> addCity(SavedCityModel city) async {
    try {
      SavedCityModel? existingCity = _box.values
          .cast<SavedCityModel?>()
          .firstWhere((element) => element?.id == city.id, orElse: () => null);

      if (existingCity == null) {
        await _box.add(city);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  List<SavedCityModel> getAllCities() {
    return _box.values.cast<SavedCityModel>().toList();
  }

  Future<void> removeCity(int cityId) async {
    try {
      final index = _box.values.toList().indexWhere(
        (city) => city.id == cityId,
      );

      if (index != -1) {
        await _box.deleteAt(index);
      } else {
        throw Exception('City with id $cityId not found');
      }
    } catch (e) {
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
Future<Box<SavedCityModel>> hiveBox(Ref ref) async {
  return await Hive.openBox<SavedCityModel>('cities');
}

@Riverpod(keepAlive: true)
Future<HiveClient> hiveClient(Ref ref) async {
  final hiveBox = await ref.watch(hiveBoxProvider.future);
  return HiveClient(hiveBox);
}
