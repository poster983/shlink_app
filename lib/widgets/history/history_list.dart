import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shlink_app/types/ShortUrl.dart';

class HistoryList extends StatefulWidget {
  HistoryList({Key key}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {

  
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text("History:"),),
        ValueListenableBuilder(
          valueListenable: Hive.box<ShortUrl>('history').listenable(),
          builder: (context, box, widget) {
            //Do filtering inside the updated builder
            //TODO: FILTERING
            List<ShortUrl> filteredHistory = box.values.toList();
            print(filteredHistory.length);

            // LIST 
            return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        
                        child: Center(child: Column(children: [
                          Text('${filteredHistory[index].shortUrl}'),
                          Text('${filteredHistory[index].longUrl}'),
                        ]))
                      );
                    }
                  );




          },
        )
      ]
    );
  }


}