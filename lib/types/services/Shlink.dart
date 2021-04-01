import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/common.dart';
import 'package:shlink_app/types/Domain.dart';
import 'package:shlink_app/types/JSONTypeConverters.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/types/ShortUrlVisitLocation.dart';
import 'package:shlink_app/types/api_response_types/ShlinkGetDomains.dart';
import 'package:shlink_app/types/services/Service.dart';
import 'package:shlink_app/types/SupportedFeatures.dart';
import 'package:shlink/shlink.dart' as ShlinkAPI;
import 'ServiceType.dart';
import 'package:http/http.dart' as http;

import '../ShortUrl.dart';
part 'Shlink.g.dart';

@JsonSerializable(nullable: false)
class Shlink implements Service {
  @visibleForTesting
  ServiceType get type => ServiceType.Shlink;
  set type(t) => {}; // This is stupid.  Why is this required Json Serializable?

  String apiKey;

  Uri host;
  //@JsonKey(nullable: true)
  @JsonKey(ignore: true)
  List<Domain> get domains {
    _getDomains()
        .then((value) => {_domainsCache = value})
        .catchError((err) => {throw err});
    return _domainsCache;
  }

  @JsonKey(ignore: true)
  set domains(list) => {_domainsCache = list!};

  @JsonKey(ignore: false)
  late List<Domain> _domainsCache;

  String name;

  late DateTime dayAdded;

  List<ShortUrl> historyCache = [];

  late ShlinkAPI.Shlink _shlinkAPI;

  bool disabled = false;

  @JsonKey(
      fromJson: JSONTypeConverters.colorFromJSON,
      toJson: JSONTypeConverters.colorToJSON)
  late Color? color;

  @override
  SupportedFeatures get features => new SupportedFeatures(
      slug: true, multipleDomains: true, clickAnalytics: true, locationAnalytics: true);

  Shlink(
      {required this.host,
      required this.name,
      required this.apiKey,
      this.color}) {
    _shlinkAPI = new ShlinkAPI.Shlink(host.toString(), apiKey);
    dayAdded = new DateTime.now();
    if (color == null) {
      color = randomColor();
    }
    //historyCache = [];
    //temp
    //domain = Uri.parse(this.host.host);
    _getDomains()
        .then((value) => {_domainsCache = value})
        .catchError((err) => {throw err});
    //_domainsCache = await _getDomains();
    //__setColor(color);
  }

  factory Shlink.fromJson(Map<String, dynamic> json) => _$ShlinkFromJson(json);
  Map<String, dynamic> toJson() => _$ShlinkToJson(this);

  /// history:  Will return a history of all links on the server
  @override
  Future<List<ShortUrl>> history() async {
    print(host);
    try {
      List<ShlinkAPI.ShortUrl> urls = await _shlinkAPI.list();
      //_shlinkAPI.listVisits(shortCode)
      final historyList = urls.map((url) {
        return ShortUrl.fromShlinkAPI(url, serviceName: name);
      }).toList();
      //historyCache = historyList;
      return historyList;
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
  Future<ShortUrl> shorten(Uri link, {String? slug}) async {
    try {
      ShlinkAPI.ShortUrl short = await _shlinkAPI.create(
          new ShlinkAPI.CreateShortURL(link.toString(), customSlug: slug));
      return ShortUrl.fromShlinkAPI(short, serviceName: name);
    } catch (err) {
      return Future.error(err);
    }
  }

  /** HELPER FUNCTIONS */
  Future<List<Domain>> _getDomains() async {
    try {
      final res = await http.get(Uri.https(host.authority, 'rest/v2/domains'),
          headers: {"X-Api-Key": apiKey});
      return ShlinkGetDomains.fromJson(jsonDecode(res.body)).toDomainList();
    } catch (err) {
      throw err;
    }
  }

  @override
  Future<List<ShortUrlVisit>> visitStats(ShortUrl shortUrl) async {
    //try {
      List<ShlinkAPI.Visit> visits = await _shlinkAPI.listVisits(shortUrl.slug);
      //print(visits);
      List<ShortUrlVisit> normalVisits = visits.map((e) {
        ShortURLVisitLocation? visitLocation;
        if (e.visitLocation != null) {
          visitLocation = new ShortURLVisitLocation(
            coordinates: LatLng(double.parse(e.visitLocation.latitude),
                double.parse(e.visitLocation.longitude)),
            city: e.visitLocation.cityName,
            region: e.visitLocation.regionName,
            country: e.visitLocation.countryName,
            timezone: e.visitLocation.timezone
          );
        }
        return ShortUrlVisit(
          location: visitLocation, 
          referer: e.referer,
          userAgent: e.userAgent,
          date: e.date
        );
      }).toList();
      return normalVisits;
    /*} catch (err) {
      return Future.error(err);
    }*/
  }
}
