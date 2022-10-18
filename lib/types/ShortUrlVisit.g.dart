// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortUrlVisit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortUrlVisit _$ShortUrlVisitFromJson(Map<String, dynamic> json) =>
    ShortUrlVisit(
      id: json['id'] as String?,
      referrer: json['referrer'] as String?,
      date: DateTime.parse(json['date'] as String),
      userAgent: json['userAgent'] as String?,
      location: json['location'] == null
          ? null
          : ShortURLVisitLocation.fromJson(
              json['location'] as Map<String, dynamic>),
      shortUrlId: json['shortUrlId'] as String,
      potentialBot: json['potentialBot'] as bool?,
    );

Map<String, dynamic> _$ShortUrlVisitToJson(ShortUrlVisit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'referrer': instance.referrer,
      'date': instance.date.toIso8601String(),
      'userAgent': instance.userAgent,
      'location': instance.location,
      'potentialBot': instance.potentialBot,
      'shortUrlId': instance.shortUrlId,
    };
