import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/core/widgets/custom_textfield.dart';
import 'package:super_fitness/features/auth/register/cubit/register_cubit.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/background_container.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/gender_selector.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/goals.dart';
import 'dart:ui';
import 'package:super_fitness/features/auth/register/presentation/widgets/number_selector.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/progress_arc.dart';
import 'package:super_fitness/features/auth/register/presentation/widgets/social_login_widget.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/base/cubit_builder.dart';
import 'package:super_fitness/features/base/cubit_listener.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      final cubit = context.read<RegisterCubit>();
                      return baseBuilder(
                        context,
                        state,
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              height: 48.h,
                            ),
                            // Conditionally show ProgressArc

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
          return _buildInitialStep(context, cubit);
        case RegisterStep.ageSelection:
          return _buildStepWithBackButton(
            context,
            _buildNumberSelector(
                context,
                'Year',
                16,
                50,
                'age',
                'How Old Are you ?',
                'This helps us create Your personalized plan'),
            cubit,
          );
        case RegisterStep.weightSelection:
          return _buildStepWithBackButton(
            context,
            _buildNumberSelector(
                context,
                'Kg',
                30,
                150,
                'weight',
                'what is your weight ?',
                'This helps us create Your personalized plan'),
            cubit,
          );
        case RegisterStep.heightSelection:
          return _buildStepWithBackButton(
            context,
            _buildNumberSelector(
                context,
                'Cm',
                30,
                250,
                'height',
                'what is your hight ?',
                'This helps us create Your personalized plan'),
            cubit,
          );
        case RegisterStep.genderSelection:
          return _buildStepWithBackButton(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TELL US ABOUT YOURSELF',
                    style: AppTextStyles.font20W800White()),
                Text('This helps us create your personalized plan',
                    style: AppTextStyles.font16W500White()),
                GenderSelection(
                  onNextPressed: () {
                    String selectedGender =
                        context.read<GenderProvider>().selectedGender ??
                            'female';
                    context
                        .read<RegisterCubit>()
                        .updateUserData('gender', selectedGender);
                    context.read<RegisterCubit>().nextStep();
                  },
                  onGenderSelected: (gender) {
                    context
                        .read<RegisterCubit>()
                        .updateUserData('gender', gender);
                  },
                ),
              ],
            ),
            cubit,
          );
        case RegisterStep.goalSelection:
          return _buildStepWithBackButton(
            context,
            _buildGoalSelector(
              context,
              'What is your goal?',
              [
                'Gain Weight',
                'Lose Weight',
                'Get Fitter',
                'Gain More Flexible',
                'Learn The Basic'
              ],
              'goal',
            ),
            cubit,
          );
        case RegisterStep.levelSelection:
          return _buildStepWithBackButton(
            context,
            _buildLevelSelector(context),
            cubit,
          );
      }
    }
    return Container();
  }

  Widget _buildStepWithBackButton(
      BuildContext context, Widget child, RegisterCubit cubit) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.h, left: 16.w),
          child: Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                cubit.previousStep();
              },
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: ColorManager.primary,
                child: SvgPicture.asset(
                  SVGAssets.arrowIcon,
                  width: 10.w,
                  height: 10.h,
                ),
              ),
            ),
          ),
        ),
        // ProgressArc (only shown from the second step onward)
        if (cubit.currentStepIndex > 0)
          Padding(
            padding: EdgeInsets.only(top: 16.h), // Add some spacing
            child: ProgressArc(
              current: cubit
                  .currentStepIndex, // Start counting from 1 in the second step
              total: cubit.totalSteps, // Fixed total steps (6)
            ),
          ),
        SizedBox(height: 16.h),
        // Step content
        child,
      ],
    );
  }

  Widget _buildInitialStep(BuildContext context, RegisterCubit cubit) {
    return Center(
      child: SingleChildScrollView(
        // Make it scrollable when needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('Hey there',
                    style: AppTextStyles.font18W400White()
                        .copyWith(fontSize: 18.sp)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('Create an account',
                    style: AppTextStyles.font20W800White()
                        .copyWith(fontSize: 20.sp)),
              ),
            ),
            BackgroundContainer(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text('Register',
                          style: AppTextStyles.font24W800White()
                              .copyWith(fontSize: 24.sp)),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(
                              12.0), // Adjust padding to fit properly
                          child: SvgPicture.asset(
                            'assets/svg/user.svg',
                            width: 24, // Adjust size as needed
                            height: 24,
                            colorFilter: const ColorFilter.mode(Colors.white,
                                BlendMode.srcIn), // Optional: Adjust color
                          ),
                        ),
                        hint: "First Name",
                        controller: cubit.firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(
                              12.0), // Adjust padding to fit properly
                          child: SvgPicture.asset(
                            'assets/svg/user.svg',
                            width: 24, // Adjust size as needed
                            height: 24,
                            colorFilter: const ColorFilter.mode(Colors.white,
                                BlendMode.srcIn), // Optional: Adjust color
                          ),
                        ),
                        hint: "Last Name",
                        controller: cubit.lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(
                              12.0), // Adjust padding to fit properly
                          child: SvgPicture.asset(
                            'assets/svg/mail.svg',
                            width: 24, // Adjust size as needed
                            height: 24,
                            colorFilter: const ColorFilter.mode(Colors.white,
                                BlendMode.srcIn), // Optional: Adjust color
                          ),
                        ),
                        hint: "Email",
                        controller: cubit.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(
                              12.0), // Adjust padding to fit properly
                          child: SvgPicture.asset(
                            'assets/svg/lock.svg',
                            width: 24, // Adjust size as needed
                            height: 24,
                            colorFilter: const ColorFilter.mode(Colors.white,
                                BlendMode.srcIn), // Optional: Adjust color
                          ),
                        ),
                        hint: "Password",
                        controller: cubit.passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(
                              12.0), // Adjust padding to fit properly
                          child: SvgPicture.asset(
                            'assets/svg/lock.svg',
                            width: 24, // Adjust size as needed
                            height: 24,
                            colorFilter: const ColorFilter.mode(Colors.white,
                                BlendMode.srcIn), // Optional: Adjust color
                          ),
                        ),
                        hint: "RePassword",
                        controller: cubit.rePasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re-enter your password';
                          }
                          if (value != cubit.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),
                      SocialLoginWidget(),
                      CustomButton(
                        text: "Register",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Validate the form
                            context.read<RegisterCubit>().updateUserData(
                                'firstName', cubit.firstNameController.text);
                            context.read<RegisterCubit>().updateUserData(
                                'lastName', cubit.lastNameController.text);
                            context.read<RegisterCubit>().updateUserData(
                                'email', cubit.emailController.text);
                            context.read<RegisterCubit>().updateUserData(
                                'password', cubit.passwordController.text);
                            context.read<RegisterCubit>().updateUserData(
                                'rePassword', cubit.rePasswordController.text);
                            context.read<RegisterCubit>().nextStep();
                          }
                        },
                      ),
                      SizedBox(height: 8.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already Have An Account ? ",
                              style: AppTextStyles.font14W800White()
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                                text: "Login",
                                style: AppTextStyles.font16W500White()
                                    .copyWith(color: Colors.orange)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNumberSelector(BuildContext context, String label, int min,
      int max, String field, String title, String subtitle) {
    return ChangeNotifierProvider(
      create: (_) => NumberSelectorProvider(initialValue: min),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: AppTextStyles.font20W800White()
                      .copyWith(fontWeight: FontWeight.w900)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(subtitle, style: AppTextStyles.font16W500White())),
          ),
          NumberSelector(
            min: min,
            max: max,
            labelText: label,
            onNextPressed: (selectedValue) {
              context
                  .read<RegisterCubit>()
                  .updateUserData(field, selectedValue);
              context.read<RegisterCubit>().nextStep();
            },
          ),
        ],
      ),
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
        Text('Your regular physical \nactivity level?',
            style: AppTextStyles.font20W800White()
                .copyWith(fontWeight: FontWeight.w900)),
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
