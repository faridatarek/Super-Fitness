import 'package:super_fitness/features/auth/domain/models/user.dart';
import 'package:super_fitness/features/auth/login/data/dataSource/offline_dataSource/cache_user_model.dart';

class HiveUserDto {
  static User toEntity(CacheUserModel cacheUser) {
    return User(
        id: cacheUser.id,
        firstName: cacheUser.firstName,
        lastName: cacheUser.lastName,
        email: cacheUser.email,
        gender: cacheUser.gender,
        age: cacheUser.age,
        weight: cacheUser.weight,
        height: cacheUser.height,
        activityLevel: cacheUser.activityLevel,
        goal: cacheUser.goal,
        photo: cacheUser.photo,
        createdAt: cacheUser.createdAt
    );
  }

  static CacheUserModel toHiveModel(User entity) {
    return CacheUserModel(
      id: entity.id!,
      firstName: entity.firstName!,
      lastName: entity.lastName!,
      email: entity.email!,
      gender: entity.gender!,
      age: entity.age!,
      weight: entity.weight!,
      height: entity.height!,
      activityLevel: entity.activityLevel!,
      goal: entity.goal!,
      photo: entity.photo!,
      createdAt: entity.createdAt!,
    );
  }

  static CacheUserModel driverDataResponseToHive(User data) {
    return CacheUserModel(
        id: data.id!,
        firstName: data.firstName!,
        lastName: data.lastName!,
        email: data.email!,
        gender: data.gender!,
        age: data.age!,
        weight: data.weight!,
        height: data.height!,
        activityLevel: data.activityLevel!,
        goal: data.goal!,
        photo: data.photo!,
        createdAt: data.createdAt!
    );
  }
}

