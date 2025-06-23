import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/edit_profile/data/contracts/online_data_source/online_data_source.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/uplaod_image_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/upload_image_response.dart';
import 'package:super_fitness/features/edit_profile/data/repos/edit_profile_repo_impl.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';

@GenerateMocks([EditProfileOnlineDataSource])
import 'edit_profile_repo_impl_test.mocks.dart';

void main() {
  late EditProfileRepoImpl editProfileRepoImpl;
  late MockEditProfileOnlineDataSource mockEditProfileOnlineDataSource;

  setUp(() {
    mockEditProfileOnlineDataSource = MockEditProfileOnlineDataSource();
    editProfileRepoImpl = EditProfileRepoImpl(mockEditProfileOnlineDataSource);

    provideDummy<Result<EditProfileEntity?>>(
      Success(
        EditProfileEntity(
          firstName: 'Test',
          lastName: 'User',
          email: 'test@example.com',
          goal: 'lose_weight',
          activityLevel: 'active',
          weight: 70,
        ),
      ),
    );

    provideDummy<Result<UpdateProfileImageResponse?>>(
      Success(UpdateProfileImageResponse(message: 'Uploaded successfully')),
    );
  });

  group('EditProfileRepoImpl Tests', () {
    final editRequest = EditProfileRequest(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      goal: 'lose_weight',
      activityLevel: 'active',
      weight: 70,
    );

    final uploadRequest = UploadImageRequest(
      imageFile: File('dummy.jpg'),
    );

    final editEntity = EditProfileEntity(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      goal: 'lose_weight',
      activityLevel: 'active',
      weight: 70,
    );

    final imageResponse = UpdateProfileImageResponse(message: 'Image uploaded');

    test('editProfile returns Success', () async {
      when(mockEditProfileOnlineDataSource.editProfile(editRequest))
          .thenAnswer((_) async => Success(editEntity));

      final result = await editProfileRepoImpl.editProfile(editRequest);

      expect(result, isA<Success<EditProfileEntity?>>());
      expect((result as Success).data, editEntity);
      verify(mockEditProfileOnlineDataSource.editProfile(editRequest))
          .called(1);
      verifyNoMoreInteractions(mockEditProfileOnlineDataSource);
    });

    test('editProfile returns Fail', () async {
      final exception = Exception('Edit failed');
      when(mockEditProfileOnlineDataSource.editProfile(editRequest))
          .thenAnswer((_) async => Fail(exception));

      final result = await editProfileRepoImpl.editProfile(editRequest);

      expect(result, isA<Fail<EditProfileEntity?>>());
      expect((result as Fail).exception.toString(), contains('Edit failed'));
      verify(mockEditProfileOnlineDataSource.editProfile(editRequest))
          .called(1);
      verifyNoMoreInteractions(mockEditProfileOnlineDataSource);
    });

    test('uploadImage returns Success', () async {
      when(mockEditProfileOnlineDataSource.uploadImage(uploadRequest))
          .thenAnswer((_) async => Success(imageResponse));

      final result = await editProfileRepoImpl.uploadImage(uploadRequest);

      expect(result, isA<Success<UpdateProfileImageResponse?>>());
      expect((result as Success).data?.message, 'Image uploaded');
      verify(mockEditProfileOnlineDataSource.uploadImage(uploadRequest))
          .called(1);
      verifyNoMoreInteractions(mockEditProfileOnlineDataSource);
    });

    test('uploadImage returns Fail', () async {
      final exception = Exception('Upload failed');
      when(mockEditProfileOnlineDataSource.uploadImage(uploadRequest))
          .thenAnswer((_) async => Fail(exception));

      final result = await editProfileRepoImpl.uploadImage(uploadRequest);

      expect(result, isA<Fail<UpdateProfileImageResponse?>>());
      expect((result as Fail).exception.toString(), contains('Upload failed'));
      verify(mockEditProfileOnlineDataSource.uploadImage(uploadRequest))
          .called(1);
      verifyNoMoreInteractions(mockEditProfileOnlineDataSource);
    });
  });
}
