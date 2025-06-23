
 import 'package:hive/hive.dart';
import 'package:super_fitness/features/auth/domain/models/user.dart';
part 'cache_user_model.g.dart';

@HiveType(typeId: 0)
class CacheUserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  String gender;

  @HiveField(5)
  int age;

  @HiveField(6)
  int weight;

  @HiveField(7)
  int height;

  @HiveField(8)
  String activityLevel;

  @HiveField(9)
  String goal;

  @HiveField(10)
  String photo;

  @HiveField(11)
  String createdAt;

  CacheUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.goal,
    required this.photo,
    required this.createdAt,
  });

  User toDomain() {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
      photo: photo,
      createdAt: createdAt,
    );
  }


  static CacheUserModel fromDomain(User user) {
    return CacheUserModel(
      id: user.id ?? '',
      firstName: user.firstName ?? '',
      lastName: user.lastName ?? '',
      email: user.email ?? '',
      gender: user.gender ?? '',
      age: user.age ?? 0,
      weight: user.weight ?? 0,
      height: user.height ?? 0,
      activityLevel: user.activityLevel ?? '',
      goal: user.goal ?? '',
      photo: user.photo ?? '',
      createdAt: user.createdAt ?? '',
    );
  }
}
