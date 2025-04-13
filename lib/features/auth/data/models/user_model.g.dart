// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      username: fields[1] as String,
      accessToken: fields[2] as String,
      refreshToken: fields[3] as String,
      emailAddress: fields[4] as String,
      name: fields[5] as String,
      surname: fields[6] as String,
      phoneNumber: fields[7] as String,
      isPhoneNumberConfirmed: fields[8] as bool,
      isEmailConfirmed: fields[9] as bool,
      isActive: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.accessToken)
      ..writeByte(3)
      ..write(obj.refreshToken)
      ..writeByte(4)
      ..write(obj.emailAddress)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.surname)
      ..writeByte(7)
      ..write(obj.phoneNumber)
      ..writeByte(8)
      ..write(obj.isPhoneNumberConfirmed)
      ..writeByte(9)
      ..write(obj.isEmailConfirmed)
      ..writeByte(10)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
