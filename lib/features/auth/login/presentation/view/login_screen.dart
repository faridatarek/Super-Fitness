import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/core/widgets/custom_textfield.dart';
import 'package:super_fitness/features/auth/login/presentation/view/loginView_body.dart';
import 'package:super_fitness/features/auth/login/presentation/view/login_validator/login_validator_types_enum.dart';
import 'package:super_fitness/features/auth/login/presentation/viewModel/login_viewModel.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/main.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/extract_error_message.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';


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
            var message = extractErrorMessage(state.errorMessage as Exception?);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          } else if (state is LoginSuccessState) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
          }
        },
        child: LoginViewBody(),
      ),
    );
  }
}

