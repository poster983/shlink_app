import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shlink_app/widgets/history/history_list.dart';

import 'package:shlink_app/widgets/shortener_card.dart';

class HomeView extends StatelessWidget {
  final HistoryListController historyListController =
      new HistoryListController();

  HomeView() {
    
  }
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
        
        new ShortenerCard(),
        Container(
          padding: EdgeInsets.only(top:15, bottom: 5),
          child: Text("Recents", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 20
          ),)
        ),
        
        
        new HistoryList(
            controller: historyListController,
            length: 3,
          ),
        
      ],
    );
  }
}
