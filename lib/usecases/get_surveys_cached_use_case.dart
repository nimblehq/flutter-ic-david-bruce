import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';

import 'base/base_use_case.dart';

@Injectable()
class GetSurveysCachedUseCase extends NoParamsUseCase<SurveysModel> {
  final SurveyRepository _repository;

  const GetSurveysCachedUseCase(this._repository);

  @override
  Future<Result<SurveysModel>> call() async {
    try {
      final result = await _repository.getSurveysCached();
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
