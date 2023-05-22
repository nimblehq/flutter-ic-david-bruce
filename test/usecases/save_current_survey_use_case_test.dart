import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/save_current_survey_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SaveCurrentSurveyUseCase', () {
    late MockSurveyRepository mockSurveyRepository;
    late SaveCurrentSurveyUseCase useCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = SaveCurrentSurveyUseCase(
        mockSurveyRepository,
      );
    });

    test('When save current survey, it returns success result', () async {
      const survey = SurveyModel.empty();
      when(mockSurveyRepository.saveCurrentSurvey(survey: survey))
          .thenAnswer((_) async => true);
      final result = await useCase.call(const SurveyModel.empty());
      expect(result, isA<Success>());
      verify(mockSurveyRepository.saveCurrentSurvey(survey: survey)).called(1);
    });
  });
}
