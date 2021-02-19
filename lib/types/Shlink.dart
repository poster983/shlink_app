import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shlink_app/types/Service.dart';
import 'package:shlink_app/types/SupportedFeatures.dart';
import 'package:shlink/shlink.dart' as ShlinkAPI;

import 'ShortUrl.dart';
part 'Shlink.g.dart';

@JsonSerializable(nullable: false)
class Shlink implements Service {
  @visibleForTesting
  ServiceType get type => ServiceType.Shlink;
  set type(t) => {}; // This is stupid.  Why is this required Json Serializable?

  String apiKey;

  Uri host;
  @JsonKey(nullable: true)
  Uri domain;

  String name;

  DateTime dayAdded = new DateTime.now();

  ShlinkAPI.Shlink _shlinkAPI;

  @override
  SupportedFeatures get features => new SupportedFeatures(slug: true);

  Shlink({this.host, this.name, this.apiKey}) {
    _shlinkAPI = new ShlinkAPI.Shlink(host.toString(), apiKey);
    //temp
    domain = Uri.parse(this.host.host);
  }

  factory Shlink.fromJson(Map<String, dynamic> json) => _$ShlinkFromJson(json);
  Map<String, dynamic> toJson() => _$ShlinkToJson(this);

  

  /// history:  Will return a history of all links on the server
  @override
  Future<List<ShortUrl>> history() async {
    print(host);
    try {
    List<ShlinkAPI.ShortUrl> urls = await _shlinkAPI.list();
    
    return urls.map((url) {
      return ShortUrl.fromShlinkAPI(url);
    }).toList();

    } catch (err) {
      return Future.error(err);
    }
  }

  /// refreshHistory: Will update the hivedb history
  @override
  Future<bool> refreshHistory() async {
    try {
      var historyBox = Hive.box<ShortUrl>("history");
      List<ShortUrl> urls = await history();
      print("refreshedHistory: ${urls.length}");
      urls.forEach((e) {
        historyBox.put(e.shortUrl.toString(), e);
        //print(e.shortUrl.toString());
      });

      return true;
    } catch (err) {
      return Future.error(err);
    }
    

  }

  /// Shorten:  Will shorten a link using the Shlink service
  @override
  Future<ShortUrl> shorten(Uri link, {String slug}) async {
    try {
    ShlinkAPI.ShortUrl short = await _shlinkAPI.create(
        new ShlinkAPI.CreateShortURL(
          link.toString(),
            customSlug: slug
        )
    );
      return ShortUrl.fromShlinkAPI(short);
    } catch(err) {
      return Future.error(err);
    }
    
  }

  

}
