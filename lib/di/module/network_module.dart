import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/service/api_service.dart';
import 'package:survey_flutter_ic/api/service/auth_api_service.dart';
import 'package:survey_flutter_ic/di/provider/dio_provider.dart';
import 'package:survey_flutter_ic/env.dart';

@module
abstract class NetworkModule {
  @Singleton()
  AuthApiService provideAuthApiService(DioProvider dioProvider) {
    return AuthApiService(
      dioProvider.getDio(requireAuthenticate: false),
      baseUrl: Env.restApiEndpoint,
    );
  }

  @Singleton()
  ApiService provideApiService(DioProvider dioProvider) {
    return ApiService(
      dioProvider.getDio(requireAuthenticate: true),
      baseUrl: Env.restApiEndpoint,
    );
  }
}
