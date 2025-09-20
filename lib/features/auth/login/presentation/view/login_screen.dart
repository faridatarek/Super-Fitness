import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/features/auth/login/presentation/view/loginView_body.dart';
import 'package:super_fitness/features/auth/login/presentation/viewModel/login_viewModel.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/base/cubit_listener.dart';
import 'package:super_fitness/features/base/cubit_builder.dart'; // make sure you import this

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<LoginViewModel>();

    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<LoginViewModel, BaseState>(
        listener: (context, state) {
          if (state is ErrorState) {
            baseListener(context, state);
          } else if (state is LoginSuccessState) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.mainLayout);
          }
        },
        child: BlocBuilder<LoginViewModel, BaseState>(
          builder: (context, state) {
            return baseBuilder(
              context,
              state,
              const LoginViewBody(),
            );
          },
        ),
      ),
    );
  }
}
