import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/survey_answer_model.dart';

import 'converter/response_converter.dart';

part 'survey_answer_response.g.dart';

@JsonSerializable()
class SurveyAnswerResponse {
  final String id;
  final String? text;
  final int? displayOrder;

  SurveyAnswerResponse({
    required this.id,
    required this.text,
    required this.displayOrder,
  });

  factory SurveyAnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyAnswerResponseFromJson(mapDataJson(json));

  SurveyAnswerModel toSurveyAnswerModel() => SurveyAnswerModel(
        id: id,
        text: text ?? '',
        displayOrder: displayOrder ?? 0,
      );
}
