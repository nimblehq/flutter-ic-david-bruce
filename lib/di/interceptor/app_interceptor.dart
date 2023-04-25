import 'dart:io';

import 'package:dio/dio.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/model/refresh_token_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/refresh_token_use_case.dart';

const headerAuthorization = 'Authorization';
const retryLimit = 3;

class AppInterceptor extends Interceptor {
  final bool _requireAuthenticate;
  final Dio _dio;
  final Storage _storage;

  AppInterceptor(this._requireAuthenticate, this._dio, this._storage);

  Future<String> get _accessTokens async {
    final tokenType = await _storage.tokenType;
    final accessToken = await _storage.accessToken;
    if (tokenType == null || accessToken == null) return '';
    return '$tokenType $accessToken';
  }

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_requireAuthenticate) {
      String accessTokens = await _accessTokens;
      options.headers.putIfAbsent(headerAuthorization, () => accessTokens);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    if ((statusCode == HttpStatus.forbidden ||
            statusCode == HttpStatus.unauthorized) &&
        _requireAuthenticate) {
      _doRefreshToken(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _doRefreshToken(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final result = await _requestNewTokens();
      if (result is Success<RefreshTokenModel>) {
        err.requestOptions.headers[headerAuthorization] = _tokens;
        final options = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers);
        final newRequest = await _dio.request(
            "${err.requestOptions.baseUrl}${err.requestOptions.path}",
            options: options,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters);
        handler.resolve(newRequest);
      } else {
        handler.next(err);
      }
    } catch (exception) {
      if (exception is DioError) {
        handler.next(exception);
      } else {
        handler.next(err);
      }
    }
  }

  Future<String> get _tokens async {
    final tokenType = await _storage.tokenType;
    final accessToken = await _storage.accessToken;
    if (tokenType == null || accessToken == null) return '';
    return '$tokenType $accessToken';
  }

  Future<Result<RefreshTokenModel>> _requestNewTokens() {
    final refreshTokenUseCase = getIt<RefreshTokenUseCase>();
    return refreshTokenUseCase.call();
  }
}
