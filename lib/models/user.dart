// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

class UserModel {
  final String username;
  final String email;
  final String password;
  final File? userImage;
  UserModel({
    required this.username,
    required this.email,
    required this.password,
    this.userImage,
  });

 

  UserModel copyWith({
    String? username,
    String? email,
    String? password,
    File? userImage,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      userImage: userImage ?? this.userImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'userImage': userImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      userImage: map['userImage'] as File,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, password: $password, userImage: $userImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.email == email &&
      other.password == password &&
      other.userImage == userImage;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      email.hashCode ^
      password.hashCode ^
      userImage.hashCode;
  }
}
