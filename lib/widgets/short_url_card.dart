import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shlink_app/Services.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/views/VisitsMapView.dart';
import 'package:url_launcher/url_launcher.dart';

class ShortUrlCard extends StatelessWidget {
  final ShortUrl shortUrl;
  final DateFormat formatter = DateFormat.yMd().add_jm(); //('yyyy-MM-dd h:m ');
  final GlobalKey cardKey = new GlobalKey();
  final bool showAnalytics;

  ShortUrlCard(this.shortUrl, {this.showAnalytics = true });

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  /*Future<void> executeAfterBuild(BuildContext context) async {
    //cardKey.currentState.
  }*/

  @override
  Widget build(BuildContext context) {
    //executeAfterBuild(context);
    //WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild);
    //print(Get.width);
    return Card(
        key: cardKey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        //clipBehavior:
        elevation: 2,
        child: Padding(
            padding: EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                // Top Bit
                children: [
                  Flexible(child: 
                    SelectableText(
                      shortUrl.shortUrl.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () => Clipboard.setData(
                          ClipboardData(text: shortUrl.shortUrl.toString()))),
                  (showAnalytics)?IconButton(
                      icon: Icon(Icons.analytics),
                      onPressed: () async {
                        var visits = await Services.find(shortUrl.serviceName)!
                            .visitStats(shortUrl);
                        Get.to(() => VisitsMapView(shortUrl, visits));
                      }):Container()
                  /*Flexible(child: Row(children: [
                    
                  ],)
                  )*/
                  
                ],
              ),
              Row(
                // Top Bit
                children: [
                  Flexible(child: SelectableText(
                    shortUrl.longUrl.toString(),
                    style: Get.textTheme!.subtitle2,
                  )),
                  IconButton(
                      icon: Icon(Icons.open_in_browser),
                      onPressed: () => _launchURL(shortUrl.longUrl.toString()))
                ],
              ),

              //Info grid
              LayoutBuilder(builder: (context, constraints) {
                double aspect = 0.8;
                if (constraints.maxWidth > 260) {
                  aspect = (constraints.maxWidth > 600) ? 10 : 2;
                } else if (constraints.maxWidth > 260) {
                  aspect = 1;
                }
                //print(constraints.maxWidth);
                //print(aspect);

                return SizedBox(
                    child: GridView.count(
                        shrinkWrap: true,
                        //primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        childAspectRatio: aspect, //width/height
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0,
                        crossAxisCount: 4,
                        children: <Widget>[
                      Text(
                        "Visits",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Date Created",
                        textAlign: TextAlign.center,
                      ),
                      Text("Created With", textAlign: TextAlign.center),
                      Text("Domain", textAlign: TextAlign.center),

                      // 2nd Row
                      (shortUrl.visitCount != null)
                          ? Text(
                              shortUrl.visitCount.toString(),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "No Info",
                              textAlign: TextAlign.center,
                            ),
                      Text(
                        formatter.format(shortUrl.dateCreated),
                        textAlign: TextAlign.center,
                      ),
                      Text(shortUrl.serviceName, textAlign: TextAlign.center),
                      Text(shortUrl.domain, textAlign: TextAlign.center),

                      /*Center(
                      child: Text("Visits"),
                    ),
                    Center(
                      child: Text("Date Created"),
                    ),
                    Center(
                      child: Text("Created With"),
                    ),
                    Center(
                      child: Text("Domain"),
                    ),*/
                    ]));
              }),
            ])
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  

                  children: [
                    SelectableText(shortUrl.longUrl.toString(),
                        onTap: () => _launchURL(shortUrl.longUrl.toString())),
                    SizedBox(
                      height: 10,
                    ),
                    SelectableText(shortUrl.shortUrl.toString(),
                        onTap: () => _launchURL(shortUrl.shortUrl.toString())),
                  ],
                ),
                Column(
                  children: [
                    (shortUrl.visitCount != null)
                        ? Text("Visits: ${shortUrl.visitCount}")
                        : Container(),
                    Text(
                        "Date Created: ${formatter.format(shortUrl.dateCreated)}"),
                    Text("Created With: ${shortUrl.serviceName}"),
                    Text("Domain: ${shortUrl.domain}")
                  ],
                ),
              ],
            )*/
            ));
  }
}
