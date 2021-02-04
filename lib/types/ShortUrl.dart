import 'package:hive/hive.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:shlink/shlink.dart' as ShlinkAPI;
part 'ShortUrl.g.dart';

@HiveType(typeId : 0)
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
  final int visitCount;
  @HiveField(5)
  final List<String> tags;

  ShortUrl({this.longUrl, this.shortUrl, this.slug, this.dateCreated, this.visitCount, this.tags});
  factory ShortUrl.fromShlinkAPI(ShlinkAPI.ShortUrl short) {
    return ShortUrl(
      longUrl: Uri.parse(short.longUrl), 
      shortUrl: Uri.parse(short.shortUrl),
      slug: short.shortCode,
      dateCreated: short.dateCreated,
      visitCount: short.visitsCount,
      tags: short.tags
    );
  }



  factory ShortUrl.fromJson(Map<String, dynamic> json) => _$ShortUrlFromJson(json);
  Map<String, dynamic> toJson() => _$ShortUrlToJson(this);
}