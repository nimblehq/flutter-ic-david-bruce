import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/service/auth_api_service.dart';
import 'package:survey_flutter_ic/env.dart';
import 'package:survey_flutter_ic/model/login_model.dart';
import 'package:survey_flutter_ic/model/refresh_token_model.dart';
import 'package:survey_flutter_ic/model/request/forgot_password_request.dart';
import 'package:survey_flutter_ic/model/request/forgot_password_user_request.dart';
import 'package:survey_flutter_ic/model/request/login_request.dart';
import 'package:survey_flutter_ic/model/request/refresh_token_request.dart';

abstract class AuthRepository {
  Future<LoginModel> login({
    required String email,
    required String password,
  });

  Future<RefreshTokenModel> refreshToken({required String refreshToken});

  Future<String> forgotPassword({
    required String email,
  });
}

@LazySingleton(as: AuthRepository)
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
          grantType: LoginRequest.passwordGrantType,
        ),
      );
      return response.toModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<RefreshTokenModel> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _authApiService.refreshToken(RefreshTokenRequest(
        refreshToken: refreshToken,
        clientId: Env.clientId,
        clientSecret: Env.clientSecret,
        grantType: RefreshTokenRequest.refreshTokenGrantType,
      ));
      return RefreshTokenModel(
        id: response.id,
        tokenType: response.tokenType,
        accessToken: response.accessToken,
        expiresIn: response.expiresIn,
        refreshToken: response.refreshToken,
      );
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    try {
      final response = await _authApiService.forgotPassword(
        ForgotPasswordRequest(
          user: ForgotPasswordUserRequest(email: email),
          clientId: Env.clientId,
          clientSecret: Env.clientSecret,
        ),
      );
      return response.meta.message;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
