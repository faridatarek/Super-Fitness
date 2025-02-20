import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/core/widgets/custom_textfield.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/gender_selector.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'dart:ui';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/base/cubit_builder.dart';
import 'package:super_fitness/features/base/cubit_listener.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => getIt.get<RegisterCubit>()..start(),
      child: BlocListener<RegisterCubit, BaseState>(
        listener: baseListener,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ),
              SafeArea(
                child: BlocBuilder<RegisterCubit, BaseState>(
                  builder: (context, state) {
                    return baseBuilder(
                      context,
                      state,
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 48.h,
                          ),
                          Expanded(
                            child: _buildStepContent(context, state),
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
    );
  }

  Widget _buildStepContent(BuildContext context, BaseState state) {
    if (state is RegisterState) {
      switch (state.step) {
        case RegisterStep.initial:
          return _buildInitialStep(context);
        case RegisterStep.ageSelection:
          return _buildNumberSelector(context, 'Age', 16, 50, 'age');
        case RegisterStep.weightSelection:
          return _buildNumberSelector(context, 'Weight', 30, 150, 'weight');
        case RegisterStep.heightSelection:
          return _buildNumberSelector(context, 'Height', 30, 250, 'height');
        case RegisterStep.genderSelection:
          return Expanded(
            child: GenderSelection(
              onNextPressed: () {
                // Get the selected gender from the provider
                String selectedGender =
                    context.read<GenderProvider>().selectedGender ??
                        'female'; // Default to female if none selected
                context
                    .read<RegisterCubit>()
                    .updateUserData('gender', selectedGender);
                context.read<RegisterCubit>().nextStep();
              },
              onGenderSelected: (gender) {
                context.read<RegisterCubit>().updateUserData('gender', gender);
              },
            ),
          );

        case RegisterStep.goalSelection:
          return _buildGoalSelector(
              context,
              'What is your goal?',
              [
                'Gain Weight',
                'Lose Weight',
                'Get Fitter',
                'Gain More Flexible',
                'Learn The Basic'
              ],
              'goal');
        case RegisterStep.levelSelection:
          return _buildLevelSelector(context);
      }
    }
    return Container();
  }

  Widget _buildInitialStep(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hey there',
            style: AppTextStyles.font18W400White().copyWith(fontSize: 18.sp)),
        Text('Create an account',
            style: AppTextStyles.font20W800White().copyWith(fontSize: 20.sp)),
        BackgroundContainer(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text('Register',
                    style: AppTextStyles.font24W800White()
                        .copyWith(fontSize: 24.sp)),
                SizedBox(height: 16.h),
                CustomTextField(
                    hint: "First Name", controller: _firstNameController),
                SizedBox(height: 16.h),
                CustomTextField(
                    hint: "Last Name", controller: _lastNameController),
                SizedBox(height: 16.h),
                CustomTextField(hint: "Email", controller: _emailController),
                SizedBox(height: 16.h),
                CustomTextField(
                    hint: "Password", controller: _passwordController),
                CustomTextField(
                    hint: "RePassword", controller: _rePasswordController),
                SizedBox(height: 16.h),
                CustomButton(
                  text: "Next",
                  onPressed: () {
                    context
                        .read<RegisterCubit>()
                        .updateUserData('firstName', _firstNameController.text);
                    context
                        .read<RegisterCubit>()
                        .updateUserData('lastName', _lastNameController.text);
                    context
                        .read<RegisterCubit>()
                        .updateUserData('email', _emailController.text);
                    context
                        .read<RegisterCubit>()
                        .updateUserData('password', _passwordController.text);
                    context.read<RegisterCubit>().updateUserData(
                        'rePassword', _rePasswordController.text);
                    context.read<RegisterCubit>().nextStep();
                  },
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNumberSelector(
      BuildContext context, String label, int min, int max, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberSelector(
          onNextPressed: (int selectedValue) {
            // Update here to accept int parameter
            context.read<RegisterCubit>().updateUserData(type, selectedValue);
            context.read<RegisterCubit>().nextStep();
          },
          min: min,
          max: max,
          labelText: label,
        ),
      ],
    );
  }

  Widget _buildGoalSelector(
      BuildContext context, String title, List<String> items, String type) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: AppTextStyles.font20W800White()
                .copyWith(fontWeight: FontWeight.w900)),
        Text('This helps us create your personalized plan',
            style: AppTextStyles.font16W500White()),
        Expanded(
          child: GoalsScreen(
            items: items,
            onNext: (selectedValue) {
              // Update here to accept selected value
              context.read<RegisterCubit>().updateUserData(type, selectedValue);
              context.read<RegisterCubit>().nextStep();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLevelSelector(BuildContext context) {
    final Map<String, String> levelMap = {
      'Rookie': 'level1',
      'Beginner': 'level2',
      'Intermediate': 'level3',
      'Advance': 'level4',
      'True Beast': 'level5',
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Your regular physical \nactivity level?',
          style: AppTextStyles.font20W800White()
              .copyWith(fontWeight: FontWeight.w900),
        ),
        Text(
          'This helps us create your personalized plan',
          style: AppTextStyles.font16W500White(),
        ),
        Expanded(
          child: GoalsScreen(
            items: levelMap.keys.toList(),
            onNext: (selectedValue) {
              // Update here to accept selected value
              String mappedLevel = levelMap[selectedValue] ?? 'level1';
              context
                  .read<RegisterCubit>()
                  .updateUserData('activityLevel', mappedLevel);
              context.read<RegisterCubit>().nextStep();
            },
          ),
        ),
      ],
    );
  }
}
