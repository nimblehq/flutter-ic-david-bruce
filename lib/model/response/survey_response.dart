import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/response/survey_question_response.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

import 'converter/response_converter.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  final String? id;
  final String? title;
  final String? description;
  final String? thankEmailAboveThreshold;
  final String? thankEmailBelowThreshold;
  final bool? isActive;
  final String? coverImageUrl;
  final String? createdAt;
  final String? activeAt;
  final String? inactiveAt;
  final String? surveyType;
  final List<SurveyQuestionResponse>? questions;

  SurveyResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.thankEmailAboveThreshold,
    required this.thankEmailBelowThreshold,
    required this.isActive,
    required this.coverImageUrl,
    required this.createdAt,
    required this.activeAt,
    required this.inactiveAt,
    required this.surveyType,
    required this.questions,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(mapDataJson(json));

  SurveyModel toSurveyModel() => SurveyModel(
        id: id ?? '',
        title: title ?? '',
        description: description ?? '',
        thankEmailAboveThreshold: thankEmailAboveThreshold ?? '',
        thankEmailBelowThreshold: thankEmailBelowThreshold ?? '',
        isActive: isActive ?? false,
        coverImageUrl: coverImageUrl ?? '',
        createdAt: createdAt ?? '',
        activeAt: activeAt ?? '',
        inactiveAt: inactiveAt ?? '',
        surveyType: surveyType ?? '',
        questions: (questions ?? [])
            .map((question) => question.toSurveyQuestionModel())
            .toList(),
      );
}
