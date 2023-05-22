import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/save_surveys_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SaveSurveysUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late SaveSurveysUseCase useCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = SaveSurveysUseCase(mockSurveyRepository);
    });

    test('When saving surveys success, it returns success result', () async {
      final surveys = SurveysModel.empty();
      when(mockSurveyRepository.saveSurveys(surveys: surveys))
          .thenAnswer((_) async => {});

      final result = await useCase.call(surveys);

      expect(result, isA<Success<void>>());
    });

    test('When saving surveys failed, it returns failed result', () async {
      final surveys = SurveysModel.empty();
      when(mockSurveyRepository.saveSurveys(surveys: surveys))
          .thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(surveys);

      expect(result, isA<Failed<void>>());
    });
  });
}
