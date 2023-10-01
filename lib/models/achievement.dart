// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Achievement {
  final String image;
  final String title;
  final String description;
  final bool isAchieved;
  Achievement({
    required this.image,
    required this.title,
    required this.description,
    required this.isAchieved,
  });
  

  Achievement copyWith({
    String? image,
    String? title,
    String? description,
    bool? isAchieved,
  }) {
    return Achievement(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      isAchieved: isAchieved ?? this.isAchieved,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'description': description,
      'isAchieved': isAchieved,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      image: map['image'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isAchieved: map['isAchieved'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Achievement.fromJson(String source) => Achievement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Achievement(image: $image, title: $title, description: $description, isAchieved: $isAchieved)';
  }

  @override
  bool operator ==(covariant Achievement other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.title == title &&
      other.description == description &&
      other.isAchieved == isAchieved;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      title.hashCode ^
      description.hashCode ^
      isAchieved.hashCode;
  }
}
