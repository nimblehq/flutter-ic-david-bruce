import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/refresh_token_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/refresh_token_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('RefreshTokenUseCaseTest', () {
    late MockAuthRepository mockAuthRepository;
    late MockStorage mockStorage;
    late RefreshTokenUseCase useCase;

    const refreshToken = 'refresh_token';

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockStorage = MockStorage();
      useCase = RefreshTokenUseCase(mockAuthRepository, mockStorage);
    });

    test('When refreshToken success, it returns success result', () async {
      when(mockAuthRepository.refreshToken(refreshToken: refreshToken))
          .thenAnswer((_) async {
        return const RefreshTokenModel(
            id: '1',
            tokenType: '2',
            accessToken: '3',
            expiresIn: 0.0,
            refreshToken: '4');
      });
      when(mockStorage.refreshToken).thenAnswer((_) {
        return Future.value(refreshToken);
      });

      final result = await useCase.call();

      expect(result, isA<Success<RefreshTokenModel>>());
      expect(
        verify(mockStorage.saveId(captureAny)).captured.single,
        '1',
      );
      expect(
        verify(mockStorage.saveTokenType(captureAny)).captured.single,
        '2',
      );
      expect(
        verify(mockStorage.saveAccessToken(captureAny)).captured.single,
        '3',
      );
      expect(
        verify(mockStorage.saveExpiresIn(captureAny)).captured.single,
        '0.0',
      );
      expect(
        verify(mockStorage.saveRefreshToken(captureAny)).captured.single,
        '4',
      );
    });

    test('When refreshToken failed, it returns failed result', () async {
      when(mockAuthRepository.refreshToken(refreshToken: refreshToken))
          .thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call();

      expect(result, isA<Failed<RefreshTokenModel>>());
      verifyNever(mockStorage.saveId(captureAny));
      verifyNever(mockStorage.saveId(captureAny));
      verifyNever(mockStorage.saveId(captureAny));
      verifyNever(mockStorage.saveId(captureAny));
      verifyNever(mockStorage.saveId(captureAny));
    });
  });
}
