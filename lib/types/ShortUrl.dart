import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:shlink/shlink.dart' as ShlinkAPI;
import 'package:shlink_app/types/services/ServiceType.dart';
part 'ShortUrl.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(nullable: false)
class ShortUrl {
  @HiveField(0)
  final Uri longUrl;
  @HiveField(1)
  final Uri shortUrl;
  @HiveField(2)
  final String slug;
  @HiveField(3)
  final DateTime dateCreated;
  @HiveField(4)
  final int? visitCount;
  @HiveField(5)
  final List<String>? tags;
  @HiveField(6)
  final ServiceType serviceType;
  @HiveField(7)
  final String serviceName;
  @HiveField(8)
  String? faviconUrl;

  String get domain {
    return shortUrl.host;
  }

  ShortUrl(
      {required this.longUrl,
      required this.shortUrl,
      required this.slug,
      required this.dateCreated,
      this.visitCount,
      this.tags,
      // this,favicon
      required this.serviceType,
      required this.serviceName});
  factory ShortUrl.fromShlinkAPI(ShlinkAPI.ShortUrl short,
      {required String serviceName}) {
    return ShortUrl(
        longUrl: Uri.parse(short.longUrl),
        shortUrl: Uri.parse(short.shortUrl),
        slug: short.shortCode,
        dateCreated: short.dateCreated,
        visitCount: short.visitsCount,
        tags: short.tags,
        serviceType: ServiceType.Shlink,
        serviceName: serviceName);
  }

  factory ShortUrl.fromJson(Map<String, dynamic> json) =>
      _$ShortUrlFromJson(json);
  Map<String, dynamic> toJson() => _$ShortUrlToJson(this);
}
