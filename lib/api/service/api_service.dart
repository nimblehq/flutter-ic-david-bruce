import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:survey_flutter_ic/model/response/user_response.dart';

import '../../model/response/survey_response.dart';
import '../../model/response/surveys_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/me')
  Future<UserResponse> getUserProfile();

  @GET('/surveys?page[number]={page_number}&page[size]={page_size}')
  Future<SurveysResponse> getSurveys(
    @Path('page_number') int pageNumber,
    @Path('page_size') int pageSize,
  );

  @GET('/surveys/{survey_id}')
  Future<SurveyResponse> getSurveyDetails(
    @Path('survey_id') String surveyId,
  );

  @POST('/responses')
  Future<void> submitSurveyAnswer(
    @Body() Map<String, dynamic> body,
  );
}
