import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';
import 'base/base_use_case.dart';

@Injectable()
class SubmitSurveyAnswerUseCase extends UseCase<bool, SurveySubmissionModel> {
  final SurveyRepository _repository;

  const SubmitSurveyAnswerUseCase(this._repository);

  @override
  Future<Result<bool>> call(SurveySubmissionModel params) async {
    try {
      final result = await _repository.submitSurveyAnswer(submission: params);
      return Success(true);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
