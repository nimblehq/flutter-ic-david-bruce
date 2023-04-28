import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_state.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_survey_details_use_case.dart';

class SurveyDetailsViewModel extends StateNotifier<SurveyDetailsState> {
  SurveyDetailsViewModel(this._getSurveyDetailsUseCase)
      : super(const SurveyDetailsState.init());

  final GetSurveyDetailsUseCase _getSurveyDetailsUseCase;

  void getSurveyDetails(String id) async {
    Future.delayed(
      const Duration(milliseconds: 100),
      () => state = const SurveyDetailsState.loading(),
    );
    state = const SurveyDetailsState.loading();
    Result<void> result = await _getSurveyDetailsUseCase.call(id);
    if (result is Success) {
      state = SurveyDetailsState.success(result.value);
    } else {
      state = SurveyDetailsState.error(
        NetworkExceptions.getErrorMessage(
            (result as Failed).exception.actualException),
      );
    }
  }
}
