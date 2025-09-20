import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/core/widgets/custom_appbar.dart';
import 'package:super_fitness/core/widgets/custom_button.dart';
import 'package:super_fitness/core/widgets/custom_textfield.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/base/cubit_builder.dart';
import 'package:super_fitness/features/base/cubit_listener.dart';
import 'package:super_fitness/features/edit_profile/presentation/viewmodels/edit_profile_viewmodel.dart';
import 'package:super_fitness/features/edit_profile/presentation/widgets/edit_component.dart';
import 'package:super_fitness/features/edit_profile/presentation/widgets/edit_section.dart';
import 'package:super_fitness/features/edit_profile/presentation/widgets/profile_header.dart';
import 'package:super_fitness/features/mian_lay_out_screen/mian_lay_out_view/mian_lay_out_screen.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/values_manager.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditProfileViewModel>(),
      child: BlocConsumer<EditProfileViewModel, BaseState>(
        listener: (context, state) {
          baseListener(context, state);

          if (state is SuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainLayOutScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return baseBuilder(
                context, state, const Scaffold(body: SizedBox()));
          } else {
            return baseBuilder(
              context,
              state,
              Scaffold(
                resizeToAvoidBottomInset: false,
                body: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage(ImageAssets.editProfileBackground),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Blur overlay
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: AppSize.s5, sigmaY: AppSize.s5),
                          child: Container(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                      ),
                      // Content
                      SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            CustomAppBar(
                              title: StringsManager.editProfile.tr(),
                              onTap: () => Navigator.pop(context),
                            ),
                            SizedBox(height: 10.h),
                            Center(
                              child: ChangeNotifierProvider.value(
                                value: getIt<UserProvider>(),
                                child: const ProfileHeader(),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            _buildFormFields(context),
                            SizedBox(height: 20.h),
                            _buildEditSections(context),
                            _buildSaveButton(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    final viewModel = context.read<EditProfileViewModel>();
    final firstNameController =
        TextEditingController(text: viewModel.firstName);
    final lastNameController = TextEditingController(text: viewModel.lastName);
    final emailController = TextEditingController(text: viewModel.email);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          CustomTextField(
            hint: StringsManager.firstName.tr(),
            controller: firstNameController,
            prefixIcon: SvgPicture.asset(
              SVGAssets.user,
              width: 24.w,
              height: 24.h,
            ),
            onChange: (value) => viewModel.updateField('firstName', value),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hint: StringsManager.lastName.tr(),
            controller: lastNameController,
            prefixIcon: SvgPicture.asset(
              SVGAssets.user,
              width: 24.w,
              height: 24.h,
            ),
            onChange: (value) => viewModel.updateField('lastName', value),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            hint: StringsManager.email.tr(),
            controller: emailController,
            prefixIcon: SvgPicture.asset(
              SVGAssets.mail,
              width: 24.w,
              height: 24.h,
            ),
            onChange: (value) => viewModel.updateField('email', value),
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !viewModel.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEditSections(BuildContext context) {
    final viewModel = context.read<EditProfileViewModel>();

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            EditSection(
              title: StringsManager.yourWeight.tr(),
              value: viewModel.weight != null
                  ? '${viewModel.weight} kg'
                  : StringsManager.notSet.tr(),
              type: EditType.weight,
              onValueUpdated: (value) {
                final weight = int.tryParse(value.split(' ')[0]);
                if (weight != null) {
                  viewModel.updateWeightImmediately(weight);
                  viewModel.updateField('weight', weight);
                }
              },
            ),
            SizedBox(height: 16.h),
            EditSection(
              title: StringsManager.yourGoal.tr(),
              value: viewModel.goal ?? StringsManager.notSet.tr(),
              type: EditType.goal,
              onValueUpdated: (value) {
                viewModel.updateGoalImmediately(value);
                viewModel.updateField('goal', value);
              },
            ),
            SizedBox(height: 16.h),
            EditSection(
              title: StringsManager.yourActivityLevel.tr(),
              value: viewModel.getDisplayActivityLevel(viewModel.activityLevel),
              type: EditType.activityLevel,
              onValueUpdated: (value) {
                final backendValue =
                    viewModel.activityLevelMap[value] ?? 'level1';
                viewModel.updateActivityLevelImmediately(backendValue);
                viewModel.updateField('activityLevel', backendValue);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: BlocBuilder<EditProfileViewModel, BaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomButton(
            onPressed: () =>
                context.read<EditProfileViewModel>().submitProfileChanges(),
            text: StringsManager.saveChanges.tr(),
            height: 50.h,
          );
        },
      ),
    );
  }
}
