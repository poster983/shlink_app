import 'dart:developer';

import 'package:get/get.dart';
import 'package:shlink_app/Services.dart';
import 'package:shlink_app/types/Service.dart';

class AppController extends GetxController {
  final services = new Services();
  final serviceList = List<Service>().obs;
  final selectedService = 0.obs;
  AppController() {
    updateServices();
  }
  void updateServices() {
    selectedService.value = 0;
    serviceList(services.list);
    inspect(services.list);
    //serviceList. = services.list;
  }
}
