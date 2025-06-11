import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/core/network/api_execution.dart';
import 'package:super_fitness/core/network/api_manager.dart';
import 'package:super_fitness/core/network/upload_image_api_manager.dart';
import 'package:super_fitness/features/edit_profile/data/contracts/online_data_source/online_data_source.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/uplaod_image_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/edit_profile_response.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/upload_image_response.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';

@Injectable(as: EditProfileOnlineDataSource)
class EditProfileDataSourceImpl implements EditProfileOnlineDataSource {
  final ApiManager apiManager;
  final UploadImageApiManager uploadImageApiManager;
  EditProfileDataSourceImpl(this.apiManager, this.uploadImageApiManager);
  @override
  Future<Result<EditProfileEntity?>> editProfile(EditProfileRequest request) {
    return executeApi(() async {
      final result = await apiManager.editProfile(request);
      return EditProfileResponse(
        message: result?.message,
        user: result?.user,
      ).toEntity();
    });
  }

  @override
  Future<Result<UpdateProfileImageResponse?>> uploadImage(
      UploadImageRequest request) {
    return executeApi(() async {
      final result =
          await uploadImageApiManager.uploadImage(request.imageFile!);
      return UpdateProfileImageResponse(
        message: result?.message,
      );
    });
  }
}
