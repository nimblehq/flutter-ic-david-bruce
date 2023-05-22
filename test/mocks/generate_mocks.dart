import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/api/repository/user_repository.dart';
import 'package:survey_flutter_ic/api/service/api_service.dart';
import 'package:survey_flutter_ic/api/service/auth_api_service.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/fetch_surveys_use_case.dart';
import 'package:survey_flutter_ic/usecases/forgot_password_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_current_survey_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_survey_details_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_survey_submission_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_user_profile_use_case.dart';
import 'package:survey_flutter_ic/usecases/login_use_case.dart';
import 'package:survey_flutter_ic/usecases/logout_use_case.dart';
import 'package:survey_flutter_ic/usecases/save_current_survey_use_case.dart';
import 'package:survey_flutter_ic/usecases/save_survey_submission_use_case.dart';
import 'package:survey_flutter_ic/usecases/save_surveys_use_case.dart';
import 'package:survey_flutter_ic/usecases/submit_survey_answer_use_case.dart';

@GenerateMocks([
  AuthApiService,
  ApiService,
  AuthRepository,
  SaveCurrentSurveyUseCase,
  Storage,
  SurveyRepository,
  UserRepository,
  DioError,
  ForgotPasswordUseCase,
  LoginUseCase,
  FetchSurveysUseCase,
  GetSurveyDetailsUseCase,
  SaveSurveysUseCase,
  GetCurrentSurveyUseCase,
  GetSurveySubmissionUseCase,
  SaveSurveySubmissionUseCase,
  SubmitSurveyAnswerUseCase,
  LogoutUseCase,
  GetUserProfileUseCase,
  UseCaseException,
])
main() {
  // empty class to generate mock repository classes
}
