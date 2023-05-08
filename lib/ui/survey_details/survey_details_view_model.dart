import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_state.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_survey_details_use_case.dart';

class SurveyDetailsViewModel extends StateNotifier<SurveyDetailsState> {
  SurveyDetailsViewModel(this._getSurveyDetailsUseCase)
      : super(const SurveyDetailsState.init());

  final GetSurveyDetailsUseCase _getSurveyDetailsUseCase;

  void getSurveyDetails(String id) async {
    state = const SurveyDetailsState.loading();
    final result = await _getSurveyDetailsUseCase.call(id);
    if (result is Success<SurveyModel>) {
      _bindData(result.value);
    } else {
      state = SurveyDetailsState.error(
        NetworkExceptions.getErrorMessage(
            (result as Failed).exception.actualException),
      );
    }
  }

  void _bindData(SurveyModel survey) {
    state = SurveyDetailsState.success(survey.toSurveyDetailsUiModel());
  }
}
