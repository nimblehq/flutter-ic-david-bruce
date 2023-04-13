import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/auth_api_service.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/env.dart';
import 'package:survey_flutter_ic/model/login_model.dart';
import 'package:survey_flutter_ic/model/request/login_request.dart';

abstract class AuthRepository {
  Future<LoginModel> login({
    required String email,
    required String password,
  });
}

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authApiService.login(
        LoginRequest(
          email: email,
          password: password,
          clientId: Env.clientId,
          clientSecret: Env.clientSecret,
          grantType: passwordGrantType,
        ),
      );
      return LoginModel(
        id: response.id,
        accessToken: response.accessToken,
        expiresIn: response.expiresIn,
        refreshToken: response.refreshToken,
      );
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
