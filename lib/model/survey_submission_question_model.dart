import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/survey_submission_answer_model.dart';

part 'survey_submission_question_model.g.dart';

@JsonSerializable()
class SurveySubmissionQuestionModel {
  final String id;
  final List<SurveySubmissionAnswerModel> answers;

  SurveySubmissionQuestionModel({
    required this.id,
    required this.answers,
  });

  Map<String, dynamic> toJson() => _$SurveySubmissionQuestionModelToJson(this);

  factory SurveySubmissionQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$SurveySubmissionQuestionModelFromJson(json);

  Map<String, dynamic> toRequestJson() {
    return {
      'id': id,
      'answers': answers.map((answer) => answer.toRequestJson()).toList(),
    };
  }
}
