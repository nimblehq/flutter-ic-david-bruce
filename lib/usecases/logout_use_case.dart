import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'base/base_use_case.dart';

@Injectable()
class LogoutUseCase extends NoParamsUseCase<void> {
  final AuthRepository _repository;

  const LogoutUseCase(this._repository);

  @override
  Future<Result<void>> call() async {
    final result = await _repository.logout();
    return Success(result);
  }
}
