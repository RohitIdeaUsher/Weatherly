import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weatherly/features/dashboard/application/dashboard_services_impl.dart';
import 'package:weatherly/features/dashboard/domain/prediction.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  @override
  Future<List<Prediction>> build({required String query}) async {
    return await ref.read(dashbaordServicesImplProvider).placeApi(input: query);
  }
}
