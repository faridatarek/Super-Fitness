import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/base/cubit_builder.dart';
import 'package:super_fitness/features/base/cubit_listener.dart';
import '../../../../home/presentation/view/homeScreen.dart';
import '../view_model/create_new_password_view_model.dart';
import 'create_new_password_body.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<CreateNewPassWordViewModel>()..start(),
      child: BlocConsumer<CreateNewPassWordViewModel , BaseState>(
        listener: (context, state) {
          if (state is SuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
            );
          }


          return baseListener(context, state);

        },
        builder: (context, state) {
          return baseBuilder(context, state, CreateNewPasswordBody(viewModel: CreateNewPassWordViewModel.get(context),));
        },
        
      ),
    );
  }
}

