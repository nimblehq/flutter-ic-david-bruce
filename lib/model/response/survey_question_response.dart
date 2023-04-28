import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/response/survey_answer_response.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';

import 'converter/response_converter.dart';

part 'survey_question_response.g.dart';

@JsonSerializable()
class SurveyQuestionResponse {
  final String id;
  final String text;
  final int displayOrder;
  final String imageUrl;
  final String coverImageUrl;
  final DisplayType displayType;
  final List<SurveyAnswerResponse>? answers;

  SurveyQuestionResponse({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.imageUrl,
    required this.coverImageUrl,
    required this.displayType,
    required this.answers,
  });

  factory SurveyQuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionResponseFromJson(mapDataJson(json));

  SurveyQuestionModel toSurveyQuestionModel() => SurveyQuestionModel(
        id: id,
        text: text,
        displayOrder: displayOrder,
        imageUrl: imageUrl,
        coverImageUrl: coverImageUrl,
        displayType: displayType,
        answers: (answers ?? [])
            .map((answer) => answer.toSurveyAnswerModel())
            .toList(),
      );
}
