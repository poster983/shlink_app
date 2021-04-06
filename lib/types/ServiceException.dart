import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shlink/shlink.dart' as ShlinkAPI;

class ServiceException implements Exception {
  final String? type;
  final String? title;
  final String? detail;

  final int httpStatus;
  final String? httpBody;

  ServiceException(
      {required this.httpStatus, this.httpBody, this.type, this.title, this.detail});

  factory ServiceException.fromShlinkException(
      ShlinkAPI.ShlinkException exception) {
    return ServiceException(httpStatus: exception.status, httpBody: exception.httpBody,
        type: exception.type, title: exception.title, detail: exception.detail);
  }

  @override
  String toString() =>
      'ServiceException{httpStatus=$httpStatus;type=$type;title=$title;detail=$detail;body=$httpBody}';
}
