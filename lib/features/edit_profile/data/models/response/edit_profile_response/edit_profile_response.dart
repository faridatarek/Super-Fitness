import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/edit_profile/domain/entity/edit_profile_entity.dart';

class EditProfileResponse {
  String? message;
  User? user;

  EditProfileResponse({this.message, this.user});

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
      };

  EditProfileEntity toEntity() {
    return EditProfileEntity(
      lastName: user?.lastName,
      firstName: user?.firstName,
      email: user?.email,
      activityLevel: user?.activityLevel,
      goal: user?.goal,
      weight: user?.weight,
    );
  }
}
