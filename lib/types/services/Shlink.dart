import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/common.dart';
import 'package:shlink_app/database/DriftGetter.dart';
import 'package:shlink_app/types/Domain.dart';
import 'package:shlink_app/types/Health.dart';
import 'package:shlink_app/types/JSONTypeConverters.dart';
import 'package:shlink_app/types/ServiceException.dart';
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

  // late String id;
  @override
  String get id => name;

  @visibleForTesting
  ServiceType get type => ServiceType.Shlink;
  set type(t) => {}; // This is stupid.  Why is this required Json Serializable?

  bool isShortishCloud;

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

  late DateTime dateAdded;

  // List<ShortUrl> historyCache = [];

  late ShlinkAPI.Shlink _shlinkAPI;

  bool disabled = false;

  @JsonKey(
      fromJson: JSONTypeConverters.colorFromJSON,
      toJson: JSONTypeConverters.colorToJSON)
  late Color color;

  @override
  SupportedFeatures get features => new SupportedFeatures(
      slug: true,
      multipleDomains: true,
      clickAnalytics: true,
      locationAnalytics: true);

  Shlink({
      required this.host,
      required this.name,
      required this.apiKey,
      this.isShortishCloud = false,
      Color? color
      }) {
        _shlinkAPI = new ShlinkAPI.Shlink(host.toString(), apiKey);
        dateAdded = new DateTime.now();
        this.color = color ?? randomColor();


        //name cannot be shortish cloud unless it is shortish cloud
        if (name == "Shortish Cloud" && isShortishCloud == false) {
          throw Exception(
              "Only the Shortish Cloud service can be named Shortish Cloud");
        }
        //historyCache = [];
        //temp
        //domain = Uri.parse(this.host.host);
        /*try {
          print("GETTING DOMAINS");
          _getDomains().then((value) => {_domainsCache = value}).catchError((err) {
            print(err);
            _domainsCache = [];
          });
        } catch (e) {
          print(e);
          _domainsCache = [];
        }*/

        //_domainsCache = await _getDomains();
        //__setColor(color);
      }

  factory Shlink.fromJson(Map<String, dynamic> json) => _$ShlinkFromJson(json);
  Map<String, dynamic> toJson() => _$ShlinkToJson(this);

  /// history:  Will return a history of all links on the server or locally stored if no internet is available
  @override
  Future<List<ShortUrl>> history() async {
    // print(host);
    try{
      return await refreshHistory();
    } catch (e) {
      //try to get local history
      try {
        var db = getDrift();
        return await (db.select(db.dBShortUrl)..where((tbl) => tbl.serviceId.equals(id))).get();
      } catch (e) {
        throw e;
      }
    }
  }

  

  /// refreshHistory: Will update the history from the server
  @override
  Future<List<ShortUrl>> refreshHistory() async {
    try {
      List<ShlinkAPI.ShortUrl> urls = await _shlinkAPI.list();
      //_shlinkAPI.listVisits(shortCode)
      final historyList = urls.map((url) {
        return url.toShortUrl(service: this);
      }).toList();
      //historyCache = historyList;
      var db = getDrift();

      //delete all old history
      await db.transaction(() async {
        // await db.batch((batch) {
        //     batch.deleteWhere(db.dBShortUrl, (tbl) => tbl.serviceId.equals(id));
        // });
        await (db.delete(db.dBShortUrl)..where((tbl) => tbl.serviceId.equals(id))).go();
        await db.batch((batch) {
          batch.insertAll(db.dBShortUrl, historyList.map((e) => e.toDB()));
        });
      });


      //batch insert into db
      
      return historyList;
    } catch (e) {
      if (e.runtimeType == ShlinkAPI.ShlinkException) {
        throw ServiceException.fromShlinkException(
            e as ShlinkAPI.ShlinkException);
      }
      throw e;
    }
    // try {
    //   var historyBox = Hive.box<ShortUrl>("history");
    //   List<ShortUrl> urls = await history();
    //   print("refreshedHistory: ${urls.length}");
    //   urls.forEach((e) {
    //     historyBox.put(e.shortUrl.toString(), e);
    //     //print(e.shortUrl.toString());
    //   });

    //   return true;
    // } catch (e) {
    //   if (e.runtimeType == ShlinkAPI.ShlinkException) {
    //     throw ServiceException.fromShlinkException(
    //         e as ShlinkAPI.ShlinkException);
    //   }
    //   throw e;
    // }
  }

  /// Shorten:  Will shorten a link using the Shlink service
  @override
  Future<ShortUrl> shorten(Uri link, {String? slug}) async {
    try {
      ShlinkAPI.ShortUrl short;
      if (slug == null) {
        // TODO: UPDATE Shlink PACKAGE with null saftey
        short = await _shlinkAPI
            .create(new ShlinkAPI.CreateShortURL(link.toString()));
      } else {
        short = await _shlinkAPI.create(
            new ShlinkAPI.CreateShortURL(link.toString(), customSlug: slug));
      }

      ShortUrl newShort = short.toShortUrl(service: this); //ShortUrl.fromShlinkAPI(short, service: this);
      // var historyBox = Hive.box<ShortUrl>("history");
      // historyBox.put(newShort.shortUrl.toString(), newShort);
      await newShort.save();
      return newShort;
    } catch (err) {
      return Future.error(err);
    }
  }

  /** HELPER FUNCTIONS */
  Future<List<Domain>> _getDomains() async {
    try {
      final res = await http.get(Uri.https(host.authority, 'rest/v2/domains'),
          headers: {"X-Api-Key": apiKey});
      if (res.statusCode != 200) {
        Map<String, dynamic> errRes = jsonDecode(res.body);
        return Future.error(ServiceException(
            httpStatus: res.statusCode,
            httpBody: res.body,
            title: errRes["title"],
            type: errRes["type"],
            detail: errRes["detail"]));
      }
      return ShlinkGetDomains.fromJson(jsonDecode(res.body)).toDomainList();
    } catch (err) {
      return Future.error(err);
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
            timezone: e.visitLocation.timezone);
      }
      return ShortUrlVisit(
          location: visitLocation,
          referrer: e.referer,
          userAgent: e.userAgent,
          date: e.date,
          shortUrlId: shortUrl.id,
      );
    }).toList();
    return normalVisits;
    /*} catch (err) {
      return Future.error(err);
    }*/
  }

  @override
  Future<Health> health() async {
    try {
      ShlinkAPI.Health rawhealth = await _shlinkAPI.checkHealth();
      //int status = (rawhealth.status=="pass")?200:
      return Health(statusCode: 200, version: rawhealth.version);
    } catch (e) {
      if (e.runtimeType == ShlinkAPI.ShlinkException) {
        throw ServiceException.fromShlinkException(
            e as ShlinkAPI.ShlinkException);
      }
      throw e;
    }
  }


}
