import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/base/cubit_builder.dart';
import 'package:super_fitness/features/base/cubit_listener.dart';
import 'package:super_fitness/features/forget_password/presentaion/forgot_password_screen/view/forget_password_body.dart';
import '../view_model/foget_password_view_model.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ForgetPassWordViewModel>()..start(),
      child: BlocConsumer<ForgetPassWordViewModel , BaseState>(
        listener: (context, state) {
          if (state is SuccessState) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, AppRoutes.otpVerificationScreen);

          }
          if (state is ErrorState) {
            Navigator.pop(context);

          }
          return baseListener(context, state);

        },
        builder: (context, state) {
          return baseBuilder(context, state, ForgetPasswordBody(viewModel: ForgetPassWordViewModel.get(context),));
        },
        
      ),
    );
  }
}

