import 'package:json_annotation/json_annotation.dart';
import 'package:shlink_app/types/Service.dart';
part 'Shlink.g.dart';

@JsonSerializable(nullable: false)
class Shlink extends Service{

  final String type = "Shlink";

  String apiKey;

  Uri host;

  String name;

  final DateTime dayAdded = new DateTime.now();

  Shlink({this.host, this.apiKey, this.name}) : super(this.dayAdded);


  factory Shlink.fromJson(Map<String, dynamic> json) => _$ShlinkFromJson(json);
  
  Map<String, dynamic> toJson() => _$ShlinkToJson(this);

}