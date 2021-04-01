// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortUrlVisitLocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortURLVisitLocation _$ShortURLVisitLocationFromJson(
    Map<String, dynamic> json) {
  return ShortURLVisitLocation(
    coordinates:
        JSONTypeConverters.latLngFromJSON(json['coordinates'] as String),
    city: json['city'] as String?,
    region: json['region'] as String?,
    country: json['country'] as String?,
    timezone: json['timezone'] as String?,
  );
}

Map<String, dynamic> _$ShortURLVisitLocationToJson(
        ShortURLVisitLocation instance) =>
    <String, dynamic>{
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'coordinates': JSONTypeConverters.latLngToJSON(instance.coordinates),
      'timezone': instance.timezone,
    };
