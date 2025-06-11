import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/common/result.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/edit_profile_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/request/uplaod_image_request.dart';
import 'package:super_fitness/features/edit_profile/data/models/response/edit_profile_response/upload_image_response.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';
import 'package:super_fitness/features/edit_profile/domain/repos/edit_profile_repo.dart';

@injectable
class EditProfileUsecase {
  final EditProfileRepo editProfileRepo;

  EditProfileUsecase(this.editProfileRepo);
  Future<Result<EditProfileEntity?>> editProfile(
      EditProfileRequest request) async {
    return await editProfileRepo.editProfile(request);
  }

  Future<Result<UpdateProfileImageResponse?>> uploadImage(
      UploadImageRequest request) async {
    return await editProfileRepo.uploadImage(request);
  }
}
