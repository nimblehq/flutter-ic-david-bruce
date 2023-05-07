import 'package:equatable/equatable.dart';

class SurveyMetaModel extends Equatable {
  final int page;
  final int pages;
  final int pageSize;
  final int records;

  const SurveyMetaModel({
    required this.page,
    required this.pages,
    required this.pageSize,
    required this.records,
  });

  const SurveyMetaModel.empty()
      : this(
          page: 0,
          pages: 0,
          pageSize: 0,
          records: 0,
        );

  @override
  List<Object?> get props => [
        page,
        pages,
        pageSize,
        records,
      ];
}
