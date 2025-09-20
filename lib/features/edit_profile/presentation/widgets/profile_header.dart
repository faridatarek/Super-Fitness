import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/features/edit_profile/presentation/viewmodels/edit_profile_viewmodel.dart';
import 'package:super_fitness/utils/assets_manager.dart';
import 'package:super_fitness/utils/color_manager.dart';
import 'package:super_fitness/utils/strings_manager.dart';
import 'package:super_fitness/utils/text_style.dart';

class ProfileHeader extends StatelessWidget {
  final bool isEditable;

  const ProfileHeader({super.key, this.isEditable = true});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final imageUrl = user?.photo;
    final displayPlaceholder = imageUrl == null ||
        imageUrl.isEmpty ||
        imageUrl == "default-profile.png";

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.primary.withOpacity(0.1),
                    spreadRadius: 0.1,
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.grey[300],
              backgroundImage: !displayPlaceholder
                  ? (imageUrl.startsWith('http')
                      ? NetworkImage(imageUrl)
                      : FileImage(File(imageUrl)))
                  : null,
              child: displayPlaceholder
                  ? SvgPicture.asset(
                      SVGAssets.userPlaceholder,
                      width: 120.w,
                      height: 120.h,
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
            if (isEditable)
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54.withOpacity(0.5),
                ),
                child: Center(
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/svg/edit.svg',
                      width: 30.w,
                      height: 30.h,
                    ),
                    onPressed: () => _pickAndUploadImage(context),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          '${user?.firstName ?? StringsManager.guest.tr()} ${user?.lastName ?? ''}',
          style: AppTextStyles.font20W800White(),
        ),
      ],
    );
  }

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final viewModel = context.read<EditProfileViewModel>();

    showModalBottomSheet(
      backgroundColor: ColorManager.black,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(StringsManager.chooseImageSource.tr(),
                  style: AppTextStyles.font44W900Primary()
                      .copyWith(fontSize: 20.sp)),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: Text(StringsManager.camera.tr(),
                    style: AppTextStyles.font16W500White()),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(viewModel, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: Text(StringsManager.gallery.tr(),
                    style: AppTextStyles.font16W500White()),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(viewModel, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(
      EditProfileViewModel viewModel, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      await viewModel.uploadImage(imageFile);
    }
  }
}
