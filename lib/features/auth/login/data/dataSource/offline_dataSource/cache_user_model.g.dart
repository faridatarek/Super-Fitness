// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheUserModelAdapter extends TypeAdapter<CacheUserModel> {
  @override
  final int typeId = 0;

  @override
  CacheUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheUserModel(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      gender: fields[4] as String,
      age: fields[5] as int,
      weight: fields[6] as int,
      height: fields[7] as int,
      activityLevel: fields[8] as String,
      goal: fields[9] as String,
      photo: fields[10] as String,
      createdAt: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CacheUserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.age)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.height)
      ..writeByte(8)
      ..write(obj.activityLevel)
      ..writeByte(9)
      ..write(obj.goal)
      ..writeByte(10)
      ..write(obj.photo)
      ..writeByte(11)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
