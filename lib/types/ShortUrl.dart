import 'package:json_annotation/json_annotation.dart';
import 'package:shlink/shlink.dart' as ShlinkAPI;
part 'ShortUrl.g.dart';

@JsonSerializable(nullable: false)
class ShortUrl {
  final Uri longUrl;
  final Uri shortUrl;
  final String slug;
  final DateTime dateCreated;
  final int visitCount;
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