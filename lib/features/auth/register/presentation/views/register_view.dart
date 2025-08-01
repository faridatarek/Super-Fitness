import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/routes/app_routes.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/initial_step.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/age_selection_step.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/weight_selection_step.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/height_selection_step.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/gender_selection_step.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/goal_selection_step.dart';
import 'package:super_fitness/features/auth/register/presentation/steps/level_selection_step.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/gender_selector.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/base/cubit_builder.dart';
import 'package:super_fitness/features/base/cubit_listener.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GenderProvider()),
        ChangeNotifierProvider(create: (_) => GoalsProvider()),
        ChangeNotifierProvider(
            create: (_) => NumberSelectorProvider(initialValue: 0)),
      ],
      child: BlocProvider<RegisterCubit>(
        create: (context) => getIt.get<RegisterCubit>()..start(),
        child: BlocListener<RegisterCubit, BaseState>(
          listener: (context, state) {
            // Handle navigation for successful registration
            if (state is RegisterSuccessState && state.shouldNavigate) {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.mainLayout,
              );
            }
            baseListener(context, state);
          },
          child: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    ImageAssets.backGround1,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: AppSize.s5, sigmaY: AppSize.s5),
                    child: Container(
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ),
                SafeArea(
                  child: BlocBuilder<RegisterCubit, BaseState>(
                    builder: (context, state) {
                      final cubit = context.read<RegisterCubit>();
                      return baseBuilder(
                        context,
                        state,
                        Column(
                          children: [
                            Image.asset(
                              ImageAssets.logo,
                              height: AppSize.s48.h,
                            ),
                            Expanded(
                              child: _buildStepContent(context, state, cubit),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(
      BuildContext context, BaseState state, RegisterCubit cubit) {
    if (state is RegisterState) {
      switch (state.step) {
        case RegisterStep.initial:
          return InitialStep(formKey: _formKey, cubit: cubit);
        case RegisterStep.ageSelection:
          return AgeSelectionStep(cubit: cubit);
        case RegisterStep.weightSelection:
          return WeightSelectionStep(cubit: cubit);
        case RegisterStep.heightSelection:
          return HeightSelectionStep(cubit: cubit);
        case RegisterStep.genderSelection:
          return GenderSelectionStep(cubit: cubit);
        case RegisterStep.goalSelection:
          return GoalSelectionStep(cubit: cubit);
        case RegisterStep.levelSelection:
          return LevelSelectionStep(cubit: cubit);
      }
    }
    return Container();
  }
}
