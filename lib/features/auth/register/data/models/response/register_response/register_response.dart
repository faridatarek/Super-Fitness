import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/register/domain/models/register_response_entity.dart';

class RegisterResponse {
  String? message;
  User? user;
  String? token;

  RegisterResponse({this.message, this.user, this.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
        'token': token,
      };

  RegisterResponseEntity toEntity() {
    return RegisterResponseEntity(
      message: message,
      user: user,
      token: token,
    );
  }

  static RegisterResponse fromEntity(RegisterResponseEntity entity) {
    return RegisterResponse(
      message: entity.message,
      user: entity.user,
      token: entity.token,
    );
  }
}
