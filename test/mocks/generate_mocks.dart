import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter_ic/api/auth_api_service.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/forgot_password_use_case.dart';
import 'package:survey_flutter_ic/usecases/login_use_case.dart';

@GenerateMocks([
  AuthApiService,
  AuthRepository,
  Storage,
  DioError,
  ForgotPasswordUseCase,
  LoginUseCase,
  UseCaseException,
])
main() {
  // empty class to generate mock repository classes
}
