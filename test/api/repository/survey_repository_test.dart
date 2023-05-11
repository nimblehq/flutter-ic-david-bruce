import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/response/surveys_meta_response.dart';
import 'package:survey_flutter_ic/model/response/surveys_response.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SurveyRepositoryImplTest', () {
    late MockApiService mockApiService;
    late MockStorage mockStorage;
    late SurveyRepositoryImpl surveyRepository;

    setUp(() {
      mockApiService = MockApiService();
      mockStorage = MockStorage();
      surveyRepository = SurveyRepositoryImpl(mockApiService, mockStorage);
    });

    test('When getting surveys is successful, it returns a SurveysModel',
        () async {
      final surveysResponse = SurveysResponse(
          data: List.empty(),
          meta: SurveysMetaResponse(
            page: 0,
            pages: 0,
            pageSize: 0,
            records: 0,
          ));

      when(mockApiService.getSurveys(any, any))
          .thenAnswer((_) async => surveysResponse);

      final result =
          await surveyRepository.getSurveys(pageSize: 0, pageNumber: 0);

      expect(result, surveysResponse.toSurveysModel());
    });

    test('When getting surveys fails, it throws a NetworkExceptions', () async {
      when(mockApiService.getSurveys(any, any)).thenThrow(Exception());

      try {
        await surveyRepository.getSurveys(pageSize: 0, pageNumber: 0);
      } catch (e) {
        expect(e, isInstanceOf<NetworkExceptions>());
      }
    });

    test('When getting surveys is successful, it returns a SurveysModel',
        () async {
      final surveysResponse = SurveysResponse(
          data: List.empty(),
          meta: SurveysMetaResponse(
            page: 0,
            pages: 0,
            pageSize: 0,
            records: 0,
          ));

      when(mockApiService.getSurveys(any, any))
          .thenAnswer((_) async => surveysResponse);

      final result =
          await surveyRepository.getSurveys(pageSize: 0, pageNumber: 0);

      expect(result, surveysResponse.toSurveysModel());
    });

    test('When getting surveys fails, it throws a NetworkExceptions', () async {
      when(mockApiService.getSurveys(any, any)).thenThrow(Exception());

      try {
        await surveyRepository.getSurveys(pageSize: 0, pageNumber: 0);
      } catch (e) {
        expect(e, isInstanceOf<NetworkExceptions>());
      }
    });

    test('getCurrentSurvey returns null', () async {
      const surveyModel = SurveyModel.empty();
      final surveyJson = surveyModel.toJson().toString();

      when(mockStorage.currentSurveyJson).thenAnswer((_) async => surveyJson);

      final result = await surveyRepository.getCurrentSurvey();

      expect(result, isNull);
    });

    test('saveCurrentSurvey returns true', () async {
      const surveyModel = SurveyModel.empty();

      final result =
          await surveyRepository.saveCurrentSurvey(survey: surveyModel);

      expect(result, true);
      verify(
          mockStorage.saveCurrentSurveyJson(jsonEncode(surveyModel.toJson())));
    });
  });
}
