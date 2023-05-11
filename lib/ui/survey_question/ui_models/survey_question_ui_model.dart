import 'package:equatable/equatable.dart';

class SurveyQuestionUIModel extends Equatable {
  final int questionIndex;
  final int totalQuestions;
  final String title;

  String get currentIndexPerTotal => '$questionIndex/$totalQuestions';

  const SurveyQuestionUIModel({
    required this.questionIndex,
    required this.totalQuestions,
    required this.title,
  });

  const SurveyQuestionUIModel.empty()
      : this(
          questionIndex: 0,
          totalQuestions: 0,
          title: '',
        );

  @override
  List<Object?> get props => [
        questionIndex,
        totalQuestions,
        title,
      ];
}
