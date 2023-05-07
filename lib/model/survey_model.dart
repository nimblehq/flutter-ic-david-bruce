import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';

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
}
