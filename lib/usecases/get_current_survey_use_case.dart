import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

import 'base/base_use_case.dart';

@Injectable()
class GetCurrentSurveyUseCase extends NoParamsUseCase<SurveyModel?> {
  final Storage _storage;

  const GetCurrentSurveyUseCase(this._storage);

  @override
  Future<Result<SurveyModel?>> call() async {
    try {
      final result = await _storage.currentSurveyJson;
      if (result == null) {
        return Success(null);
      }
      dynamic json = jsonDecode(result);
      if (json is Map<String, dynamic>) {
        return Success(SurveyModel.fromJson(json));
      } else {
        return Failed(UseCaseException('Invalid JSON'));
      }
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
