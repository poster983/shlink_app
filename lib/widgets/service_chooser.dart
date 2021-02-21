import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:shlink_app/controllers/AppController.dart';
import 'package:shlink_app/types/services/Service.dart';

import '../Services.dart';

class ServiceChooser extends StatefulWidget {
  ServiceChooser({Key key}) : super(key: key);

  @override
  _ServiceChooserState createState() => _ServiceChooserState();
}

class _ServiceChooserState extends State<ServiceChooser> {
  final AppController controller = Get.find();
  Services services = new Services();
  List<Service> serviceList;
  Service dropdownValue;
  @override
  void initState() {
    super.initState();
    serviceList = services.list;
    //dropdownValue = services.list[0];
  }

  update() {
    setState(() {
      serviceList = services.list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton<Service>(
          value: (controller.serviceList.length == 0)?null:controller.serviceList[controller.selectedService.value],
          hint: Text("Select Service"),
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
              controller.selectedService.value = controller.serviceList
                  .indexWhere((element) => newValue == element);
            });
          },
          items: controller.serviceList
              .map<DropdownMenuItem<Service>>((Service value) {
            if (dropdownValue == null) {
              dropdownValue =
                  controller.serviceList[controller.selectedService.value];
            }
            return DropdownMenuItem<Service>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
        ));
  }
}

/* Widget build(BuildContext context) {
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
        if (dropdownValue == null) {
          dropdownValue = serviceList[0];
        }
        return DropdownMenuItem<Service>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
 */
