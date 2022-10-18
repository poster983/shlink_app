import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/types/ShortUrlVisitLocation.dart';
import 'package:uuid/uuid.dart';

part 'ShortUrlVisit.g.dart';

@JsonSerializable(nullable: false)

class ShortUrlVisit {
  //@JsonKey()

  late String id;

  String? referrer;
  DateTime date;
  String? userAgent;
  ShortURLVisitLocation? location;

  bool? potentialBot;

  String shortUrlId;

  ShortUrlVisit({
    String? id,
    this.referrer, 
    required this.date, 
    this.userAgent, 
    this.location, 
    required this.shortUrlId, 
    this.potentialBot
  }) {
    this.id = id ?? const Uuid().v4();
  }

  factory ShortUrlVisit.fromJson(Map<String, dynamic> json) =>
      _$ShortUrlVisitFromJson(json);
  Map<String, dynamic> toJson() => _$ShortUrlVisitToJson(this);



  //MARK: DB
  ShortUrlVisit.fromDB({
    required this.id,
    required this.referrer,
    required this.date,
    required this.userAgent,
    required this.shortUrlId,
    required this.potentialBot,

    //Location
    String? locationCountry,
    String? locationRegion,
    String? locationCity,
    String? locationTimezone,
    double? locationLatitude,
    double? locationLongitude,
  }) {

    if(locationLatitude !=null && locationLongitude != null) {
      this.location = ShortURLVisitLocation(
        coordinates: LatLng(locationLatitude, locationLongitude),
        country: locationCountry,
        region: locationRegion,
        city: locationCity,
        timezone: locationTimezone,
      );
    }


  }

  //get ClickDeviceType device
}

/*enum ClickDeviceType {

}*/


