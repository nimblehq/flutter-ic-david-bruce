import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/user_repository.dart';
import 'package:survey_flutter_ic/model/user_model.dart';
import 'base/base_use_case.dart';

@Injectable()
class GetUserProfileUseCase extends NoParamsUseCase<UserModel> {
  final UserRepository _repository;

  const GetUserProfileUseCase(this._repository);

  @override
  Future<Result<UserModel>> call() async {
    try {
      final result = await _repository.getUserProfile();
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
