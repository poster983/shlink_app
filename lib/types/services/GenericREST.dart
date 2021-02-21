import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:shlink_app/types/SupportedFeatures.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/Domain.dart';
import 'package:shlink_app/types/services/Service.dart';
import 'package:shlink_app/types/services/ServiceType.dart';

part 'GenericREST.g.dart';

@JsonSerializable(nullable: false)
class GenericREST implements Service {
  ServiceType get type => ServiceType.GenericREST;
  set type(t) => {}; // This is stupid.  Why is this required Json Serializable?

  String name;

  DateTime dayAdded;

  Uri host;

  SupportedFeatures get features => new SupportedFeatures();

  List<ShortUrl> historyCache;

  Map<String, String> headers;

  GenericREST({this.host, this.name, this.headers}) {
      dayAdded = new DateTime.now();
      historyCache = List<ShortUrl>();
  }


  @override
  String get apiKey => throw UnimplementedError();
  @override
  List<Domain> get domains => throw UnimplementedError();


  @override
  Future<List<ShortUrl>> history() async {
    return historyCache;
  }

  @override
  Future<bool> refreshHistory() {
    // TODO: implement refreshHistory
    throw UnimplementedError();
  }

  @override
  Future<ShortUrl> shorten(Uri link, {String slug}) {
    // TODO: implement shorten
    throw UnimplementedError();
  }


}