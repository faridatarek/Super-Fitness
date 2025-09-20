import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/features/auth/login/data/models/request/login_request.dart';
import 'package:super_fitness/features/auth/login/data/models/response/login_response.dart';
import 'package:super_fitness/features/auth/login/domain/usecases/login_use_case.dart';
import 'package:super_fitness/features/auth/login/domain/usecases/set_cached_user_use_case.dart';
import 'package:super_fitness/features/auth/login/presentation/view/login_validator/login_validator.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/base/base_states.dart';

@injectable
class LoginViewModel extends BaseCubit {
  final LoginUseCase loginUsecase;
  final SetCachedUserUseCase _setCachedUserUseCase;
  final LoginValidator loginValidator;

  LoginViewModel(
    this.loginUsecase,
    this._setCachedUserUseCase,
    this.loginValidator,
  ) : super() {
    loginValidator.attachListeners(_onFieldsChanged);
  }

  final ValueNotifier<bool> fieldsFilledNotifier = ValueNotifier(false);

  void _onFieldsChanged() {
    fieldsFilledNotifier.value =
        loginValidator.emailController.text.isNotEmpty &&
            loginValidator.passwordController.text.isNotEmpty;
  }

  Future<void> handleIntent(LoginScreenIntent intent) async {
    switch (intent) {
      case LoginIntent():
        _handleLogin(intent);
      default:
        throw UnsupportedError("Unsupported intent: $intent");
    }
  }

  Future<void> _handleLogin(LoginIntent intent) async {
    debugPrint("Start Login");
    emit(LoadingState());

    final result = await loginUsecase.login(LoginRequest(
      email: loginValidator.emailController.text,
      password: loginValidator.passwordController.text,
    ));

    debugPrint("Login result: $result");

    switch (result) {
      case Success<LoginResponse?>():
        final user = result.data!.user!;
        final token = result.data!.token!;

        final cacheResult = await _setCachedUserUseCase.setUser(user, token);

        getIt<UserProvider>().setUser(user);
        getIt<UserProvider>().login(token);

        debugPrint("Cache result: $cacheResult");

        emit(LoginSuccessState(result.data));
        break;

      case Fail<LoginResponse?>():
        debugPrint("Login Failed");

        final message = result.data?.message ?? result.exception.toString();

        emit(ErrorState(message));
        emitError(errorMessage: message);
        break;
    }
  }

  @override
  void start() {}
}

sealed class LoginScreenIntent {}

class CheckCacheIntent extends LoginScreenIntent {}

class LoginIntent extends LoginScreenIntent {
  final String email;
  final String password;

  LoginIntent({required this.email, required this.password});
}

sealed class LoginState extends BaseState {}

class LoggedInState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponse? loginResponse;
  LoginSuccessState(this.loginResponse);
}
