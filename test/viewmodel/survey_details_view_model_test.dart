import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_screen.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_state.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_view_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Survey details view model test', () {
    late MockGetSurveyDetailsUseCase mockGetSurveyDetailsUseCase;
    late ProviderContainer container;

    setUp(() {
      mockGetSurveyDetailsUseCase = MockGetSurveyDetailsUseCase();
      container = ProviderContainer(
        overrides: [
          surveyDetailsViewModelProvider.overrideWith(
              (ref) => SurveyDetailsViewModel(mockGetSurveyDetailsUseCase)),
        ],
      );
      addTearDown(container.dispose);
    });

    test('Should set state to ubut when viewModel is initialized', () {
      expect(container.read(surveyDetailsViewModelProvider),
          const SurveyDetailsState.init());
    });

    test('Should set state to success when getSurveyDetails succeeds', () {
      const survey = SurveyModel.empty();
      when(mockGetSurveyDetailsUseCase.call(any))
          .thenAnswer((_) async => Success(survey));
      final stateStream =
          container.read(surveyDetailsViewModelProvider.notifier).stream;
      expect(
          stateStream,
          emitsAnyOf([
            const SurveyDetailsState.loading(),
            SurveyDetailsState.success(
                SurveyDetailsUIModel(title: '', description: '', imageUrl: '')),
          ]));
      container
          .read(surveyDetailsViewModelProvider.notifier)
          .getSurveyDetails('');
    });

    test(
        'When calling getSurveyDetails return failed exception, it returns error state',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.unauthorisedRequest());
      when(mockGetSurveyDetailsUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(surveyDetailsViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            const SurveyDetailsState.loading(),
            SurveyDetailsState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.unauthorisedRequest(),
              ),
            ),
          ],
        ),
      );
      container
          .read(surveyDetailsViewModelProvider.notifier)
          .getSurveyDetails('');
    });
  });
}
