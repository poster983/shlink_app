// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortUrl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortUrl _$ShortUrlFromJson(Map<String, dynamic> json) => ShortUrl(
      id: json['id'] as String?,
      longUrl: Uri.parse(json['longUrl'] as String),
      shortUrl: Uri.parse(json['shortUrl'] as String),
      slug: json['slug'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      visitCount: json['visitCount'] as int?,
      serviceId: json['serviceId'] as String?,
      title: json['title'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ShortUrlToJson(ShortUrl instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'longUrl': instance.longUrl.toString(),
      'shortUrl': instance.shortUrl.toString(),
      'slug': instance.slug,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'visitCount': instance.visitCount,
      'notes': instance.notes,
      'serviceId': instance.serviceId,
    };
