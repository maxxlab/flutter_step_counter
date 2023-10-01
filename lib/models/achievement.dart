// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Achievement {
  final String image;
  final String title;
  final String description;
  Achievement({
    required this.image,
    required this.title,
    required this.description,
  });
  

  Achievement copyWith({
    String? image,
    String? title,
    String? description,
  }) {
    return Achievement(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'description': description,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      image: map['image'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Achievement.fromJson(String source) => Achievement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Achievement(image: $image, title: $title, description: $description)';

  @override
  bool operator ==(covariant Achievement other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ description.hashCode;
}
