import 'package:flutter/material.dart';
import 'package:shlink_app/widgets/history/history_list.dart';
import 'package:shlink_app/widgets/shortish_text_logo.dart';


class HistoryView extends StatelessWidget {

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
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 50, right: 50),
          alignment: Alignment.topLeft,
          child: ShortishTextLogo(style: TextStyle(fontSize: 50), after: " /history",),
        ),
        new HistoryList()
      ],
    );
  }
}
