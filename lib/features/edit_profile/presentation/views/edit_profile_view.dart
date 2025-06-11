import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/di/di.dart';

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
        listener: baseListener,
        builder: (context, state) {
          return baseBuilder(
            context,
            state,
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      ImageAssets.editProfileBackground,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h),
                        CustomAppBar(title: StringsManager.editProfile),
                        SizedBox(height: 10.h),
                        const Center(child: ProfileHeader()),
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
          );
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
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        children: [
          CustomTextField(
            hint: StringsManager.firstName,
            controller: firstNameController,
            prefixIcon: SvgPicture.asset(SVGAssets.user),
            onChange: (value) => viewModel.updateField('firstName', value),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            hint: StringsManager.lastName,
            controller: lastNameController,
            prefixIcon: SvgPicture.asset(SVGAssets.user),
            onChange: (value) => viewModel.updateField('lastName', value),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            hint: StringsManager.email,
            controller: emailController,
            prefixIcon: SvgPicture.asset(SVGAssets.mail),
            onChange: (value) => viewModel.updateField('email', value),
          ),
        ],
      ),
    );
  }

  Widget _buildEditSections(BuildContext context) {
    final viewModel = context.read<EditProfileViewModel>();

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              EditSection(
                title: StringsManager.yourWeight,
                value: viewModel.weight != null
                    ? '${viewModel.weight} kg'
                    : StringsManager.notSet,
                type: EditType.weight,
                onValueUpdated: (value) {
                  final weight = int.tryParse(value.split(' ')[0]);
                  if (weight != null) {
                    viewModel.updateField('weight', weight);
                  }
                },
              ),
              const SizedBox(height: 16),
              EditSection(
                title: StringsManager.yourGoal,
                value: viewModel.goal ?? StringsManager.notSet,
                type: EditType.goal,
                onValueUpdated: (value) => viewModel.updateField('goal', value),
              ),
              const SizedBox(height: 16),
              EditSection(
                title: StringsManager.yourActivityLevel,
                value: viewModel.activityLevel ?? StringsManager.notSet,
                type: EditType.activityLevel,
                onValueUpdated: (value) =>
                    viewModel.updateField('activityLevel', value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomButton(
        onPressed: () =>
            context.read<EditProfileViewModel>().submitProfileChanges(),
        text: StringsManager.saveChanges,
      ),
    );
  }
}
