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
    color: JSONTypeConverters.colorFromJSON(json['color'] as int?),
  )
    ..type = _$enumDecode(_$ServiceTypeEnumMap, json['type'])
    ..dayAdded = DateTime.parse(json['dayAdded'] as String)
    ..historyCache = (json['historyCache'] as List<dynamic>)
        .map((e) => ShortUrl.fromJson(e as Map<String, dynamic>))
        .toList()
    ..disabled = json['disabled'] as bool;
}

Map<String, dynamic> _$ShlinkToJson(Shlink instance) => <String, dynamic>{
      'type': _$ServiceTypeEnumMap[instance.type],
      'apiKey': instance.apiKey,
      'host': instance.host.toString(),
      'name': instance.name,
      'dayAdded': instance.dayAdded.toIso8601String(),
      'historyCache': instance.historyCache,
      'disabled': instance.disabled,
      'color': JSONTypeConverters.colorToJSON(instance.color),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ServiceTypeEnumMap = {
  ServiceType.Shlink: 'Shlink',
  ServiceType.Kuttit: 'Kuttit',
  ServiceType.GenericREST: 'GenericREST',
};
