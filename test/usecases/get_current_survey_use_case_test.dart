import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_current_survey_use_case.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetCurrentSurveyUseCase', () {
    late MockSurveyRepository mockSurveyRepository;
    late GetCurrentSurveyUseCase useCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = GetCurrentSurveyUseCase(
        mockSurveyRepository,
      );
    });

    test('should return Success with SurveyModel when repository call succeeds',
        () async {
      when(mockSurveyRepository.getCurrentSurvey())
          .thenAnswer((_) async => const SurveyModel.empty());

      final result = await useCase.call();

      expect(result, isA<Success<SurveyModel?>>());
    });

    test('should return Success with Null when repository call succeeds',
        () async {
      when(mockSurveyRepository.getCurrentSurvey())
          .thenAnswer((_) async => null);

      final result = await useCase.call();

      expect(result, isA<Success<SurveyModel?>>());
    });
  });
}
