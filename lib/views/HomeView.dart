import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/widgets/history/history_list.dart';

import 'package:shlink_app/widgets/shortener_card.dart';
import 'package:shlink_app/widgets/shortish_text_logo.dart';

class HomeView extends StatelessWidget {
  final HistoryListController historyListController =
      new HistoryListController();

  double maxWidth = 1000;

  HomeView() {}
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* return SingleChildScrollView(

      child: */
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 50, right: 50),
          alignment: Alignment.topLeft,
          child: ShortishTextLogo(
            style: TextStyle(fontSize: 50),
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.only(left: 25, right: 25),
          child: new ShortenerCard(),
        ),
        Container(
            padding: EdgeInsets.only(top: 15, bottom: 5, left: 25, right: 25),
            child: Text(
              "Recents",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )),
        Flexible(
            child: Container(
          //maxWidth: 800,
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.only(left: 25, right: 25),
          child: new HistoryList(
            controller: historyListController,
            length: 3,
          ),
        ))
      ],
    );
  }
}
