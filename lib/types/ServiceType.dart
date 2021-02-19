import 'package:hive/hive.dart';

part 'ServiceType.g.dart';

@HiveType(typeId : 2)
enum ServiceType { 
  @HiveField(0)
  Shlink,

  @HiveField(1)
  Kuttit,

  @HiveField(2)
  GenericREST
}