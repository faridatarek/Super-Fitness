import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';
import 'package:super_fitness/features/auth/register/domain/usecases/register_usecase.dart';
import 'package:super_fitness/features/base/base_states.dart';

import 'register_cubit_test.mocks.dart';

@GenerateMocks([RegisterUsecase])
void main() {
  late RegisterCubit registerCubit;
  late MockRegisterUsecase mockRegisterUsecase;

  setUp(() {
    mockRegisterUsecase = MockRegisterUsecase();
    registerCubit = RegisterCubit(mockRegisterUsecase);
    provideDummy<Result<RegisterResponseEntity?>>(
      Success<RegisterResponseEntity?>(
        RegisterResponseEntity(
          message: "Dummy message",
          user: User(
            id: "1",
            firstName: "Dummy",
            lastName: "User",
            email: "dummy@example.com",
          ),
          token: "dummy_token",
        ),
      ),
    );
    provideDummy<Result<RegisterResponseEntity?>>(
      Fail<RegisterResponseEntity?>(Exception("Dummy error")),
    );
  });

  tearDown(() {
    registerCubit.close();
  });

  group('RegisterCubit initialization', () {
    test('initial state is RegisterStep.initial', () {
      registerCubit.start();
      expect(registerCubit.state, isA<RegisterState>());
      expect((registerCubit.state as RegisterState).step, RegisterStep.initial);
      expect((registerCubit.state as RegisterState).userData, isEmpty);
    });
  });

  group('Step navigation', () {
    test('nextStep progresses through all steps correctly', () async {
      registerCubit.start();

      when(mockRegisterUsecase.register(any)).thenAnswer(
        (_) async => Success<RegisterResponseEntity?>(
          RegisterResponseEntity(
            message: 'Success',
            user: User(),
            token: 'token',
          ),
        ),
      );

      registerCubit.nextStep();
      expect(registerCubit.state, isA<RegisterState>());
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.ageSelection);

      registerCubit.nextStep();
      expect(registerCubit.state, isA<RegisterState>());
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.weightSelection);

      registerCubit.nextStep();
      expect(registerCubit.state, isA<RegisterState>());
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.heightSelection);

      registerCubit.nextStep();
      expect(registerCubit.state, isA<RegisterState>());
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.genderSelection);

      registerCubit.nextStep();
      expect(registerCubit.state, isA<RegisterState>());
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.goalSelection);

      registerCubit.nextStep();
      expect(registerCubit.state, isA<RegisterState>());
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.levelSelection);

      registerCubit.nextStep();

      expect(registerCubit.state, isA<LoadingState>());

      await pumpEventQueue();

      expect(registerCubit.state, isA<SuccessState>());
      expect((registerCubit.state as SuccessState).message,
          'Registration completed!');

      verify(mockRegisterUsecase.register(any)).called(1);
    });
    test('previousStep goes back through steps correctly', () {
      registerCubit.start();

      registerCubit.nextStep();
      registerCubit.nextStep();
      registerCubit.nextStep();
      registerCubit.nextStep();
      registerCubit.nextStep();
      registerCubit.nextStep();

      registerCubit.previousStep();
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.goalSelection);

      registerCubit.previousStep();
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.genderSelection);

      registerCubit.previousStep();
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.heightSelection);

      registerCubit.previousStep();
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.weightSelection);

      registerCubit.previousStep();
      expect((registerCubit.state as RegisterState).step,
          RegisterStep.ageSelection);

      registerCubit.previousStep();
      expect((registerCubit.state as RegisterState).step, RegisterStep.initial);

      registerCubit.previousStep();
      expect((registerCubit.state as RegisterState).step, RegisterStep.initial);
    });
  });

  group('User data updates', () {
    test('updateUserData adds and updates user data correctly', () {
      registerCubit.start();

      registerCubit.updateUserData('firstName', 'John');
      expect(
          (registerCubit.state as RegisterState).userData['firstName'], 'John');

      registerCubit.updateUserData('age', 30);
      expect((registerCubit.state as RegisterState).userData['age'], 30);
      expect(
          (registerCubit.state as RegisterState).userData['firstName'], 'John');

      registerCubit.updateUserData('firstName', 'Johnny');
      expect((registerCubit.state as RegisterState).userData['firstName'],
          'Johnny');
    });
  });

  group('Registration submission', () {
    test('submit with success response', () async {
      registerCubit.start();

      registerCubit.updateUserData('firstName', 'John');
      registerCubit.updateUserData('lastName', 'Doe');
      registerCubit.updateUserData('email', 'john.doe@example.com');
      registerCubit.updateUserData('password', 'password123');
      registerCubit.updateUserData('rePassword', 'password123');
      registerCubit.updateUserData('gender', 'male');
      registerCubit.updateUserData('age', 30);
      registerCubit.updateUserData('weight', 75);
      registerCubit.updateUserData('height', 180);
      registerCubit.updateUserData('goal', 'build_muscle');
      registerCubit.updateUserData('activityLevel', 'active');

      final mockResponse = RegisterResponseEntity(
        message: 'Registration successful',
        user: User(
          id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
        ),
        token: 'valid_token',
      );

      when(mockRegisterUsecase.register(any)).thenAnswer(
        (_) async => Success<RegisterResponseEntity?>(mockResponse),
      );

      registerCubit.submit();

      expect(registerCubit.state, isA<LoadingState>());

      await untilCalled(mockRegisterUsecase.register(any));

      expect(registerCubit.state, isA<SuccessState>());
      expect((registerCubit.state as SuccessState).message,
          'Registration completed!');

      final capturedRequest = verify(mockRegisterUsecase.register(captureAny))
          .captured
          .single as RegisterRequest;
      expect(capturedRequest.firstName, 'John');
      expect(capturedRequest.lastName, 'Doe');
      expect(capturedRequest.email, 'john.doe@example.com');
      expect(capturedRequest.password, 'password123');
      expect(capturedRequest.rePassword, 'password123');
      expect(capturedRequest.gender, 'male');
      expect(capturedRequest.age, 30);
      expect(capturedRequest.weight, 75);
      expect(capturedRequest.height, 180);
      expect(capturedRequest.goal, 'build_muscle');
      expect(capturedRequest.activityLevel, 'active');
    });
    test('submit with failure response', () async {
      registerCubit.start();

      registerCubit.updateUserData('firstName', 'John');
      registerCubit.updateUserData('email', 'john.doe@example.com');
      registerCubit.updateUserData('password', 'password123');

      final testException = Exception('Registration failed');

      when(mockRegisterUsecase.register(any)).thenAnswer(
        (_) async => Fail<RegisterResponseEntity?>(testException),
      );

      registerCubit.submit();

      expect(registerCubit.state, isA<LoadingState>());

      await untilCalled(mockRegisterUsecase.register(any));

      expect(registerCubit.state, isA<ErrorState>());

      final errorState = registerCubit.state as ErrorState;

      expect(
        errorState.errorMessage,
        'Exception: Registration failed',
      );
    });
  });

  group('Step properties', () {
    test('totalSteps returns correct value', () {
      expect(registerCubit.totalSteps, 6);
    });

    test('currentStepIndex returns correct index', () {
      registerCubit.start();
      expect(registerCubit.currentStepIndex, RegisterStep.initial.index);

      registerCubit.nextStep();
      expect(registerCubit.currentStepIndex, RegisterStep.ageSelection.index);
    });
  });
}
