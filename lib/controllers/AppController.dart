import 'dart:developer';

import 'package:get/get.dart';
import 'package:shlink_app/Services.dart';
import 'package:shlink_app/types/services/Service.dart';
import 'package:shlink_app/types/ShortUrl.dart';

class AppController extends GetxController {
  final services = new Services();
  final serviceList = List<Service>().obs;
  final selectedService = 0.obs;
  //final _newestShortLink = ShortUrl().obs;
  AppController() {
    updateServices();
  }
  void updateServices() {
    selectedService.value = 0;
    serviceList(services.list);
    //inspect(services.list);
    //serviceList. = services.list;
  }

  /*set newestShortLink(ShortUrl link) {
    _newestShortLink.value = link;
  }

  ShortUrl get newestShortLink {
    return _newestShortLink.value;
  }*/
}
