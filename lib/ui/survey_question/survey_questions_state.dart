import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_questions_ui_model.dart';

part 'survey_questions_state.freezed.dart';

@freezed
class SurveyQuestionsState with _$SurveyQuestionsState {
  const factory SurveyQuestionsState.init() = _Init;

  const factory SurveyQuestionsState.submitting() = _Submitting;

  const factory SurveyQuestionsState.submitted() = _Submitted;

  const factory SurveyQuestionsState.error({required String? error}) = _Error;

  const factory SurveyQuestionsState.success({
    required SurveyQuestionsUIModel uiModel,
    required String coverImageUrl,
  }) = _Success;
}
