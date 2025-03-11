import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/domain/usecases/register_usecase.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/base/base_states.dart';

enum RegisterStep {
  initial,
  ageSelection,
  weightSelection,
  heightSelection,
  genderSelection,
  goalSelection,
  levelSelection,
}

class RegisterState extends BaseState {
  final RegisterStep step;
  final Map<String, dynamic> userData;

  RegisterState({
    required this.step,
    this.userData = const {},
    super.displayType,
  });

  RegisterState copyWith({
    RegisterStep? step,
    Map<String, dynamic>? userData,
  }) {
    return RegisterState(
      step: step ?? this.step,
      userData: userData ?? this.userData,
    );
  }
}

@injectable
class RegisterCubit extends BaseCubit {
  final RegisterUsecase _registerUsecase;

  RegisterCubit(this._registerUsecase) : super();

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  void start() {
    emit(RegisterState(step: RegisterStep.initial));
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    return super.close();
  }

  /// Get the total number of steps
  int get totalSteps => 6; // Fixed total steps
  /// Get the current step index
  int get currentStepIndex => (state as RegisterState).step.index;

  /// Updates user data in the state.
  void updateUserData(String key, dynamic value) {
    final currentState = state as RegisterState;
    final updatedUserData = Map<String, dynamic>.from(currentState.userData);
    updatedUserData[key] = value;
    emit(currentState.copyWith(userData: updatedUserData));
  }

  /// Moves to the next step in the registration process.
  void nextStep() {
    final currentState = state as RegisterState;
    final currentStep = currentState.step;

    RegisterStep nextStep;
    switch (currentStep) {
      case RegisterStep.initial:
        nextStep = RegisterStep.ageSelection;
        break;
      case RegisterStep.ageSelection:
        nextStep = RegisterStep.weightSelection;
        break;
      case RegisterStep.weightSelection:
        nextStep = RegisterStep.heightSelection;
        break;
      case RegisterStep.heightSelection:
        nextStep = RegisterStep.genderSelection;
        break;
      case RegisterStep.genderSelection:
        nextStep = RegisterStep.goalSelection;
        break;
      case RegisterStep.goalSelection:
        nextStep = RegisterStep.levelSelection;
        break;
      case RegisterStep.levelSelection:
        submit();
        return;
    }

    emit(currentState.copyWith(step: nextStep));
  }

  /// Moves to the previous step in the registration process.
  void previousStep() {
    final currentState = state as RegisterState;
    final currentStep = currentState.step;

    RegisterStep previousStep;
    switch (currentStep) {
      case RegisterStep.ageSelection:
        previousStep = RegisterStep.initial;
        break;
      case RegisterStep.weightSelection:
        previousStep = RegisterStep.ageSelection;
        break;
      case RegisterStep.heightSelection:
        previousStep = RegisterStep.weightSelection;
        break;
      case RegisterStep.genderSelection:
        previousStep = RegisterStep.heightSelection;
        break;
      case RegisterStep.goalSelection:
        previousStep = RegisterStep.genderSelection;
        break;
      case RegisterStep.levelSelection:
        previousStep = RegisterStep.goalSelection;
        break;
      default:
        previousStep = RegisterStep.initial;
    }

    emit(currentState.copyWith(step: previousStep));
  }

  /// Submits the registration data to the server.
  void submit() async {
    final currentState = state as RegisterState;
    emitLoading();

    final request = RegisterRequest(
      firstName: currentState.userData['firstName'],
      lastName: currentState.userData['lastName'],
      email: currentState.userData['email'],
      password: currentState.userData['password'],
      rePassword: currentState.userData['rePassword'],
      gender: currentState.userData['gender'],
      age: currentState.userData['age'],
      weight: currentState.userData['weight'],
      height: currentState.userData['height'],
      goal: currentState.userData['goal'],
      activityLevel: currentState.userData['activityLevel'],
    );

    final result = await _registerUsecase.register(request);

    if (result is Success) {
      emitSuccess("Registration completed!");
    } else if (result is Fail) {
      emitError(errorMessage: result.toString());
    }
  }
}
