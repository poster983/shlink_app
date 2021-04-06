class Health {
  final int statusCode;
  final String? version;



  bool get ok {
    return statusCode == 200;
  }

  bool get unavailable {
    return statusCode == 0;
  }

  Health({
    required this.statusCode,
    this.version
  });
}
