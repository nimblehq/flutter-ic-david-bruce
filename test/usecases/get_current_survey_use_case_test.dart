import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_current_survey_use_case.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetCurrentSurveyUseCase', () {
    late MockStorage storage;
    late GetCurrentSurveyUseCase useCase;

    setUp(() {
      storage = MockStorage();
      useCase = GetCurrentSurveyUseCase(
        storage,
      );
    });

    test('When get current survey, it returns success result', () async {
      when(storage.currentSurveyJson).thenAnswer(
        (_) async => jsonEncode(const SurveyModel.empty().toJson()),
      );
      final result = await useCase.call();
      expect(result, isA<Success>());
    });

    test('When get current survey as null, it returns success result',
        () async {
      when(storage.currentSurveyJson).thenAnswer(
        (_) async => null,
      );
      final result = await useCase.call();
      expect(result, isA<Success>());
    });
  });
}
