import 'dart:ui';

import 'package:shlink_app/types/Domain.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/types/SupportedFeatures.dart';

import '../ShortUrl.dart';
import 'ServiceType.dart';

class Service {
  final String? apiKey;

  final Uri? host;

  final List<Domain>? domains;

  final String name;

  final DateTime? dayAdded;

  final SupportedFeatures features;

  final ServiceType? type;

  final List<ShortUrl>? historyCache;

  final bool disabled;

  final Color? color;

  Service(
      {this.host,
      required this.name,
      this.dayAdded,
      required this.features,
      this.apiKey,
      this.type,
      this.domains,
      this.historyCache,
      this.disabled = false,
      this.color});

  Future<List<ShortUrl>> history() async {
    throw UnimplementedError();
  }

  Future<bool> refreshHistory() async {
    throw UnimplementedError();
  }

  /// Shorten:  Will shorten a link using the Shlink service
  Future<ShortUrl> shorten(Uri link, {String? slug}) async {
    throw UnimplementedError();
  }

  /// Returns a liat of visits with their location stats
  /// [shortUrl] Uri - the whole link

  Future<List<ShortUrlVisit>> visitStats(ShortUrl shortUrl) async {
    throw UnimplementedError();
  }


  //bool operator ==()
}


class UnsupportedFeatureError extends Error {
  final String? message;
  UnsupportedFeatureError([this.message]);
  String toString() {
    var message = this.message;
    return (message != null)
        ? "UnsupportedFeatureError: $message"
        : "UnsupportedFeatureError";
  }
}