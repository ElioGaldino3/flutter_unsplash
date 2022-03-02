import 'dart:convert';

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;
  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  Map<String, dynamic> toMap() {
    return {
      'raw': raw,
      'full': full,
      'regular': regular,
      'small': small,
      'thumb': thumb,
      'small_s3': smallS3,
    };
  }

  factory Urls.fromMap(Map<String, dynamic> map) {
    return Urls(
      raw: map['raw'] ?? '',
      full: map['full'] ?? '',
      regular: map['regular'] ?? '',
      small: map['small'] ?? '',
      thumb: map['thumb'] ?? '',
      smallS3: map['small_s3'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Urls.fromJson(String source) => Urls.fromMap(json.decode(source));
}
