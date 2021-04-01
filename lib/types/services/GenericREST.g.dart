// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenericREST.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericREST _$GenericRESTFromJson(Map json) {
  return GenericREST(
    host: Uri.parse(json['host'] as String),
    name: json['name'] as String,
    longURLParameter: json['longURLParameter'] as String,
    color: JSONTypeConverters.colorFromJSON(json['color'] as int?),
    headers: (json['headers'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as String),
    ),
    customSlugParameter: json['customSlugParameter'] as String?,
    httpMethod: _$enumDecode(_$HTTPMethodEnumMap, json['httpMethod']),
    urlParameters: (json['urlParameters'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as String),
    ),
    reqBody: (json['reqBody'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as String),
    ),
    shortenedURLParameter: json['shortenedURLParameter'] as String?,
    contentType: _$enumDecode(_$ContentTypeEnumMap, json['contentType']),
  )
    ..type = _$enumDecode(_$ServiceTypeEnumMap, json['type'])
    ..dayAdded = DateTime.parse(json['dayAdded'] as String)
    ..historyCache = (json['historyCache'] as List<dynamic>)
        .map((e) => ShortUrl.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList()
    ..disabled = json['disabled'] as bool;
}

Map<String, dynamic> _$GenericRESTToJson(GenericREST instance) =>
    <String, dynamic>{
      'type': _$ServiceTypeEnumMap[instance.type],
      'name': instance.name,
      'dayAdded': instance.dayAdded.toIso8601String(),
      'host': instance.host.toString(),
      'customSlugParameter': instance.customSlugParameter,
      'shortenedURLParameter': instance.shortenedURLParameter,
      'longURLParameter': instance.longURLParameter,
      'historyCache': instance.historyCache,
      'headers': instance.headers,
      'reqBody': instance.reqBody,
      'urlParameters': instance.urlParameters,
      'httpMethod': _$HTTPMethodEnumMap[instance.httpMethod],
      'contentType': _$ContentTypeEnumMap[instance.contentType],
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

const _$HTTPMethodEnumMap = {
  HTTPMethod.GET: 'GET',
  HTTPMethod.POST: 'POST',
};

const _$ContentTypeEnumMap = {
  ContentType.FormEncoded: 'FormEncoded',
  ContentType.JSON: 'JSON',
};

const _$ServiceTypeEnumMap = {
  ServiceType.Shlink: 'Shlink',
  ServiceType.Kuttit: 'Kuttit',
  ServiceType.GenericREST: 'GenericREST',
};
