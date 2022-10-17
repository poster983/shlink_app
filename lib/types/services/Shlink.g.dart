// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Shlink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shlink _$ShlinkFromJson(Map<String, dynamic> json) => Shlink(
      host: Uri.parse(json['host'] as String),
      name: json['name'] as String,
      apiKey: json['apiKey'] as String,
      isShortishCloud: json['isShortishCloud'] as bool? ?? false,
      color: JSONTypeConverters.colorFromJSON(json['color'] as int?),
    )
      ..type = $enumDecode(_$ServiceTypeEnumMap, json['type'])
      ..dayAdded = DateTime.parse(json['dayAdded'] as String)
      ..historyCache = (json['historyCache'] as List<dynamic>)
          .map((e) => ShortUrl.fromJson(e as Map<String, dynamic>))
          .toList()
      ..disabled = json['disabled'] as bool;

Map<String, dynamic> _$ShlinkToJson(Shlink instance) => <String, dynamic>{
      'type': _$ServiceTypeEnumMap[instance.type]!,
      'isShortishCloud': instance.isShortishCloud,
      'apiKey': instance.apiKey,
      'host': instance.host.toString(),
      'name': instance.name,
      'dayAdded': instance.dayAdded.toIso8601String(),
      'historyCache': instance.historyCache,
      'disabled': instance.disabled,
      'color': JSONTypeConverters.colorToJSON(instance.color),
    };

const _$ServiceTypeEnumMap = {
  ServiceType.Shlink: 'Shlink',
  ServiceType.Kuttit: 'Kuttit',
  ServiceType.GenericREST: 'GenericREST',
};
