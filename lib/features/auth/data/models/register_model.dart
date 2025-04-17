class RegisterModel {
  final String name;
  final String surname;
  final String phoneNumber;
  final String username;
  final String email;
  final String password;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
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
    );
  }
}
