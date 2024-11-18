import 'package:mocktail/mocktail.dart';
import 'package:weatherly/services/client.dart';
import 'package:weatherly/services/environment.dart';

class MockDio extends Mock implements DioClient {}

class MockEnvironmentService extends Mock implements EnvironmentService {}
