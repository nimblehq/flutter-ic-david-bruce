import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/survey_answer_model.dart';

class SurveyQuestionModel extends Equatable {
  final String id;
  final String text;
  final int displayOrder;
  final String imageUrl;
  final String coverImageUrl;
  final DisplayType displayType;
  final List<SurveyAnswerModel> answers;

  const SurveyQuestionModel({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.imageUrl,
    required this.coverImageUrl,
    required this.displayType,
    required this.answers,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        displayOrder,
        imageUrl,
        coverImageUrl,
        displayType,
        answers,
      ];
}
