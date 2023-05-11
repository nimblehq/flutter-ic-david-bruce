import 'package:equatable/equatable.dart';

class SurveyAnswerOptionUIModel extends Equatable {
  final int index;
  final String id;
  final String title;

  const SurveyAnswerOptionUIModel({
    required this.index,
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [
        index,
        id,
        title,
      ];
}
