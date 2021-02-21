import 'package:shlink_app/types/services/Service.dart';
import 'package:hive/hive.dart';
import 'package:shlink_app/types/services/Shlink.dart';


/// A Class to interface with the saved services
class Services  {
  final serverBox = Hive.box("services");
  Services();

  List<Service> get list {
    return serverBox.values.map((serv) {

      switch(serv["type"]) {
        case "Shlink": 
          return new Shlink.fromJson(serv.cast<String,dynamic>());
          break;
      }
    }).toList();
  }

  void updateHistory() {
    list.forEach((element) {
      element.refreshHistory();
    });
    print("Will update the history");
  }
}