import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/AppTheme.dart';
import 'package:shlink_app/Services.dart';
import 'package:shlink_app/widgets/history/history_list.dart';
import 'package:shlink_app/widgets/shortish_text_logo.dart';

class HistoryView extends StatelessWidget {
  double maxWidth = 1000;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      /*mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,*/
      children: [
        Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: EdgeInsets.only(
                top: 35 + MediaQuery.of(context).padding.top,
                bottom: 25,
                left: AppTheme.padding,
                right: AppTheme.padding),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: ShortishTextLogo(
                    style: TextStyle(fontSize: (Get.width > 400) ? 50 : 25),
                    after: " /history",
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: new IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        Services.updateHistory();
                      }),
                )
              ],
            )),
        Flexible(
            // HISTORY LIST
            child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                padding: EdgeInsets.only(left: AppTheme.padding, right: AppTheme.padding),
                child: new HistoryList()))
      ],
    );
  }
}
