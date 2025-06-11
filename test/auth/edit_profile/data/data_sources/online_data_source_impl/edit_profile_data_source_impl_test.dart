import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/network/api_manager.dart';
import 'package:super_fitness/core/network/upload_image_api_manager.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/edit_profile/data/data_sources/online_data_source_impl/edit_profile_data_source_impl.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/uplaod_image_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/edit_profile_response.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/upload_image_response.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';
import 'edit_profile_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiManager, UploadImageApiManager])
void main() {
  late EditProfileDataSourceImpl dataSource;
  late MockApiManager mockApiManager;
  late MockUploadImageApiManager mockUploadImageApiManager;

  setUp(() {
    mockApiManager = MockApiManager();
    mockUploadImageApiManager = MockUploadImageApiManager();
    dataSource =
        EditProfileDataSourceImpl(mockApiManager, mockUploadImageApiManager);

    provideDummy<UpdateProfileImageResponse>(
      UpdateProfileImageResponse(message: "Image uploaded"),
    );

    provideDummy<Result<EditProfileEntity?>>(
      Success(EditProfileEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        goal: 'lose_weight',
        activityLevel: 'active',
        weight: 70,
      )),
    );
  });

  group('EditProfileDataSourceImpl Tests', () {
    final editRequest = EditProfileRequest(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      goal: 'lose_weight',
      activityLevel: 'active',
      weight: 70,
    );

    final mockUser = User(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      goal: 'lose_weight',
      activityLevel: 'active',
      weight: 70,
    );

    test('editProfile returns Success', () async {
      when(mockApiManager.editProfile(editRequest)).thenAnswer(
        (_) async => EditProfileResponse(
          message: 'Success',
          user: mockUser,
        ),
      );

      final result = await dataSource.editProfile(editRequest);

      expect(result, isA<Success<EditProfileEntity?>>());
      final success = result as Success<EditProfileEntity?>;
      expect(success.data?.email, 'john@example.com');
      verify(mockApiManager.editProfile(editRequest)).called(1);
    });

    test('editProfile returns Fail on exception', () async {
      when(mockApiManager.editProfile(editRequest))
          .thenThrow(Exception('error'));

      final result = await dataSource.editProfile(editRequest);

      expect(result, isA<Fail<EditProfileEntity?>>());
      verify(mockApiManager.editProfile(editRequest)).called(1);
    });

    test('uploadImage returns Success', () async {
      final file = File('dummy.jpg'); // Replace with actual File if needed
      final request = UploadImageRequest(imageFile: file);

      when(mockUploadImageApiManager.uploadImage(file)).thenAnswer(
        (_) async => UpdateProfileImageResponse(message: 'uploaded'),
      );

      final result = await dataSource.uploadImage(request);

      expect(result, isA<Success<UpdateProfileImageResponse?>>());
      final success = result as Success<UpdateProfileImageResponse?>;
      expect(success.data?.message, 'uploaded');
      verify(mockUploadImageApiManager.uploadImage(file)).called(1);
    });

    test('uploadImage returns Fail on exception', () async {
      final file = File('dummy.jpg');
      final request = UploadImageRequest(imageFile: file);

      when(mockUploadImageApiManager.uploadImage(file))
          .thenThrow(Exception('upload failed'));

      final result = await dataSource.uploadImage(request);

      expect(result, isA<Fail<UpdateProfileImageResponse?>>());
      verify(mockUploadImageApiManager.uploadImage(file)).called(1);
    });
  });
}
