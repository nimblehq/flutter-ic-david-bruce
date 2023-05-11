import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class GetSurveySubmissionUseCase
    extends NoParamsUseCase<SurveySubmissionModel?> {
  final Storage _secureStorage;

  const GetSurveySubmissionUseCase(
    this._secureStorage,
  );

  @override
  Future<Result<SurveySubmissionModel?>> call() async {
    final json = await _secureStorage.currentSurveySubmissionJson;
    if (json == null) {
      return Success(null);
    }
    dynamic jsonMap = jsonDecode(json);
    if (jsonMap is Map<String, dynamic>) {
      return Success(SurveySubmissionModel.fromJson(jsonMap));
    } else {
      return Failed(UseCaseException('JSON wrong format'));
    }
  }
}
