import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_ui_model.dart';

part 'survey_model.g.dart';

@JsonSerializable()
class SurveyModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String thankEmailAboveThreshold;
  final String thankEmailBelowThreshold;
  final bool isActive;
  final String coverImageUrl;
  final String createdAt;
  final String activeAt;
  final String inactiveAt;
  final String surveyType;
  final List<SurveyQuestionModel> questions;

  const SurveyModel({
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

  const SurveyModel.empty()
      : this(
          id: '',
          title: '',
          description: '',
          thankEmailAboveThreshold: '',
          thankEmailBelowThreshold: '',
          isActive: false,
          coverImageUrl: '',
          createdAt: '',
          activeAt: '',
          inactiveAt: '',
          surveyType: '',
          questions: const [],
        );

  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);

  factory SurveyModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        thankEmailAboveThreshold,
        thankEmailBelowThreshold,
        isActive,
        coverImageUrl,
        createdAt,
        activeAt,
        inactiveAt,
        surveyType
      ];

  SurveyDetailsUIModel toSurveyDetailsUiModel() {
    final introSection = questions.isEmpty
        ? null
        : questions.firstWhere(
            (question) => question.displayType == DisplayType.intro);
    String description = '';
    String imageUrl = '';

    if (introSection != null) {
      description =
          introSection.text.isEmpty ? this.description : introSection.text;
      imageUrl = introSection.coverImageUrl.isEmpty
          ? introSection.imageUrl
          : introSection.coverImageUrl;
    }

    imageUrl = imageUrl.isEmpty ? coverImageUrl : imageUrl;
    return SurveyDetailsUIModel(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
