import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/local/hive/hive_manager.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/features/base/base_cubit.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/uplaod_image_request.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';
import 'package:super_fitness/features/edit_profile/domain/use_cases/edit_profile_usecase.dart';
import 'package:super_fitness/features/auth/login/data/dataSource/offline_dataSource/cache_user_model.dart';
import 'package:super_fitness/utils/strings_manager.dart';

@injectable
class EditProfileViewModel extends BaseCubit {
  final EditProfileUsecase _editProfileUsecase;
  final UserProvider _userProvider;
  final HiveManager _hiveManager;

  String? firstName;
  String? lastName;
  String? email;
  int? weight;
  String? goal;
  String? activityLevel;

  final Map<String, String> activityLevelMap = {
    StringsManager.rookie: 'level1',
    StringsManager.beginner: 'level2',
    StringsManager.intermediate: 'level3',
    StringsManager.advance: 'level4',
    StringsManager.trueBeast: 'level5',
  };

  EditProfileViewModel(
    this._editProfileUsecase,
    this._userProvider,
    this._hiveManager,
  ) : super() {
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

  String getDisplayActivityLevel(String? backendValue) {
    return activityLevelMap.entries
        .firstWhere(
          (entry) => entry.value == backendValue,
          orElse: () => const MapEntry('Not Set', ''),
        )
        .key;
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
    }
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    return emailRegex.hasMatch(email) &&
        (email.toLowerCase().endsWith('.com') ||
            email.toLowerCase().endsWith('.net') ||
            email.toLowerCase().endsWith('.org'));
  }

  Future<void> submitProfileChanges() async {
    if (email != null && email!.isNotEmpty && !isEmailValid(email!)) {
      emitError(errorMessage: 'Please enter a valid email address');
      return;
    }
    final currentUser = _userProvider.user;
    final request = EditProfileRequest(
      firstName: firstName ?? currentUser!.firstName,
      lastName: lastName ?? currentUser!.lastName,
      email: email ?? currentUser!.email,
      weight: weight ?? currentUser!.weight,
      goal: goal ?? currentUser!.goal,
      activityLevel: activityLevel ?? currentUser!.activityLevel,
    );

    final result = await _editProfileUsecase.editProfile(request);
    if (result is Success<EditProfileEntity?>) {
      _userProvider.setUser(currentUser!.copyWith(
        firstName: request.firstName,
        lastName: request.lastName,
        email: request.email,
        weight: request.weight,
        goal: request.goal,
        activityLevel: request.activityLevel,
      ));

      final cacheUser = CacheUserModel.fromDomain(_userProvider.user!);
      final token = _userProvider.token ?? '';
      await _hiveManager.setUser(cacheUser, token);

      emit(SuccessState('Profile updated successfully'));
    } else if (result is Fail<EditProfileEntity?>) {
      emitError(errorMessage: 'Failed to update profile');
    }
  }

  Future<void> uploadImage(File imageFile) async {
    emitLoading();

    final request = UploadImageRequest(imageFile: imageFile);
    final result = await _editProfileUsecase.uploadImage(request);

    if (result is Success) {
      final currentUser = _userProvider.user;

      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(photo: imageFile.path);

        _userProvider.setUser(updatedUser);

        final token = _userProvider.token ?? '';
        final cacheUser = CacheUserModel.fromDomain(updatedUser);
        await _hiveManager.setUser(cacheUser, token);

        emitSuccess('Image uploaded successfully');
      } else {
        emitError(errorMessage: 'User not found');
      }
    } else {
      emitError(errorMessage: 'Failed to upload image');
    }
  }

  void updateWeightImmediately(int newWeight) {
    weight = newWeight;
    emit(StateUpdated());
  }

  void updateGoalImmediately(String newGoal) {
    goal = newGoal;
    emit(StateUpdated());
  }

  void updateActivityLevelImmediately(String newLevel) {
    activityLevel = newLevel;
    emit(StateUpdated());
  }
}

class StateUpdated extends BaseState {
  StateUpdated() : super();
}
