import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/edit_profile/data/contracts/online_data_source/online_data_source.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/uplaod_image_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/upload_image_response.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';
import 'package:super_fitness/features/edit_profile/domain/repos/edit_profile_repo.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileOnlineDataSource _editProfileOnlineDataSource;
  EditProfileRepoImpl(this._editProfileOnlineDataSource);
  @override
  Future<Result<EditProfileEntity?>> editProfile(EditProfileRequest request) {
    return _editProfileOnlineDataSource.editProfile(request);
  }

  @override
  Future<Result<UpdateProfileImageResponse?>> uploadImage(
      UploadImageRequest request) {
    return _editProfileOnlineDataSource.uploadImage(request);
  }
}
