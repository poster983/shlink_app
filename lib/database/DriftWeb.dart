import 'package:drift/web.dart';
import 'package:shlink_app/database/DriftCommon.dart';

Future<ShortishDatabase> constructDb() async {
  return ShortishDatabase(WebDatabase.withStorage(await DriftWebStorage.indexedDbIfSupported("db")));
}
