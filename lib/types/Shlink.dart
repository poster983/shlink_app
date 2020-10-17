import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shlink_app/types/Service.dart';
import 'package:shlink_app/types/SupportedFeatures.dart';
import 'package:shlink/shlink.dart' as ShlinkAPI;

import 'ShortUrl.dart';
part 'Shlink.g.dart';

@JsonSerializable(nullable: false)
class Shlink implements Service{

  @visibleForTesting
  ServiceType get type => ServiceType.Shlink;
  set type(t) => {}; // This is stupid.  Why is this required Json Serializable?

  String apiKey;

  Uri host;

  String name;

  DateTime dayAdded = new DateTime.now();

  ShlinkAPI.Shlink _shlinkAPI;


  @override
  SupportedFeatures get features => new SupportedFeatures(slug: true);

  Shlink({this.host, this.name, this.apiKey}) {
    _shlinkAPI = new ShlinkAPI.Shlink(host.toString(), apiKey);
  }


  factory Shlink.fromJson(Map<String, dynamic> json) => _$ShlinkFromJson(json);
  Map<String, dynamic> toJson() => _$ShlinkToJson(this);


  @override
   /// Shorten:  Will return a history of all links on the server
  Future<List<ShortUrl>> history() async {
    List<ShlinkAPI.ShortUrl> urls = await _shlinkAPI.list();

    return urls.map((url) {
      return ShortUrl.fromShlinkAPI(url);
    }).toList();
  }


  /// Shorten:  Will shorten a link using the Shlink service
  @override
  Future<ShortUrl> shorten(String link, {String slug}) async {
    
    ShlinkAPI.ShortUrl short = await _shlinkAPI.create(
      new ShlinkAPI.CreateShortURL(link, customSlug: slug)
    );
    return ShortUrl.fromShlinkAPI(short);
  }
}