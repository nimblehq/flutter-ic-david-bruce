import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class SaveSurveySubmissionUseCase
    extends UseCase<bool, SurveySubmissionModel?> {
  final Storage _secureStorage;

  const SaveSurveySubmissionUseCase(
    this._secureStorage,
  );

  @override
  Future<Result<bool>> call(SurveySubmissionModel? params) async {
    if (params == null) {
      await _secureStorage.clearSurveySubmissionJson();
    } else {
      await _secureStorage
          .saveCurrentSurveySubmissionJson(jsonEncode(params.toJson()));
    }
    return Success(true);
  }
}
