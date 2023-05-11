import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class ForgotPasswordUseCase extends UseCase<String, String> {
  final AuthRepository _repository;

  const ForgotPasswordUseCase(this._repository);

  @override
  Future<Result<String>> call(String params) async {
    try {
      final result = await _repository.forgotPassword(email: params);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
