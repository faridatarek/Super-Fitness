import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/uplaod_image_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/upload_image_response.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';
import 'package:super_fitness/features/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:super_fitness/features/edit_profile/domain/use_cases/edit_profile_usecase.dart';

import 'edit_profile_usecase_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late EditProfileUsecase usecase;
  late MockEditProfileRepo mockRepo;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    usecase = EditProfileUsecase(mockRepo);

    provideDummy<Result<EditProfileEntity?>>(
      Success(
        EditProfileEntity(
          firstName: "John",
          lastName: "Doe",
          email: "john@example.com",
          activityLevel: "Moderate",
          goal: "Lose Weight",
          weight: 70,
        ),
      ),
    );

    provideDummy<Result<UpdateProfileImageResponse?>>(
      Success(
          UpdateProfileImageResponse(message: "Image uploaded successfully")),
    );
  });

  group('EditProfileUsecase Tests', () {
    test('editProfile returns Success', () async {
      final request = EditProfileRequest(
        firstName: "John",
        lastName: "Doe",
        email: "john@example.com",
        activityLevel: "Moderate",
        goal: "Lose Weight",
        weight: 70,
      );
      final expectedEntity = EditProfileEntity(
        firstName: "John",
        lastName: "Doe",
        email: "john@example.com",
        activityLevel: "Moderate",
        goal: "Lose Weight",
        weight: 70,
      );
      final expectedResult = Success(expectedEntity);

      when(mockRepo.editProfile(request))
          .thenAnswer((_) async => expectedResult);

      final result = await usecase.editProfile(request);

      expect(result, expectedResult);
      verify(mockRepo.editProfile(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('editProfile returns Fail', () async {
      final request = EditProfileRequest();
      final expectedResult =
          Fail<EditProfileEntity?>(Exception("Failed to update"));

      when(mockRepo.editProfile(request))
          .thenAnswer((_) async => expectedResult);

      final result = await usecase.editProfile(request);

      expect(result, expectedResult);
      verify(mockRepo.editProfile(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('uploadImage returns Success', () async {
      final imageFile = File('test/test_assets/dummy.jpg');
      final request = UploadImageRequest(imageFile: imageFile);
      final expectedResult = Success(
          UpdateProfileImageResponse(message: "Image uploaded successfully"));

      when(mockRepo.uploadImage(request))
          .thenAnswer((_) async => expectedResult);

      final result = await usecase.uploadImage(request);

      expect(result, expectedResult);
      verify(mockRepo.uploadImage(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('uploadImage returns Fail', () async {
      final imageFile = File('test/test_assets/dummy.jpg');
      final request = UploadImageRequest(imageFile: imageFile);
      final expectedResult =
          Fail<UpdateProfileImageResponse?>(Exception("Image upload failed"));

      when(mockRepo.uploadImage(request))
          .thenAnswer((_) async => expectedResult);

      final result = await usecase.uploadImage(request);

      expect(result, expectedResult);
      verify(mockRepo.uploadImage(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
