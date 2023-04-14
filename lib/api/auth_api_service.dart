import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:survey_flutter_ic/model/request/login_request.dart';
import 'package:survey_flutter_ic/model/response/login_response.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/oauth/token')
  Future<LoginResponse> login(
    @Body() LoginRequest body,
  );
}
