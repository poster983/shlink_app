import 'package:shlink_app/types/services/GenericREST.dart';
import 'package:shlink_app/types/services/Service.dart';
import 'package:hive/hive.dart';
import 'package:shlink_app/types/services/Shlink.dart';

/// A Class to interface with the saved services
class Services {
  
  Services();

  static List<Service> get list {
    final serverBox = Hive.box("services");
    return serverBox.values.map((serv) {
      switch (serv["type"]) {
        case "Shlink":
          return new Shlink.fromJson(serv.cast<String, dynamic>());
          break;
        case "GenericREST":
          return new GenericREST.fromJson(serv.cast<String, dynamic>());
          break;
        default:
          throw Exception("UNKNOWN SERVICE TYPE");
      }
    }).toList();
  }

  static Service? find(String serviceName) {
    return list.firstWhere((element) => element.name == serviceName,
        orElse: null);
  }

  static void updateHistory() {
    list.forEach((element) {
      element.refreshHistory();
    });
    print("Will update the history");
  }
}
