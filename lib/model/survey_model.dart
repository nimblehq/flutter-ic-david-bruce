import 'package:equatable/equatable.dart';

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
