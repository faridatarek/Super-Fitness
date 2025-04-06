import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/network/api_manager.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/register/data/data_sources/register_online_datasource_impl.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/data/models/response/register_response/register_response.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';

@GenerateMocks([ApiManager])
import 'register_online_datasource_impl_test.mocks.dart';

void main() {
  late RegisterOnlineDatasourceImpl registerOnlineDatasource;
  late MockApiManager mockApiManager;

  setUp(() {
    mockApiManager = MockApiManager();
    registerOnlineDatasource = RegisterOnlineDatasourceImpl(mockApiManager);

    // Provide dummy values
    provideDummy<RegisterResponse>(
      RegisterResponse(
        message: "Dummy message",
        user: User(
          id: "dummy_id",
          firstName: "Dummy",
          lastName: "User",
          email: "dummy@example.com",
        ),
        token: "dummy_token",
      ),
    );

    provideDummy<Result<RegisterResponseEntity?>>(
      Success(
        RegisterResponseEntity(
          message: "Dummy success",
          user: User(
            id: "dummy_entity_id",
            firstName: "Entity",
            lastName: "Dummy",
            email: "entity@example.com",
          ),
          token: "dummy_entity_token",
        ),
      ),
    );
  });

  group('RegisterOnlineDatasourceImpl Tests', () {
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

    final mockUser = User(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
    );

    final mockRegisterResponse = RegisterResponse(
      message: 'Registration successful',
      user: mockUser,
      token: 'valid_token',
    );

    test('register success on ApiManager', () async {
      // Arrange
      when(mockApiManager.register(registerRequest))
          .thenAnswer((_) async => mockRegisterResponse);

      // Act
      final result = await registerOnlineDatasource.register(registerRequest);

      // Assert
      expect(result, isA<Success<RegisterResponseEntity?>>());

      final successResult = result as Success<RegisterResponseEntity?>;
      expect(successResult.data?.message, 'Registration successful');
      expect(successResult.data?.user?.email, 'john.doe@example.com');
      expect(successResult.data?.token, 'valid_token');

      verify(mockApiManager.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockApiManager);
    });

    test('register failure on ApiManager throws exception', () async {
      // Arrange
      when(mockApiManager.register(registerRequest))
          .thenThrow(Exception('Registration failed'));

      // Act
      final result = await registerOnlineDatasource.register(registerRequest);

      // Assert
      expect(result, isA<Fail<RegisterResponseEntity?>>());
      verify(mockApiManager.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockApiManager);
    });

    test('register handles partial response (null user)', () async {
      // Arrange
      final partialResponse = RegisterResponse(
        message: 'Registration successful',
        user: null,
        token: 'valid_token',
      );

      when(mockApiManager.register(registerRequest))
          .thenAnswer((_) async => partialResponse);

      // Act
      final result = await registerOnlineDatasource.register(registerRequest);

      // Assert
      expect(result, isA<Success<RegisterResponseEntity?>>());

      final successResult = result as Success<RegisterResponseEntity?>;
      expect(successResult.data?.message, 'Registration successful');
      expect(successResult.data?.user, isNull);
      expect(successResult.data?.token, 'valid_token');

      verify(mockApiManager.register(registerRequest)).called(1);
      verifyNoMoreInteractions(mockApiManager);
    });
  });
}
