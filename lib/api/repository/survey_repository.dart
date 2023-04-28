import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/service/api_service.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';

import '../exception/network_exceptions.dart';

abstract class SurveyRepository {
  Future<SurveysModel> getSurveys({
    required int pageNumber,
    required int pageSize,
  });
}

@LazySingleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final ApiService _apiService;

  SurveyRepositoryImpl(this._apiService);

  @override
  Future<SurveysModel> getSurveys({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final result = await _apiService.getSurveys(pageNumber, pageSize);
      return result.toSurveysModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
