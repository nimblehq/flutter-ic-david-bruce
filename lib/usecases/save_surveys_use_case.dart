import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';

import '../api/repository/survey_repository.dart';
import 'base/base_use_case.dart';

@Injectable()
class SaveSurveysUseCase extends UseCase<void, SurveysModel> {
  final SurveyRepository _repository;

  const SaveSurveysUseCase(this._repository);

  @override
  Future<Result<void>> call(SurveysModel params) async {
    try {
      final result = await _repository.saveSurveys(surveys: params);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
