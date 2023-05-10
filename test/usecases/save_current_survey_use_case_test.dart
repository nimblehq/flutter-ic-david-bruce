import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/save_current_survey_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SaveCurrentSurveyUseCase', () {
    late MockStorage storage;
    late SaveCurrentSurveyUseCase useCase;

    setUp(() {
      storage = MockStorage();
      useCase = SaveCurrentSurveyUseCase(
        storage,
      );
    });

    test('When save current survey, it returns success result', () async {
      final result = await useCase.call(const SurveyModel.empty());
      expect(result, isA<Success>());
      verify(storage.saveCurrentSurveyJson(captureAny)).called(1);
    });
  });
}
