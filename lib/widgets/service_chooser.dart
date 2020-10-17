import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shlink_app/types/Service.dart';

import '../Services.dart';

class ServiceChooser extends StatefulWidget {
  ServiceChooser({Key key}) : super(key: key);

  @override
  _ServiceChooserState createState() => _ServiceChooserState();
}

class _ServiceChooserState extends State<ServiceChooser> {
  Services services = new Services();
  List<Service> serviceList;
  Service dropdownValue;
  @override
  void initState() {
    super.initState();
    //dropdownValue = services.list[0];

  }
  
  @override
  Widget build(BuildContext context) {
    serviceList = services.list;
    
    return DropdownButton<Service>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Get.theme.textTheme.button.color),
      underline: Container(
        height: 2,
        color: Get.theme.accentColor,
      ),
      onChanged: (Service newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: serviceList.map<DropdownMenuItem<Service>>((Service value) {
        if(dropdownValue == null) {
          dropdownValue = serviceList[0];
        }
        return DropdownMenuItem<Service>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }

}