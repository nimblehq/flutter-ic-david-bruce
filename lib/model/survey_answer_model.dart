import 'package:equatable/equatable.dart';

class SurveyAnswerModel extends Equatable {
  final String id;
  final String text;
  final int displayOrder;

  const SurveyAnswerModel({
    required this.id,
    required this.text,
    required this.displayOrder,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        displayOrder,
      ];
}
