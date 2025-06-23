import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/local/providers/user_provider.dart';
import 'package:super_fitness/features/base/base_states.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/upload_image_response.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';
import 'package:super_fitness/features/edit_profile/domain/use_cases/edit_profile_usecase.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/edit_profile/presentation/viewmodels/edit_profile_viewmodel.dart';

import 'edit_profile_viewmodel_test.mocks.dart';

@GenerateMocks([EditProfileUsecase, UserProvider])
void main() {
  late EditProfileViewModel viewModel;
  late MockEditProfileUsecase mockUsecase;
  late MockUserProvider mockUserProvider;

  final dummyUser = User(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    weight: 70,
    goal: 'lose_weight',
    activityLevel: 'active',
  );

  provideDummy<Result<void>>(Success(null));
  provideDummy<Result<String>>(Success('dummy'));
  provideDummy<Result<EditProfileEntity?>>(Success(null));
  provideDummy<Result<UpdateProfileImageResponse?>>(
    Success(UpdateProfileImageResponse()),
  );

  setUp(() {
    mockUsecase = MockEditProfileUsecase();
    mockUserProvider = MockUserProvider();

    when(mockUserProvider.user).thenReturn(dummyUser);

    viewModel = EditProfileViewModel(mockUsecase, mockUserProvider);
  });

  group('EditProfileViewModel', () {
    test('should initialize with user data', () {
      expect(viewModel.firstName, equals('John'));
      expect(viewModel.lastName, equals('Doe'));
      expect(viewModel.email, equals('john@example.com'));
      expect(viewModel.weight, equals(70));
      expect(viewModel.goal, equals('lose_weight'));
      expect(viewModel.activityLevel, equals('active'));
    });

    test('should emit success on successful profile update', () async {
      when(mockUsecase.editProfile(any)).thenAnswer((_) async => Success(null));

      await viewModel.submitProfileChanges();

      expect(viewModel.state, isA<SuccessState>());
      expect((viewModel.state as SuccessState).message,
          'Profile updated successfully');

      verify(mockUserProvider.setUser(any)).called(1);
      verify(mockUsecase.editProfile(any)).called(1);
    });

    test('should emit error when user is null', () async {
      when(mockUserProvider.user).thenReturn(null);

      await viewModel.submitProfileChanges();

      expect(viewModel.state, isA<ErrorState>());
      expect((viewModel.state as ErrorState).errorMessage, 'User not found');
    });

    test('should emit error on failed profile update', () async {
      when(mockUsecase.editProfile(any))
          .thenAnswer((_) async => Fail(Exception('Server error')));

      await viewModel.submitProfileChanges();

      expect(viewModel.state, isA<ErrorState>());
      expect((viewModel.state as ErrorState).errorMessage,
          'Failed to update profile');
    });

    test('should emit success on successful image upload', () async {
      final file = File('dummy_path.jpg');

      when(mockUsecase.uploadImage(any)).thenAnswer(
        (_) async => Success(UpdateProfileImageResponse()),
      );

      await viewModel.uploadImage(file);

      expect(viewModel.state, isA<SuccessState>());
      expect((viewModel.state as SuccessState).message,
          'Image uploaded successfully');
    });

    test('should emit error on failed image upload', () async {
      final file = File('dummy_path.jpg');

      when(mockUsecase.uploadImage(any))
          .thenAnswer((_) async => Fail(Exception('Upload failed')));

      await viewModel.uploadImage(file);

      expect(viewModel.state, isA<ErrorState>());
      expect((viewModel.state as ErrorState).errorMessage,
          'Failed to upload image');
    });

    test('updateField should change correct field', () {
      viewModel.updateField('firstName', 'Alice');
      viewModel.updateField('weight', 65);
      viewModel.updateField('goal', 'gain_muscle');

      expect(viewModel.firstName, 'Alice');
      expect(viewModel.weight, 65);
      expect(viewModel.goal, 'gain_muscle');
    });
  });
}
