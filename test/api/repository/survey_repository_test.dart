import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/response/surveys_meta_response.dart';
import 'package:survey_flutter_ic/model/response/surveys_response.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SurveyRepositoryImplTest', () {
    late MockApiService mockApiService;
    late SurveyRepositoryImpl surveyRepository;

    setUp(() {
      mockApiService = MockApiService();
      surveyRepository = SurveyRepositoryImpl(mockApiService);
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
  });
}
