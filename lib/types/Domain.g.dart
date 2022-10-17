// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Domain _$DomainFromJson(Map<String, dynamic> json) => Domain(
      domain: json['domain'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$DomainToJson(Domain instance) => <String, dynamic>{
      'domain': instance.domain,
      'isDefault': instance.isDefault,
    };
