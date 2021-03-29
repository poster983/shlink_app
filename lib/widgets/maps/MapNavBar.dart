import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/services/ServiceType.dart';
import 'package:shlink_app/widgets/short_url_card.dart';

class MapNavBar extends StatelessWidget {
  MapNavBar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: (Get.isDarkMode)
                          ? Colors.grey.shade800.withOpacity(0.4)
                          : Colors.grey.shade200.withOpacity(0.5),
                    ),
                    child: SizedBox(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: BackButton(
                            onPressed: () {
                              
                              if (Get.previousRoute == "") {
                                Get.offAllNamed("/");
                              } else {
                                Get.back();
                              }
                            },
                          ),
                        ),
                        ShortUrlCard(ShortUrl(
                            longUrl: Uri.parse("https://josephhassell.com"),
                            shortUrl: Uri.parse("https://smol.page/test"),
                            slug: "test",
                            visitCount: 69420,
                            dateCreated: DateTime.now(),
                            serviceName: "Test Service",
                            serviceType: ServiceType.GenericREST))
                      ],
                    )))));
  }
}
