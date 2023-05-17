import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/service/api_service.dart';
import 'package:survey_flutter_ic/model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> getUserProfile();
}

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final ApiService _apiService;

  UserRepositoryImpl(this._apiService);

  @override
  Future<UserModel> getUserProfile() async {
    try {
      final result = await _apiService.getUserProfile();
      return result.toModel();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
