import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/service/api_service.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';

import '../exception/network_exceptions.dart';

abstract class SurveyRepository {
  Future<SurveysModel> getSurveys({
    required int pageNumber,
    required int pageSize,
  });

  Future<SurveyModel> getSurveyDetails({
    required String surveyId,
  });

  Future<SurveyModel?> getCurrentSurvey();

  Future<bool> saveCurrentSurvey({
    required SurveyModel survey,
  });
}

@LazySingleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final ApiService _apiService;
  final Storage _storage;

  SurveyRepositoryImpl(this._apiService, this._storage);

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

  @override
  Future<SurveyModel> getSurveyDetails({required String surveyId}) async {
    try {
      final result = await _apiService.getSurveyDetails(surveyId);
      return result.toSurveyModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<SurveyModel?> getCurrentSurvey() async {
    try {
      final result = await _storage.currentSurveyJson;
      if (result == null) {
        return null;
      }
      dynamic json = jsonDecode(result);
      if (json is Map<String, dynamic>) {
        return SurveyModel.fromJson(json);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> saveCurrentSurvey({required SurveyModel survey}) async {
    await _storage.saveCurrentSurveyJson(jsonEncode(survey.toJson()));
    return true;
  }
}
