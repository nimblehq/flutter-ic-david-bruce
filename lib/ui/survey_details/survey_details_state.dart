import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

part 'survey_details_state.freezed.dart';

@freezed
class SurveyDetailsState with _$SurveyDetailsState {
  const factory SurveyDetailsState.init() = _Init;

  const factory SurveyDetailsState.loading() = _Loading;

  const factory SurveyDetailsState.success(SurveyModel survey) = _Success;

  const factory SurveyDetailsState.error(String errorMessage) = _Error;
}
