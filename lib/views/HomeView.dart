import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shlink_app/AppTheme.dart';
import 'package:shlink_app/Services.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/services/ServiceType.dart';
import 'package:shlink_app/widgets/history/history_list.dart';

import 'package:shlink_app/widgets/shortener_card.dart';
import 'package:shlink_app/widgets/shortish_text_logo.dart';
import 'package:uuid/uuid.dart';

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
          padding: EdgeInsets.only(
              top: 35 + MediaQuery.of(context).padding.top,
              bottom: 25,
              left: AppTheme.padding,
              right: AppTheme.padding),
          alignment: Alignment.topLeft,
          child: ShortishTextLogo(
            style: TextStyle(fontSize: (Get.width > 400) ? 50 : 40),
          ),
        ),
        /*CupertinoButton(
            child: Text("Fill Fake History"),
            onPressed: () {
              final hist = Hive.box<ShortUrl>('history');
              for (int x = 0; x < 100; x++) {
                var url = ShortUrl(
                    longUrl: Uri.parse("https://josephhassell.dev"),
                    shortUrl: Uri.parse("https://utd.link/test"),
                    slug: "test",
                    dateCreated: DateTime.now(),
                    serviceType: ServiceType.GenericREST,
                    serviceName: "is.gd");

                hist.put(Uuid().v4(), url);
              }
            }),*/
        Container(
          //CARD
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.only(left: AppTheme.padding, right: AppTheme.padding),
          child: new ShortenerCard(),
        ),
        Container(
          // RECENTS
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.only(top: 15, bottom: 5, left: AppTheme.padding, right: AppTheme.padding),
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
        Flexible(
            // HISTORY LIST
            child: Container(
          //maxWidth: 800,
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: EdgeInsets.only(left: AppTheme.padding, right: AppTheme.padding),
          child: new HistoryList(
            controller: historyListController,
            length: 3,
          ),
        ))
      ],
    );
  }
}
