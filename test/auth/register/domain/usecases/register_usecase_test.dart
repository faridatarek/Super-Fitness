import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';
import 'package:super_fitness/features/auth/register/domain/repos/register_repo.dart';
import 'package:super_fitness/features/auth/register/domain/usecases/register_usecase.dart';

import 'register_usecase_test.mocks.dart';

@GenerateMocks([RegisterRepo])
void main() {
  late RegisterUsecase registerUsecase;
  late MockRegisterRepo mockRegisterRepo;

  setUp(() {
    mockRegisterRepo = MockRegisterRepo();
    registerUsecase = RegisterUsecase(mockRegisterRepo);

    // Provide a dummy result for the register response
    provideDummy<Result<RegisterResponseEntity?>>(
      Success(
        RegisterResponseEntity(
          message: "Dummy message",
          user: User(
            id: "1",
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
          ),
          token: "dummy_token",
        ),
      ),
    );
  });

  group('RegisterUsecase Tests', () {
    test('register success on RegisterRepo', () async {
      // Arrange
      final registerRequest = RegisterRequest(
          // Add required fields for RegisterRequest here
          );
      final expectedUser = User(
        id: "1",
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
      );
      final expectedResponse = RegisterResponseEntity(
        message: "Registration successful",
        user: expectedUser,
        token: "valid_token",
      );
      final expectedResult = Success(expectedResponse);

      when(mockRegisterRepo.register(registerRequest))
          .thenAnswer((_) async => expectedResult);

      // Act
      final result = await registerUsecase.register(registerRequest);

      // Assert
      expect(result, expectedResult);
      verify(mockRegisterRepo.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockRegisterRepo);
    });

    test('register failure on RegisterRepo', () async {
      // Arrange
      final registerRequest = RegisterRequest(
          // Add required fields for RegisterRequest here
          );
      final expectedError =
          Fail<RegisterResponseEntity?>(Exception('Registration failed'));

      when(mockRegisterRepo.register(registerRequest))
          .thenAnswer((_) async => expectedError);

      // Act
      final result = await registerUsecase.register(registerRequest);

      // Assert
      expect(result, expectedError);
      verify(mockRegisterRepo.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockRegisterRepo);
    });

    test('register returns null response on success', () async {
      // Arrange
      final registerRequest = RegisterRequest(
          // Add required fields for RegisterRequest here
          );
      final expectedResult = Success<RegisterResponseEntity?>(null);

      when(mockRegisterRepo.register(registerRequest))
          .thenAnswer((_) async => expectedResult);

      // Act
      final result = await registerUsecase.register(registerRequest);

      // Assert
      expect(result, expectedResult);
      verify(mockRegisterRepo.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockRegisterRepo);
    });
  });
}
