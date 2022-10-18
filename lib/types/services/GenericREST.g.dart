// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenericREST.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericREST _$GenericRESTFromJson(Map json) => GenericREST(
      host: Uri.parse(json['host'] as String),
      name: json['name'] as String,
      longURLParameter: json['longURLParameter'] as String,
      color: JSONTypeConverters.colorFromJSON(json['color'] as int),
      headers: (json['headers'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e as String),
      ),
      customSlugParameter: json['customSlugParameter'] as String?,
      httpMethod:
          $enumDecodeNullable(_$HTTPMethodEnumMap, json['httpMethod']) ??
              HTTPMethod.POST,
      urlParameters: (json['urlParameters'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e as String),
      ),
      reqBody: (json['reqBody'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e as String),
      ),
      shortenedURLParameter: json['shortenedURLParameter'] as String?,
      contentType:
          $enumDecodeNullable(_$ContentTypeEnumMap, json['contentType']) ??
              ContentType.JSON,
    )
      ..type = $enumDecode(_$ServiceTypeEnumMap, json['type'])
      ..dateAdded = DateTime.parse(json['dateAdded'] as String)
      ..disabled = json['disabled'] as bool;

Map<String, dynamic> _$GenericRESTToJson(GenericREST instance) =>
    <String, dynamic>{
      'type': _$ServiceTypeEnumMap[instance.type]!,
      'name': instance.name,
      'dateAdded': instance.dateAdded.toIso8601String(),
      'host': instance.host.toString(),
      'customSlugParameter': instance.customSlugParameter,
      'shortenedURLParameter': instance.shortenedURLParameter,
      'longURLParameter': instance.longURLParameter,
      'headers': instance.headers,
      'reqBody': instance.reqBody,
      'urlParameters': instance.urlParameters,
      'httpMethod': _$HTTPMethodEnumMap[instance.httpMethod]!,
      'contentType': _$ContentTypeEnumMap[instance.contentType]!,
      'disabled': instance.disabled,
      'color': JSONTypeConverters.colorToJSON(instance.color),
    };

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
