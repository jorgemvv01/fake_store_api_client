import 'package:equatable/equatable.dart';

class UserRequest extends Equatable {
  final String email;
  final String username;
  final String password;

  const UserRequest({
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
    email: json["email"],
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "username": username,
    "password": password
  };

  @override
  List<Object?> get props => [email, username, password];

  UserRequest copyWith({
    int? id,
    String? email,
    String? username,
    String? password,
    String? phone,
  }) {
    return UserRequest(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password
    );
  }
}