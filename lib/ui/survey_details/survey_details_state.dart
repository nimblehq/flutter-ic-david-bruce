import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_ui_model.dart';

part 'survey_details_state.freezed.dart';

@freezed
class SurveyDetailsState with _$SurveyDetailsState {
  const factory SurveyDetailsState.init() = _Init;

  const factory SurveyDetailsState.loading() = _Loading;

  const factory SurveyDetailsState.success(SurveyDetailsUIModel uiModel) =
      _Success;

  const factory SurveyDetailsState.error(String errorMessage) = _Error;
}
