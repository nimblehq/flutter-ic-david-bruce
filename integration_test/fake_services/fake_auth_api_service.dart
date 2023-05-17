import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter_ic/api/service/auth_api_service.dart';
import 'package:survey_flutter_ic/model/request/forgot_password_request.dart';
import 'package:survey_flutter_ic/model/request/login_request.dart';
import 'package:survey_flutter_ic/model/request/refresh_token_request.dart';
import 'package:survey_flutter_ic/model/response/forgot_password_response.dart';
import 'package:survey_flutter_ic/model/response/login_response.dart';
import 'package:survey_flutter_ic/model/response/refresh_token_response.dart';
import '../utils/fake_data.dart';

const Duration fakeApiDuration = Duration(milliseconds: 50);

class FakeAuthApiService extends Fake implements AuthApiService {
  @override
  Future<LoginResponse> login(
    LoginRequest body,
  ) async {
    await Future.delayed(fakeApiDuration);
    final response = FakeData.apiAndResponse[keyLogin]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return LoginResponse.fromJson(response.json);
  }

  @override
  Future<RefreshTokenResponse> refreshToken(
    RefreshTokenRequest body,
  ) async {
    await Future.delayed(fakeApiDuration);
    final response = FakeData.apiAndResponse[keyLogin]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return RefreshTokenResponse.fromJson(response.json);
  }

  @override
  Future<ForgotPasswordResponse> forgetPassword(
    ForgotPasswordRequest body,
  ) async {
    await Future.delayed(fakeApiDuration);
    final response = FakeData.apiAndResponse[keyLogin]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return ForgotPasswordResponse.fromJson(response.json);
  }
}
