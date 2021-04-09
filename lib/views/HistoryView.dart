import 'package:flutter/material.dart';
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
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 50, right: 50),
          alignment: Alignment.topLeft,
          child: ShortishTextLogo(style: TextStyle(fontSize: 50), after: " /history",),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: new HistoryList()
        )
      ],
    );
  }
}
