// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Server _$ServerFromJson(Map<String, dynamic> json) {
  return Server(
    host: Uri.parse(json['host'] as String),
    apiKey: json['apiKey'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
      'apiKey': instance.apiKey,
      'host': instance.host.toString(),
      'name': instance.name,
    };
