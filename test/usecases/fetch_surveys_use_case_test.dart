import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/fetch_surveys_use_case.dart';
import 'package:survey_flutter_ic/usecases/params/surveys_params.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('FetchSurveysUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late FetchSurveysUseCase useCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = FetchSurveysUseCase(mockSurveyRepository);
    });

    test('When getting surveys success, it returns success result', () async {
      when(mockSurveyRepository.fetchSurveys(pageSize: 0, pageNumber: 0))
          .thenAnswer((_) async => SurveysModel.empty());

      final result = await useCase.call(SurveysParams(
        pageNumber: 0,
        pageSize: 0,
      ));

      expect(result, isA<Success<SurveysModel>>());
    });

    test('When getting surveys failed, it returns failed result', () async {
      when(mockSurveyRepository.fetchSurveys(pageSize: 0, pageNumber: 0))
          .thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(SurveysParams(
        pageNumber: 0,
        pageSize: 0,
      ));

      expect(result, isA<Failed<SurveysModel>>());
    });
  });
}
