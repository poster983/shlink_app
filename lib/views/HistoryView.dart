import 'package:flutter/material.dart';
import 'package:shlink_app/widgets/history/history_list.dart';


class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      /*mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,*/
      children: [
        Container(
          padding: EdgeInsets.only(top:15, bottom: 5),
          child: Text("History", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 20
          ),)
        ),
        new HistoryList()
      ],
    );
  }
}
