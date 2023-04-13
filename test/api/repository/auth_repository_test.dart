import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('CredentialRepository', () {
    MockApiService mockApiService = MockApiService();
    late AuthRepository repository;

    setUp(() {
      repository = AuthRepositoryImpl(mockApiService);
    });
    // test(
    //     "When getting user list successfully, it emits corresponding user list",
    //     () async {
    //   when(mockApiService.getUsers()).thenAnswer((_) async => [
    //         UserResponse('test@email.com', 'test_user'),
    //       ]);
    //
    //   final result = await repository.getUsers();
    //   expect(result.length, 1);
    //   expect(result[0].email, 'test@email.com');
    //   expect(result[0].username, 'test_user');
    // });

    // test("When getting user list failed, it returns NetworkExceptions error",
    //     () async {
    //   when(mockApiService.getUsers()).thenThrow(MockDioError());
    //
    //   expect(
    //     () => repository.getUsers(),
    //     throwsA(isA<NetworkExceptions>()),
    //   );
    // });
  });
}
