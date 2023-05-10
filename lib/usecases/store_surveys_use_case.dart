import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';

import '../api/repository/survey_repository.dart';
import 'base/base_use_case.dart';

@Injectable()
class FetchSurveysUseCase extends UseCase<Void, SurveysModel> {
  final SurveyRepository _repository;

  const FetchSurveysUseCase(this._repository);

  @override
  Future<Result<SurveysModel>> call(SurveysParams params) async {
    try {
      final result = await _repository.fetchSurveys(
          pageNumber: params.pageNumber, pageSize: params.pageSize);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
