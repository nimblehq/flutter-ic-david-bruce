import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_screen.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_state.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_view_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Survey details view model test', () {
    late MockGetSurveyDetailsUseCase mockGetSurveyDetailsUseCase;
    late MockSaveCurrentSurveyUseCase mockSaveCurrentSurveyUseCase;
    late ProviderContainer container;

    setUp(() {
      mockGetSurveyDetailsUseCase = MockGetSurveyDetailsUseCase();
      mockSaveCurrentSurveyUseCase = MockSaveCurrentSurveyUseCase();
      container = ProviderContainer(
        overrides: [
          surveyDetailsViewModelProvider
              .overrideWith((ref) => SurveyDetailsViewModel(
                    mockGetSurveyDetailsUseCase,
                    mockSaveCurrentSurveyUseCase,
                  )),
        ],
      );
      addTearDown(container.dispose);
    });

    test('Should set state to init when viewModel is initialized', () {
      expect(container.read(surveyDetailsViewModelProvider),
          const SurveyDetailsState.init());
    });

    test('Should set state to error when getSurveyDetails fails', () {
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
