import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

import 'base/base_use_case.dart';

@Injectable()
class GetSurveyDetailsUseCase extends UseCase<SurveyModel, String> {
  final SurveyRepository _repository;

  const GetSurveyDetailsUseCase(this._repository);

  @override
  Future<Result<SurveyModel>> call(params) async {
    try {
      final result = await _repository.getSurveyDetails(surveyId: params);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
