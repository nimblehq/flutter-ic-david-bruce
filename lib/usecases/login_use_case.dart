import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/model/login_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/params/login_params.dart';

@Injectable()
class LoginUseCase extends UseCase<LoginModel, LoginParams> {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  @override
  Future<Result<LoginModel>> call(LoginParams params) async {
    try {
      final result = await _repository.login(
        email: params.email,
        password: params.password,
      );
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
