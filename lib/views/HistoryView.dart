import 'package:flutter/material.dart';
import 'package:shlink_app/widgets/history/history_list.dart';


class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      /*mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,*/
      children: [
        new Text("History", textAlign: TextAlign.center),
        new HistoryList()
      ],
    );
  }
}
