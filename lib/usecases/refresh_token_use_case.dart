import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/model/refresh_token_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class RefreshTokenUseCase extends NoParamsUseCase<RefreshTokenModel> {
  final AuthRepository _repository;
  final Storage _storage;

  const RefreshTokenUseCase(this._repository, this._storage);

  @override
  Future<Result<RefreshTokenModel>> call() async {
    try {
      final refreshToken = await _storage.refreshToken ?? '';
      final result = await _repository.refreshToken(refreshToken: refreshToken);
      return await _storeTokens(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }

  Future<Result<RefreshTokenModel>> _storeTokens(
      RefreshTokenModel refreshToken) async {
    try {
      await _storage.saveId(refreshToken.id);
      await _storage.saveTokenType(refreshToken.tokenType);
      await _storage.saveAccessToken(refreshToken.accessToken);
      await _storage.saveExpiresIn('${refreshToken.expiresIn}');
      await _storage.saveRefreshToken(refreshToken.refreshToken);
      return Success(refreshToken);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
