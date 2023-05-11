import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'base/base_use_case.dart';

@Injectable()
class SaveCurrentSurveyUseCase extends UseCase<bool, SurveyModel> {
  final SurveyRepository _repository;

  const SaveCurrentSurveyUseCase(this._repository);

  @override
  Future<Result<bool>> call(params) async {
    await _repository.saveCurrentSurvey(survey: params);
    return Success(true);
  }
}
