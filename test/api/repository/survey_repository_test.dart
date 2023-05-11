import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/response/survey_response.dart';
import 'package:survey_flutter_ic/model/response/surveys_meta_response.dart';
import 'package:survey_flutter_ic/model/response/surveys_response.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';

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

    test('returns SurveysModel when getSurveys successful', () async {
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

    test('throws NetworkExceptions when unsuccessful', () async {
      when(mockApiService.getSurveys(any, any)).thenThrow(Exception());

      try {
        await surveyRepository.getSurveys(pageSize: 0, pageNumber: 0);
      } catch (e) {
        expect(e, isInstanceOf<NetworkExceptions>());
      }
    });

    test('returns SurveyModel when getSurveyDetails successful', () async {
      final surveyResponse = SurveyResponse(
        id: '123',
        title: 'Duc',
        description: 'Bui',
        thankEmailAboveThreshold: 'thankEmailAboveThreshold',
        thankEmailBelowThreshold: 'thankEmailBelowThreshold',
        isActive: true,
        coverImageUrl: 'coverImageUrl',
        createdAt: 'createdAt',
        activeAt: 'activeAt',
        inactiveAt: 'inactiveAt',
        surveyType: 'surveyType',
        questions: [],
      );

      when(mockApiService.getSurveyDetails(any))
          .thenAnswer((_) async => surveyResponse);

      final result = await surveyRepository.getSurveyDetails(surveyId: '123');

      expect(result, surveyResponse.toSurveyModel());
    });

    test('throws NetworkExceptions when getSurveyDetails unsuccessful',
        () async {
      when(mockApiService.getSurveyDetails(any)).thenThrow(Exception());

      try {
        await surveyRepository.getSurveyDetails(surveyId: '123');
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

    test('returns void when submitSurveyAnswer successful', () async {
      final submission = SurveySubmissionModel(surveyId: '123', questions: []);

      when(mockApiService.submitSurveyAnswer(submission.toJson()))
          // ignore: avoid_returning_null_for_void
          .thenAnswer((_) async => null);

      await surveyRepository.submitSurveyAnswer(submission: submission);

      verify(mockApiService.submitSurveyAnswer(submission.toJson())).called(1);
    });

    test('throws NetworkExceptions when submitSurveyAnswer unsuccessful',
        () async {
      final submission = SurveySubmissionModel(surveyId: '123', questions: []);
      when(mockApiService.submitSurveyAnswer(submission.toJson()))
          .thenThrow(Exception());

      try {
        await surveyRepository.submitSurveyAnswer(submission: submission);
      } catch (e) {
        expect(e, isInstanceOf<NetworkExceptions>());
      }
    });
  });
}
