import 'package:super_fitness/features/auth/domain/models/user.dart';

class LoginResponse {
  String? message;
  String? token;
  User? user;

  LoginResponse({this.message, this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json['message'] as String?,
    token: json['token'] as String?,
    user: json['user'] != null ? User.fromJson(json['user']) : null,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'token': token,
    'user': user?.toJson(),
  };
}
