import 'package:shlink_app/types/SupportedFeatures.dart';

import 'ShortUrl.dart';

class Service {
  final String apiKey;

  final Uri host;

  final String name;

  final DateTime dayAdded;

  final SupportedFeatures features;

  Service({this.host, this.name, this.dayAdded, this.features, this.apiKey});

  Future<List<ShortUrl>> history() async {
    throw UnimplementedError();
  }

  
  /// Shorten:  Will shorten a link using the Shlink service
  Future<ShortUrl> shorten(String link, {String slug}) async {
    return null;
  }
}

