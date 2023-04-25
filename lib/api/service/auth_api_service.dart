import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:survey_flutter_ic/model/request/forgot_password_request.dart';
import 'package:survey_flutter_ic/model/request/login_request.dart';
import 'package:survey_flutter_ic/model/request/refresh_token_request.dart';
import 'package:survey_flutter_ic/model/response/forgot_password_response.dart';
import 'package:survey_flutter_ic/model/response/login_response.dart';
import 'package:survey_flutter_ic/model/response/refresh_token_response.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/oauth/token')
  Future<LoginResponse> login(
    @Body() LoginRequest body,
  );

  @POST('/oauth/token')
  Future<RefreshTokenResponse> refreshToken(
    @Body() RefreshTokenRequest body,
  );

  @POST('/passwords')
  Future<ForgotPasswordResponse> forgotPassword(
    @Body() ForgotPasswordRequest body,
  );
}
