import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/di/interceptor/app_interceptor.dart';
import 'package:survey_flutter_ic/env.dart';

const String headerContentType = 'Content-Type';
const String defaultContentType = 'application/json; charset=utf-8';

@Singleton()
class DioProvider {
  Dio? _dio;
  final Storage _storage;

  DioProvider(
    this._storage,
  );

  Dio getDio({required bool requireAuthenticate}) {
    _dio ??= _createDio(requireAuthenticate: requireAuthenticate);
    return _dio!;
  }

  Dio _createDio({bool requireAuthenticate = false}) {
    final dio = Dio();
    final appInterceptor = AppInterceptor(requireAuthenticate, dio, _storage);
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 5000
      ..options.headers = {headerContentType: defaultContentType}
      ..options.baseUrl = Env.restApiEndpoint
      ..interceptors.addAll(interceptors);
  }
}
