import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';

class SurveyAnswerUIModel extends Equatable {
  final DisplayType displayType;
  final List<SurveyAnswerOptionUIModel> options;

  const SurveyAnswerUIModel({
    required this.displayType,
    required this.options,
  });

  SurveyAnswerUIModel.empty()
      : this(
          displayType: DisplayType.unknown,
          options: [],
        );

  @override
  List<Object?> get props => [
        displayType,
        options,
      ];
}

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
