import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:shlink/shlink.dart' as ShlinkAPI;
import 'package:shlink_app/types/services/ServiceType.dart';
part 'ShortUrl.g.dart';


@JsonSerializable()
class ShortUrl {

  final Uri longUrl;

  final Uri shortUrl;

  final String slug;

  final DateTime dateCreated;

  final int? visitCount;
  final List<String>? tags;
  final ServiceType serviceType;
  final String serviceName;


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


  //MARK: DB

  ShortUrl.fromDB({
    required this.longUrl,
    required this.shortUrl,
    required this.slug,
    required this.dateCreated,
    this.visitCount,
    this.tags,
    required this.serviceType,
    required this.serviceName,
  });
}
