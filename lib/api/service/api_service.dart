import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/response/surveys_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/api/v1/surveys?page[number]={page_number}&page[size]={page_size}')
  Future<SurveysResponse> getSurveys(
    @Path('page_number') int pageNumber,
    @Path('page_size') int pageSize,
  );
}
