import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/model/login_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/params/login_params.dart';

@Injectable()
class LoginUseCase extends UseCase<LoginModel, LoginParams> {
  final AuthRepository _repository;
  final Storage _storage;

  const LoginUseCase(this._repository, this._storage);

  @override
  Future<Result<LoginModel>> call(LoginParams params) async {
    try {
      final result = await _repository.login(
        email: params.email,
        password: params.password,
      );
      await _storeTokens(result);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }

  Future<Result<LoginModel>> _storeTokens(LoginModel login) async {
    try {
      await _storage.saveId(login.id);
      await _storage.saveAccessToken(login.accessToken);
      await _storage.saveExpiresIn('${login.expiresIn}');
      await _storage.saveRefreshToken(login.refreshToken);
      return Success(login);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
