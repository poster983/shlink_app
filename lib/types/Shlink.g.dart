// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Shlink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shlink _$ShlinkFromJson(Map<String, dynamic> json) {
  return Shlink(
    host: Uri.parse(json['host'] as String),
    name: json['name'] as String,
    apiKey: json['apiKey'] as String,
  )
    ..type = _$enumDecode(_$ServiceTypeEnumMap, json['type'])
    ..domain =
        json['domain'] == null ? null : Uri.parse(json['domain'] as String)
    ..dayAdded = DateTime.parse(json['dayAdded'] as String);
}

Map<String, dynamic> _$ShlinkToJson(Shlink instance) => <String, dynamic>{
      'type': _$ServiceTypeEnumMap[instance.type],
      'apiKey': instance.apiKey,
      'host': instance.host.toString(),
      'domain': instance.domain?.toString(),
      'name': instance.name,
      'dayAdded': instance.dayAdded.toIso8601String(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$ServiceTypeEnumMap = {
  ServiceType.Shlink: 'Shlink',
};
