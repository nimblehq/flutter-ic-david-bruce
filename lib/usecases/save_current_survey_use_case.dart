import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'base/base_use_case.dart';

@Injectable()
class SaveCurrentSurveyUseCase extends UseCase<bool, SurveyModel> {
  final Storage _storage;

  const SaveCurrentSurveyUseCase(this._storage);

  @override
  Future<Result<bool>> call(params) async {
    await _storage.saveCurrentSurveyJson(jsonEncode(params.toJson()));
    return Success(true);
  }
}
