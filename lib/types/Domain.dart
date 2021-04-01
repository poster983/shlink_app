import 'package:json_annotation/json_annotation.dart';

part 'Domain.g.dart';
@JsonSerializable(nullable: false)
class Domain {

  final String domain;
  final bool isDefault;  // aka defiault

  Domain({required this.domain, this.isDefault = false});

  factory Domain.fromJson(Map<String, dynamic> json) => _$DomainFromJson(json);
  Map<String, dynamic> toJson() => _$DomainToJson(this);

}