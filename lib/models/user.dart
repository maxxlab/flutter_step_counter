// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';
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

  final Map<String, bool> achievements = {
    'first logged in': false,
    'Walked 10 000 steps': false,
    'Walked 100 000 steps': false,
    'Walked 1 000 000 steps': false
  };

 
}
