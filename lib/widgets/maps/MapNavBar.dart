import 'dart:ui';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/widgets/short_url_card.dart';

class MapNavBar extends StatelessWidget {
  ShortUrl shortUrl;
  Color getBackgroundColor() {
    if (!kIsWeb) {
      // is not web
      if (Platform.isIOS) {
        // ios views be broken
        return (Get.isDarkMode)
            ? Colors.grey.shade900.withOpacity(0.9)
            : Colors.grey.shade200.withOpacity(0.9);
      }
    }

    return (Get.isDarkMode)
        ? Colors.grey.shade900.withOpacity(0.5)
        : Colors.grey.shade200.withOpacity(0.4);
    ;
  }

  MapNavBar({required this.shortUrl});

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
                  color: getBackgroundColor(),
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
                    ShortUrlCard(shortUrl)
                  ],
                )))));
  }
}
