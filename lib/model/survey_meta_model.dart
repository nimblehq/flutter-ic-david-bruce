import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_meta_model.g.dart';

@JsonSerializable()
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

  factory SurveysMetaModel.fromJson(Map<String, dynamic> json) =>
      _$SurveysMetaModelFromJson(mapDataJson(json));

  Map<String, dynamic> toJson() => _$SurveysMetaModelToJson(this);

  @override
  List<Object?> get props => [
        page,
        pages,
        pageSize,
        records,
      ];
}
