// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortUrlVisit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortUrlVisit _$ShortUrlVisitFromJson(Map<String, dynamic> json) =>
    ShortUrlVisit(
      referrer: json['referrer'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      userAgent: json['userAgent'] as String?,
      location: json['location'] == null
          ? null
          : ShortURLVisitLocation.fromJson(
              json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShortUrlVisitToJson(ShortUrlVisit instance) =>
    <String, dynamic>{
      'referrer': instance.referrer,
      'date': instance.date?.toIso8601String(),
      'userAgent': instance.userAgent,
      'location': instance.location,
    };
