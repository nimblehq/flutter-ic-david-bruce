import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_submission_answer_model.g.dart';

@JsonSerializable()
class SurveySubmissionAnswerModel {
  final String id;
  final String? answer;

  SurveySubmissionAnswerModel({
    required this.id,
    required this.answer,
  });

  Map<String, dynamic> toJson() => _$SurveySubmissionAnswerModelToJson(this);

  factory SurveySubmissionAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$SurveySubmissionAnswerModelFromJson(json);

  Map<String, dynamic> toRequestJson() {
    Map<String, dynamic> json = {'id': id};
    if (answer != null) {
      json['answer'] = answer;
    }
    return json;
  }
}
