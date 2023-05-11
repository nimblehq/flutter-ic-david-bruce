import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_answer_model.g.dart';

@JsonSerializable()
class SurveyAnswerModel extends Equatable {
  final String id;
  final String text;
  final int displayOrder;

  const SurveyAnswerModel({
    required this.id,
    required this.text,
    required this.displayOrder,
  });

  Map<String, dynamic> toJson() => _$SurveyAnswerModelToJson(this);

  factory SurveyAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyAnswerModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        text,
        displayOrder,
      ];
}
