import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'base/base_use_case.dart';

@Injectable()
class GetCurrentSurveyUseCase extends NoParamsUseCase<SurveyModel?> {
  final SurveyRepository _repository;

  const GetCurrentSurveyUseCase(this._repository);

  @override
  Future<Result<SurveyModel?>> call() async {
    try {
      final result = await _repository.getCurrentSurvey();
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
