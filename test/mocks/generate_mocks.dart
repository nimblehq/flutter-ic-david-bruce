import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter_ic/api/auth_api_service.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';

@GenerateMocks([
  AuthApiService,
  AuthRepository,
  DioError,
])
main() {
  // empty class to generate mock repository classes
}
