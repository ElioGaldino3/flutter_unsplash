import 'dart:convert';

import 'urls_model.dart';
import 'user_model.dart';

class UnsplashImageModel {
  final String id;
  final String color;
  final Urls urls;
  final int likes;
  final User user;

  UnsplashImageModel(this.id, this.color, this.urls, this.likes, this.user);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color,
      'urls': urls.toMap(),
      'likes': likes,
      'user': user.toMap(),
    };
  }

  factory UnsplashImageModel.fromMap(Map<String, dynamic> map) {
    return UnsplashImageModel(
      map['id'] ?? '',
      map['color'] ?? '',
      Urls.fromMap(map['urls']),
      map['likes']?.toInt() ?? 0,
      User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UnsplashImageModel.fromJson(String source) => UnsplashImageModel.fromMap(json.decode(source));
}
