// Register Cubit (Cubit)
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/auth/register/data/models/request/register_request.dart';
import 'package:super_fitness/features/auth/register/domain/repos/register_repo.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';
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

  RegisterState(
      {required this.step, this.userData = const {}, super.displayType});

  RegisterState copyWith({RegisterStep? step, Map<String, dynamic>? userData}) {
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

  @override
  void start() {
    emit(RegisterState(step: RegisterStep.initial));
  }

  void updateUserData(String key, dynamic value) {
    final currentState = state as RegisterState;
    final updatedUserData = Map<String, dynamic>.from(currentState.userData);
    updatedUserData[key] = value;
    emit(currentState.copyWith(userData: updatedUserData));
  }

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
