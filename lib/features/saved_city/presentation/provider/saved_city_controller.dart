import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/features/saved_city/application/saved_city_service_impl.dart';
import 'package:weatherly/features/saved_city/domain/saved_city_model.dart';

part 'saved_city_controller.g.dart';

@riverpod
class SavedCityController extends _$SavedCityController {
  @override
  Future<List<SavedCityModel>> build() async {
    final savedData = ref.read(savedCityServiceImplProvider);

    return savedData.getCities();
  }

  Future<void> removeFromFavorite(int cityId) async {
    await ref.read(savedCityServiceImplProvider).removeCity(cityId);
    state = await AsyncValue.guard(
      () => ref.read(savedCityServiceImplProvider).getCities(),
    );
  }
}
