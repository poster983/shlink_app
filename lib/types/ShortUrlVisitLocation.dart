import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:shlink_app/types/JSONTypeConverters.dart';

part 'ShortUrlVisitLocation.g.dart';

@JsonSerializable(nullable: false)
class ShortURLVisitLocation {
  String? country;
  String? region;
  String? city;
  
  @JsonKey(
      fromJson: JSONTypeConverters.latLngFromJSON,
      toJson: JSONTypeConverters.latLngToJSON)
  LatLng coordinates;

  String? timezone;

  ShortURLVisitLocation({required this.coordinates, this.city, this.region, this.country, this.timezone}) {

  }

  factory ShortURLVisitLocation.fromJson(Map<String, dynamic> json) => _$ShortURLVisitLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ShortURLVisitLocationToJson(this);
}
