import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/submit_survey_answer_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SubmitSurveyAnswerUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late SubmitSurveyAnswerUseCase useCase;
    const surveyId = '';

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = SubmitSurveyAnswerUseCase(mockSurveyRepository);
    });

    final submission = SurveySubmissionModel(surveyId: '123', questions: []);

    test('should submit survey answer to repository', () async {
      when(mockSurveyRepository.getSurveyDetails(surveyId: surveyId))
          .thenAnswer((_) async => const SurveyModel.empty());

      final result = await useCase.call(submission);

      expect(result, isA<Success<bool>>());
    });

    test(
        'should return Failed with UseCaseException when repository call fails',
        () async {
      when(mockSurveyRepository.submitSurveyAnswer(submission: submission))
          .thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(submission);

      expect(result, isA<Failed<bool>>());
    });
  });
}
