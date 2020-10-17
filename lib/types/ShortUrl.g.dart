// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortUrl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortUrl _$ShortUrlFromJson(Map<String, dynamic> json) {
  return ShortUrl(
    longUrl: Uri.parse(json['longUrl'] as String),
    shortUrl: Uri.parse(json['shortUrl'] as String),
    slug: json['slug'] as String,
    dateCreated: DateTime.parse(json['dateCreated'] as String),
    visitCount: json['visitCount'] as int,
    tags: (json['tags'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ShortUrlToJson(ShortUrl instance) => <String, dynamic>{
      'longUrl': instance.longUrl.toString(),
      'shortUrl': instance.shortUrl.toString(),
      'slug': instance.slug,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'visitCount': instance.visitCount,
      'tags': instance.tags,
    };
