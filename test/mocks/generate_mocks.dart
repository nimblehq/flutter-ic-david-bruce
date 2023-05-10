import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/api/service/api_service.dart';
import 'package:survey_flutter_ic/api/service/auth_api_service.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/forgot_password_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_survey_details_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_surveys_use_case.dart';
import 'package:survey_flutter_ic/usecases/login_use_case.dart';

@GenerateMocks([
  AuthApiService,
  ApiService,
  AuthRepository,
  Storage,
  SurveyRepository,
  DioError,
  ForgotPasswordUseCase,
  LoginUseCase,
  GetSurveysUseCase,
  GetSurveyDetailsUseCase,
  UseCaseException,
])
main() {
  // empty class to generate mock repository classes
}
