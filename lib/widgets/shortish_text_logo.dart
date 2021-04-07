import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/AppTheme.dart';
import 'package:shlink_app/controllers/AppController.dart';
//import 'package:shlink_app/widgets/stroke_text.dart';

class ShortishTextLogo extends StatelessWidget {
  final AppController controller = Get.find();

  final TextStyle? style;
  final String after;
  //final bool outline;

  late TextStyle defaultStyle;
  ShortishTextLogo({this.style, this.after = ""}) {
    defaultStyle = TextStyle(
      fontFamily: "Ubuntu",
      fontWeight: FontWeight.w700,
    ).merge(style);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Color color = (controller.serviceList.length != 0)
          ? controller.serviceList[controller.selectedService.value].color
          : AppColors.shortish;
      return Text(
        "shortish." + after,
        style: TextStyle(
                fontFamily: "Ubuntu", fontWeight: FontWeight.w700, color: color)
            .merge(style),
      );

      /*StrokeText(
        "shortish.",
        style: TextStyle(
                fontFamily: "Ubuntu",
                fontWeight: FontWeight.w700,
        ).merge(style),
        color: color,
        strokeWidth: 0.9,
        strokeColor: (Get.theme!.brightness != Brightness.dark)?Colors.black:Colors.grey,
      );*/
    });
  }
}
