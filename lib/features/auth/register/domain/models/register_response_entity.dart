import 'package:super_fitness/features/auth/domain/models/user.dart';

class RegisterResponseEntity {
  final String? message;
  final User? user;
  final String? token;

  RegisterResponseEntity({
    required this.message,
    required this.user,
    required this.token,
  });
}
