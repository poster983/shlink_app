import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:shlink_app/AppTheme.dart';
import 'package:shlink_app/common.dart';
import 'package:hive/hive.dart';
import 'package:shlink_app/controllers/AppController.dart';
import 'package:shlink_app/types/Health.dart';
import 'package:shlink_app/types/services/Shlink.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class ShortishCloud {
  ShortishCloud() {}

  static Future<String> getAPIKey() async {
    http.Response res = await http.get(Uri.parse(DotEnv.dotenv.env["SHORTISH_CLOUD_REGISTER_URL"] ?? ""));
    return res.body;
  }

  static Future<void> newUser() async {
    //final AppController controller = Get.find();
    /*final box = Hive.box("preferences");
    final serverBox = Hive.box("services");*/
    String? key;
    try {
      key = await getAPIKey();
    } catch (e) {
      throw e;
    }
    await importUser(key);
  }

  static Future<void> importUser(String apiKey) async {
    final AppController controller = Get.find();
    final box = Hive.box("preferences");
    final serverBox = Hive.box("services");

    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    Shlink service;
    try {
      service = Shlink(
          host: Uri.parse(DotEnv.dotenv.env["SHORTISH_CLOUD_SHLINK_URL"] ?? ""),
          name: "Shortish Cloud",
          apiKey: apiKey,
          isShortishCloud: true,
          color: AppColors.shortish);
    } catch (e) {
      throw e;
    }
    /*try {
      await service.health();
    } catch (e) {
      throw e;
    }*/

    try {
      await service.refreshHistory();
    } catch (e) {
      throw e;
    }

    serverBox.put("Shortish Cloud", service.toJson());
    

    controller.updateServices();

    
    prefs.setString("shortish_cloud_apikey", apiKey);

    box.put("shortish_cloud_enabled", true);
    box.put("shortish_cloud_apikey", apiKey);

    showSnackBar(text: "Shortish Cloud has been enabled!");
  }
}
