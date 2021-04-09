import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/Services.dart';
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
          padding: EdgeInsets.only(top: 35, bottom: 25, left: 50, right: 50),
          alignment: Alignment.topLeft,
          child: ShortishTextLogo(
            style: TextStyle(fontSize: (Get.width > 400)?50:40),
          ),
        ),
        Container( //CARD
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.only(left: 25, right: 25),
          child: new ShortenerCard(),
        ),
        Container( // RECENTS
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.only(top: 15, bottom: 5, left: 25, right: 25),
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    child: Text(
                  "Recents",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )),
              ),
              Align(
                alignment: Alignment.topRight,
                child: new IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      Services.updateHistory();
                    }),
              )
            ],
          ),
        ),
        Flexible( // HISTORY LIST
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
