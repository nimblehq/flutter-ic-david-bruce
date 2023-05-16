import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/service/api_service.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';

import '../../model/survey_model.dart';
import '../exception/network_exceptions.dart';

abstract class SurveyRepository {
  Future<SurveysModel> getSurveysCached();

  Future<SurveysModel> fetchSurveys({
    required int pageNumber,
    required int pageSize,
  });

  Future<SurveyModel> getSurveyDetails({
    required String surveyId,
  });

  Future<void> saveSurveys({
    required SurveysModel surveys,
  });

  Future<SurveyModel?> getCurrentSurvey();

  Future<void> saveCurrentSurvey({
    required SurveyModel survey,
  });

  Future<SurveySubmissionModel?> getSurveySubmission();

  Future<void> saveSurveySubmission({
    required SurveySubmissionModel? survey,
  });

  Future<void> submitSurveyAnswer({required SurveySubmissionModel submission});
}

@LazySingleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final ApiService _apiService;
  final Storage _storage;

  SurveyRepositoryImpl(this._apiService, this._storage);

  @override
  Future<SurveysModel> getSurveysCached() async {
    final cachedResult = await _storage.surveys;
    if (cachedResult == null) {
      throw NetworkExceptions.fromDioException(Exception());
    }
    return SurveysModel.deserialize(cachedResult);
  }

  @override
  Future<SurveysModel> fetchSurveys({
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
  Future<void> saveSurveys({required SurveysModel surveys}) async {
    await _storage.saveSurveys(surveys);
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
  Future<void> saveCurrentSurvey({required SurveyModel survey}) async {
    await _storage.saveCurrentSurveyJson(jsonEncode(survey.toJson()));
  }

  @override
  Future<SurveySubmissionModel?> getSurveySubmission() async {
    try {
      final result = await _storage.currentSurveySubmissionJson;
      if (result == null) {
        return null;
      }
      dynamic json = jsonDecode(result);
      if (json is Map<String, dynamic>) {
        return SurveySubmissionModel.fromJson(json);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveSurveySubmission(
      {required SurveySubmissionModel? survey}) async {
    if (survey == null) {
      await _storage.clearSurveySubmissionJson();
    } else {
      await _storage
          .saveCurrentSurveySubmissionJson(jsonEncode(survey.toRequestJson()));
    }
  }

  @override
  Future<void> submitSurveyAnswer(
      {required SurveySubmissionModel submission}) async {
    try {
      final result =
          await _apiService.submitSurveyAnswer(submission.toRequestJson());
      return result;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
