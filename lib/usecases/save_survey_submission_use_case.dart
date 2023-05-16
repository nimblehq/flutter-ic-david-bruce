import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class SaveSurveySubmissionUseCase
    extends UseCase<void, SurveySubmissionModel?> {
  final SurveyRepository _repository;

  const SaveSurveySubmissionUseCase(
    this._repository,
  );

  @override
  Future<Result<void>> call(SurveySubmissionModel? params) async {
    final result = await _repository.saveSurveySubmission(survey: params);
    return Success(result);
  }
}
