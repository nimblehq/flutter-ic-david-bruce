import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class GetSurveySubmissionUseCase
    extends NoParamsUseCase<SurveySubmissionModel?> {
  final SurveyRepository _repository;

  const GetSurveySubmissionUseCase(
    this._repository,
  );

  @override
  Future<Result<SurveySubmissionModel?>> call() async {
    try {
      final result = await _repository.getSurveySubmission();
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
