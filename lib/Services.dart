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
      return _serviceFromJson(serv) as Service;
    }).toList();
  }

  static _serviceFromJson(serviceString) {
    switch (serviceString["type"]) {
        case "Shlink":
          return new Shlink.fromJson(serviceString.cast<String, dynamic>());
          break;
        case "GenericREST":
          return new GenericREST.fromJson(serviceString.cast<String, dynamic>());
          break;
        default:
          throw Exception("UNKNOWN SERVICE TYPE");
      }
  }

  static Service? find(String serviceName) {
    final serverBox = Hive.box("services");
    try{
      return _serviceFromJson(serverBox.get(serviceName, defaultValue: null));
    } catch(e) {
      return null;
    }
    
    /*try {
      return list.firstWhere((element) => element.name == serviceName);
    } catch(e) {
      return null;
    }*/
  }

  static void updateHistory() {
    list.forEach((element) {
      element.refreshHistory();
    });
    print("Will update the history");
  }
}
