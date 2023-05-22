import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/survey_submission_question_model.dart';

part 'survey_submission_model.g.dart';

@JsonSerializable()
class SurveySubmissionModel {
  final String surveyId;
  List<SurveySubmissionQuestionModel> questions;

  SurveySubmissionModel({
    required this.surveyId,
    required this.questions,
  });

  factory SurveySubmissionModel.fromJson(Map<String, dynamic> json) =>
      _$SurveySubmissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurveySubmissionModelToJson(this);

  Map<String, dynamic> toRequestJson() {
    return {
      'survey_id': surveyId,
      'questions':
          questions.map((question) => question.toRequestJson()).toList(),
    };
  }
}
