import 'package:shlink_app/database/DriftCommon.dart';

import 'Drift.dart';


ShortishDatabase? _db;

Future<void> initDrift() async {
  _db = await constructDb();
}

ShortishDatabase getDrift() {
  if (_db == null) {
    throw Exception("Drift not initialized");
  }
  return _db!;
}