import 'package:json_annotation/json_annotation.dart';
import 'package:shlink_app/types/ShortUrlVisitLocation.dart';

part 'ShortUrlVisit.g.dart';

@JsonSerializable(nullable: false)

class ShortUrlVisit {
  //@JsonKey()
  String? referer;
  DateTime? date;
  String? userAgent;
  ShortURLVisitLocation? location;

  ShortUrlVisit({this.referer, this.date, this.userAgent, this.location}) {

  }

  factory ShortUrlVisit.fromJson(Map<String, dynamic> json) =>
      _$ShortUrlVisitFromJson(json);
  Map<String, dynamic> toJson() => _$ShortUrlVisitToJson(this);

  //get ClickDeviceType device
}

/*enum ClickDeviceType {

}*/


