import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'base/base_use_case.dart';

@Injectable()
class LogoutUseCse extends NoParamsUseCase<void> {
  final AuthRepository _repository;

  const LogoutUseCse(this._repository);

  @override
  Future<Result<void>> call() async {
    final result = await _repository.logout();
    return Success(result);
  }
}
