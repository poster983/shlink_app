// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Shlink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shlink _$ShlinkFromJson(Map<String, dynamic> json) {
  return Shlink(
    host: Uri.parse(json['host'] as String),
    apiKey: json['apiKey'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ShlinkToJson(Shlink instance) => <String, dynamic>{
      'apiKey': instance.apiKey,
      'host': instance.host.toString(),
      'name': instance.name,
    };