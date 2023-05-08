import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_ui_model.dart';

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
    final introSection = questions
        .firstWhere((question) => question.displayType == DisplayType.intro);
    final description =
        introSection.text.isEmpty ? this.description : introSection.text;
    String imageUrl = introSection.imageUrl.isEmpty
        ? introSection.coverImageUrl
        : introSection.imageUrl;
    imageUrl = imageUrl.isEmpty ? coverImageUrl : imageUrl;
    return SurveyDetailsUIModel(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
