import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_survey_details_use_case.dart';
import 'package:survey_flutter_ic/usecases/params/surveys_params.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveyDetailsUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late GetSurveyDetailsUseCase useCase;
    const surveyId = '';

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = GetSurveyDetailsUseCase(mockSurveyRepository);
    });

    test('should return Success with SurveyModel when repository call succeeds',
        () async {
      when(mockSurveyRepository.getSurveyDetails(surveyId: surveyId))
          .thenAnswer((_) async => const SurveyModel.empty());

      final result = await useCase.call(surveyId);

      expect(result, isA<Success<SurveyModel>>());
    });

    test(
        'should return Failed with UseCaseException when repository call fails',
        () async {
      when(mockSurveyRepository.getSurveyDetails(surveyId: surveyId))
          .thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(surveyId);

      expect(result, isA<Failed<SurveyModel>>());
    });
  });
}
