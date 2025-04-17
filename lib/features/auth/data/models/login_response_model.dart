import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';

part 'login_response_model.g.dart';

@HiveType(typeId: 0)
class LoginResponseModel extends User {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String username;

  @override
  @HiveField(2)
  final String accessToken;

  @override
  @HiveField(3)
  final String refreshToken;

  @override
  @HiveField(4)
  final String emailAddress;

  @override
  @HiveField(5)
  final String name;

  @override
  @HiveField(6)
  final String surname;

  @override
  @HiveField(7)
  final String phoneNumber;

  @override
  @HiveField(8)
  final bool isPhoneNumberConfirmed;

  @override
  @HiveField(9)
  final bool isEmailConfirmed;

  @override
  @HiveField(10)
  final bool isActive;

  LoginResponseModel({
    required this.id,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.emailAddress,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.isPhoneNumberConfirmed,
    required this.isEmailConfirmed,
    required this.isActive,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      isPhoneNumberConfirmed: json['isPhoneNumberConfirmed'] ?? false,
      isEmailConfirmed: json['isEmailConfirmed'] ?? false,
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'emailAddress': emailAddress,
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'isPhoneNumberConfirmed': isPhoneNumberConfirmed,
      'isEmailConfirmed': isEmailConfirmed,
      'isActive': isActive,
    };
  }
}
