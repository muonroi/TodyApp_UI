class RegisterModel {
  final String name;
  final String surname;
  final String phoneNumber;
  final String username;
  final String email;
  final String password;
  final String? externalLoginProvider;
  final String? externalLoginToken;
  final bool? isUseThirdPartyLogin;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    this.externalLoginProvider,
    this.externalLoginToken,
    this.isUseThirdPartyLogin,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'externalLoginProvider': externalLoginProvider,
      'externalLoginToken': externalLoginToken,
      'isUseThirdPartyLogin': isUseThirdPartyLogin,
    };
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      surname: json['surname'],
      phoneNumber: json['phoneNumber'],
      externalLoginProvider: json['externalLoginProvider'],
      externalLoginToken: json['externalLoginToken'],
      isUseThirdPartyLogin: json['isUseThirdPartyLogin'],
    );
  }
}
