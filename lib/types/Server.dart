import 'package:json_annotation/json_annotation.dart';
part 'Server.g.dart';

@JsonSerializable(nullable: false)
class Server {

  String apiKey;

  Uri host;

  String name;

  final DateTime dayAdded = new DateTime.now();

  Server({this.host, this.apiKey, this.name});


  factory Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);
  
  Map<String, dynamic> toJson() => _$ServerToJson(this);

}