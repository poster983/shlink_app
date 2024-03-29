import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/widgets/ShortUrls/short_url_card.dart';
import 'package:shlink_app/widgets/ShortUrls/short_url_card_condensed.dart';
import 'package:shlink_app/widgets/ShortUrls/short_url_card_condensed_labels.dart';

// ignore: must_be_immutable
class HistoryList extends StatefulWidget {
  HistoryList({Key? key, this.controller, this.length}) : super(key: key);

  HistoryListController? controller;
  int? length;

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  int Function(ShortUrl, ShortUrl) sortFunction = (a, b) {
    // default sort function
    return a.dateCreated.isAfter(b.dateCreated) ? -1 : 1;
  };

  bool Function(ShortUrl) filterFunction = (element) {
    return true;
  };

  late int? length;

  Stopwatch stopwatch = new Stopwatch();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    length = widget.length;
    if (widget.controller == null) {
      widget.controller = new HistoryListController();
    }
    widget.controller!.sort = (int Function(ShortUrl, ShortUrl) _sortFunction) {
      setState(() {
        sortFunction = _sortFunction;
      });
    };
    widget.controller!.filter = (bool Function(ShortUrl) _filterFunction) {
      setState(() {
        filterFunction = _filterFunction;
      });
    };
    /*widget.controller.length = (int _length) {
      setState(() {
        length = _length;
      });
    };*/
    //dropdownValue = services.list[0];
  }



  @override
  Widget build(BuildContext context) {



    return ValueListenableBuilder(
      valueListenable: Hive.box<ShortUrl>('history').listenable(),
      builder: (context, Box<ShortUrl> box, widget) {
        //print("Got History: ${stopwatch.elapsed}");
        //Do filtering inside the updated builder
        List<ShortUrl> filteredHistory = box.values.toList();
        filteredHistory = filteredHistory.where(filterFunction).toList();
        filteredHistory.sort(sortFunction);
        if (length != null) {
          if (filteredHistory.length > length!) {
            filteredHistory = filteredHistory.sublist(0, length);
          }
        }
        //print("Filtered: ${stopwatch.elapsed}");
        //print("Card Count:  ${filteredHistory.length}");

        // LIST
        return Stack(

            // mainAxisSize: MainAxisSize.min,
            children: [
              

              ListView.builder(
                padding: EdgeInsets.only(top: 39),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                //padding: const EdgeInsets.all(8)
                // itemExtent: 40,
                // cacheExtent: 
                // clipBehavior: Clip.none,
                itemCount: filteredHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  //return ShortUrlCard(filteredHistory[index]);
                  return ShortUrlCardCondensed(filteredHistory[index]);
                  /*return Container(
                          //height: 50,

                          child: Center(
                              child: Column(children: [
                        Text('${filteredHistory[index].shortUrl}'),
                        Text('${filteredHistory[index].longUrl}'),
                      ])));*/
                }),

                const ShortUrlCardCondensedLabels(),
            ],

        );
        
        
      },
    );
  }
}

class HistoryListController {
  late void Function(bool Function(ShortUrl))? filter;
  late void Function(int Function(ShortUrl, ShortUrl))? sort;
  late void Function(int)? length;

  //HistoryListController({this.filter, this.sort, this.length});

  void dispose() {
    //Remove any data that's will cause a memory leak/render errors in here
    filter = null;
    sort = null;
    length = null;
    //functionThatReturns = null;
  }
}
