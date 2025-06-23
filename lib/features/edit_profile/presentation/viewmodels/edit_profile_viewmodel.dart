import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/uplaod_image_request.dart';
import 'package:super_fitness/features/edit_profile/domain/use_cases/edit_profile_usecase.dart';

@injectable
class EditProfileViewModel extends BaseCubit {
  final EditProfileUsecase _editProfileUsecase;
  final UserProvider _userProvider;

  String? firstName;
  String? lastName;
  String? email;
  int? weight;
  String? goal;
  String? activityLevel;

  EditProfileViewModel(this._editProfileUsecase, this._userProvider) : super() {
    _initializeWithUserData();
  }

  void _initializeWithUserData() {
    final user = _userProvider.user;
    if (user != null) {
      firstName = user.firstName;
      lastName = user.lastName;
      email = user.email;
      weight = user.weight;
      goal = user.goal;
      activityLevel = user.activityLevel;
    }
  }

  @override
  void start() {}

  void updateField(String fieldName, dynamic value) {
    switch (fieldName) {
      case 'firstName':
        firstName = value;
        break;
      case 'lastName':
        lastName = value;
        break;
      case 'email':
        email = value;
        break;
      case 'weight':
        weight = value;
        break;
      case 'goal':
        goal = value;
        break;
      case 'activityLevel':
        activityLevel = value;
        break;
      default:
        break;
    }
  }

  Future<void> submitProfileChanges() async {
    emitLoading();

    final currentUser = _userProvider.user;
    if (currentUser == null) {
      emitError(errorMessage: 'User not found');
      return;
    }

    final request = EditProfileRequest(
      firstName: firstName != currentUser.firstName
          ? firstName
          : currentUser.firstName,
      lastName:
          lastName != currentUser.lastName ? lastName : currentUser.lastName,
      email: email != currentUser.email ? email : currentUser.email,
      weight: weight != currentUser.weight ? weight : currentUser.weight,
      goal: goal != currentUser.goal ? goal : currentUser.goal,
      activityLevel: activityLevel != currentUser.activityLevel
          ? activityLevel
          : currentUser.activityLevel,
    );

    final result = await _editProfileUsecase.editProfile(request);

    if (result is Success) {
      _userProvider.setUser(
        currentUser.copyWith(
          firstName: request.firstName,
          lastName: request.lastName,
          email: request.email,
          weight: request.weight,
          goal: request.goal,
          activityLevel: request.activityLevel,
        ),
      );
      emitSuccess('Profile updated successfully');
    } else {
      emitError(errorMessage: 'Failed to update profile');
    }
  }

  Future<void> uploadImage(File imageFile) async {
    emitLoading();

    final request = UploadImageRequest(imageFile: imageFile);

    final result = await _editProfileUsecase.uploadImage(request);

    if (result is Success) {
      emitSuccess('Image uploaded successfully');
    } else {
      emitError(errorMessage: 'Failed to upload image');
    }
  }
}
