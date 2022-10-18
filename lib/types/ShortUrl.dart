import 'dart:ui';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:shlink/shlink.dart' as ShlinkAPI;
import 'package:shlink_app/Log.dart';
import 'package:shlink_app/Services.dart';
import 'package:shlink_app/database/DriftCommon.dart';
import 'package:shlink_app/database/DriftGetter.dart';
import 'package:shlink_app/types/JSONTypeConverters.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/types/services/Service.dart';
import 'package:shlink_app/types/services/ServiceType.dart';
import 'package:uuid/uuid.dart';

// import "drift"

part 'ShortUrl.g.dart';


@JsonSerializable()
class ShortUrl {

  late String id;

  String? title;

  late Uri longUrl;

  late Uri shortUrl;

  final String slug; 

  final DateTime dateCreated;

  int? visitCount;
  
  // late List<String> tags;

  // late ServiceType serviceType;
  
  // @JsonKey(
  //     fromJson: JSONTypeConverters.colorFromJSON,
  //     toJson: JSONTypeConverters.colorToJSON)
  // Color color;

  String? notes;

  //Joined and Linked Data
  @JsonKey(ignore: true)
  List<ShortUrlVisit>? _visitsCache;

  ///Loads and cashes the visits for this short url
  ///
  ///If you with to update the visits, call [loadVisits] again
  Future<List<ShortUrlVisit>> get visits async {
    if(_visitsCache == null) {
      await loadVisits();
    }
    return _visitsCache!;
  }
  // List<ShortUrlVisit> visits = [];

  late String serviceId;
  // Service? service;

  @JsonKey(ignore: true)
  Service? get service {
    return Services.find(serviceId);
  }




  String get domain {
    return shortUrl.host;
  }

  ShortUrl({
      String? id,
      required this.longUrl,
      required this.shortUrl,
      required this.slug,
      required this.dateCreated,
      this.visitCount,
      List<String>? tags,
      // required this.serviceType,
      String? serviceId,
      Service? service,
      this.title,


      this.notes
      // required this.serviceName
    }) {
      this.id = id ?? const Uuid().v4();
      if(service == null && serviceId == null) {
        throw ArgumentError("Either service or serviceId must be provided");
      }

      if(service != null) {
        // this.service = service;
        this.serviceId = service.name;
        // if(color == null) {
        //   color = service.color;
        // }
      } else {
        this.serviceId = serviceId!;
      }
      // this.tags = tags ?? [];
    }



  // factory ShortUrl.fromShlinkAPI(ShlinkAPI.ShortUrl short, {String? serviceId, Service? service}) {
    
  //   return ShortUrl(
  //       longUrl: Uri.parse(short.longUrl),
  //       shortUrl: Uri.parse(short.shortUrl),
  //       slug: short.shortCode,
  //       dateCreated: short.dateCreated,
  //       visitCount: short.visitsCount,
  //       tags: short.tags,
  //       // serviceType: ServiceType.Shlink,
  //       serviceId: serviceId,
  //       service: service,
  //     );
  // }

  factory ShortUrl.fromJson(Map<String, dynamic> json) =>
      _$ShortUrlFromJson(json);
  Map<String, dynamic> toJson() => _$ShortUrlToJson(this);


  //MARK: Load Links
  /// Loads all the visits for this link.
  /// Can be accessed via [visits]
  Future<void> loadVisits() async {
    var service = this.service;
    if(service == null) {
      throw Exception("Service not found");
    }
    if(!service.features.clickAnalytics && !service.features.locationAnalytics) {
      _visitsCache = [];
      Log.w("Service does not support click analytics or location analytics.  Returning empty list");
      return;
    }

    _visitsCache = await service.visitStats(this);
  }

  

  //MARK: DB

  ShortUrl.fromDB({
    required String longUrl,
    required String shortUrl,
    required this.slug,
    required this.dateCreated,
    required this.visitCount,
    required this.serviceId,
    required this.notes,
    required this.id,
    required this.title,
  }) {
    this.longUrl = Uri.parse(longUrl);
    this.shortUrl = Uri.parse(shortUrl);
    // this.serviceType = ServiceType.values.firstWhere((element) => element.toString() == serviceType);
    // this.color = Color(color);
  }


  DBShortUrlCompanion toDB() {
    return DBShortUrlCompanion.insert(
      id: id, 
      longUrl: longUrl.toString(), 
      shortUrl: shortUrl.toString(), 
      slug: slug, 
      dateCreated: dateCreated, 
      serviceId: serviceId,
      visitCount: drift.Value(visitCount),
      notes: drift.Value(notes),
      title: drift.Value(title),
    );
  }


  //MARK: Operations

  ///Saves the link to the database
  Future<void> save() async {
    var db = getDrift();
    await db.into(db.dBShortUrl).insertOnConflictUpdate(toDB());
    return;
  }


  
}




extension ShortUrlConverter on ShlinkAPI.ShortUrl {
  ShortUrl toShortUrl({String? serviceId, Service? service}) {
    return ShortUrl(
        longUrl: Uri.parse(longUrl),
        shortUrl: Uri.parse(shortUrl),
        slug: shortCode,
        dateCreated: dateCreated,
        visitCount: visitsCount,
        tags: tags,
        serviceId: serviceId,
        service: service,
      );
  }

}