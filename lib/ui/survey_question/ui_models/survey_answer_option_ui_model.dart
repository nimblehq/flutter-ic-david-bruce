import 'package:equatable/equatable.dart';

class SurveyAnswerOptionUIModel extends Equatable {
  final int index;
  final String id;
  final String title;
  final String shortText;

  const SurveyAnswerOptionUIModel({
    required this.index,
    required this.id,
    required this.title,
    required this.shortText,
  });

  @override
  List<Object?> get props => [
        index,
        id,
        title,
        shortText,
      ];
}
