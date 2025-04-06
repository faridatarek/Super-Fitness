import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/register/data/contracts/register_online_datasource.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/data/repos/register_repo_impl.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';

@GenerateMocks([RegisterOnlineDataSource])
import 'register_repo_impl_test.mocks.dart';

void main() {
  late RegisterRepoImpl registerRepoImpl;
  late MockRegisterOnlineDataSource mockRegisterOnlineDataSource;

  setUp(() {
    mockRegisterOnlineDataSource = MockRegisterOnlineDataSource();
    registerRepoImpl = RegisterRepoImpl(mockRegisterOnlineDataSource);

    // Provide dummy values for Result<RegisterResponseEntity?>
    provideDummy<Result<RegisterResponseEntity?>>(
      Success(
        RegisterResponseEntity(
          message: "Dummy message",
          user: User(
            id: "dummy_id",
            firstName: "Dummy",
            lastName: "User",
            email: "dummy@example.com",
          ),
          token: "dummy_token",
        ),
      ),
    );

    // Provide dummy value for RegisterResponseEntity
    provideDummy<RegisterResponseEntity>(
      RegisterResponseEntity(
        message: "Dummy entity",
        user: User(
          id: "dummy_entity_id",
          firstName: "Entity",
          lastName: "Dummy",
          email: "entity@example.com",
        ),
        token: "dummy_entity_token",
      ),
    );
  });

  group('RegisterRepoImpl Tests', () {
    final registerRequest = RegisterRequest(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      password: 'password123',
      rePassword: 'password123',
      gender: 'male',
      height: 180,
      weight: 75,
      age: 30,
      goal: 'build_muscle',
      activityLevel: 'active',
    );

    final successResponse = RegisterResponseEntity(
      message: 'Registration successful',
      user: User(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      ),
      token: 'valid_token',
    );

    test('register success on RegisterOnlineDataSource', () async {
      // Arrange
      when(mockRegisterOnlineDataSource.register(registerRequest))
          .thenAnswer((_) async => Success(successResponse));

      // Act
      final result = await registerRepoImpl.register(registerRequest);

      // Assert
      expect(result, isA<Success<RegisterResponseEntity?>>());
      expect((result as Success).data, successResponse);
      verify(mockRegisterOnlineDataSource.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockRegisterOnlineDataSource);
    });

    test('register failure on RegisterOnlineDataSource', () async {
      // Arrange
      final exception = Exception('Registration failed');
      when(mockRegisterOnlineDataSource.register(registerRequest))
          .thenAnswer((_) async => Fail(exception));

      // Act
      final result = await registerRepoImpl.register(registerRequest);

      // Assert
      expect(result, isA<Fail<RegisterResponseEntity?>>());
      final failResult = result as Fail<RegisterResponseEntity?>;
      expect(failResult.exception, isA<Exception>());
      expect(failResult.exception.toString(), contains('Registration failed'));

      verify(mockRegisterOnlineDataSource.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockRegisterOnlineDataSource);
    });

    test('register returns null response from RegisterOnlineDataSource',
        () async {
      // Arrange
      when(mockRegisterOnlineDataSource.register(registerRequest))
          .thenAnswer((_) async => Success(null));

      // Act
      final result = await registerRepoImpl.register(registerRequest);

      // Assert
      expect(result, isA<Success<RegisterResponseEntity?>>());
      expect((result as Success).data, isNull);
      verify(mockRegisterOnlineDataSource.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockRegisterOnlineDataSource);
    });
  });
}
