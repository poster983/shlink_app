import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:shlink_app/Services.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/services/Service.dart';
import 'package:shlink_app/views/VisitsMapView.dart';
import 'package:shlink_app/widgets/ShortUrls/url_slider.dart';
import 'package:url_launcher/url_launcher.dart';

// class ShortUrlCard extends StatelessWidget {
//   final ShortUrl shortUrl;
//   final DateFormat formatter = DateFormat.yMd().add_jm(); //('yyyy-MM-dd h:m ');
//   //final GlobalKey cardKey = new GlobalKey();
//   bool showAnalytics;
//   bool showShareButton = false;
//   bool showTime = false;
//   late Service? service;

//   //Stopwatch stopwatch = new Stopwatch();

//   ShortUrlCard(this.shortUrl, {this.showAnalytics = true}) {
//     /*WidgetsBinding.instance!.addPostFrameCallback((_) {
//       profile();
//     });
//     stopwatch.start();*/
//     service = Services.find(shortUrl.serviceName);
//     //print("Found Service: ${stopwatch.elapsed}");
//     if (service == null) {
//       showAnalytics = false;
//     } else {
//       if (!service!.features.locationAnalytics) {
//         showAnalytics = false;
//       }
//     }

//     if (!kIsWeb) {
//       if (Platform.isAndroid || Platform.isIOS) {
//         showShareButton = true;
//       }
//     }
//   }

//   void _launchURL(url) async =>
//       await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

//   /*Future<void> executeAfterBuild(BuildContext context) async {
//     //cardKey.currentState.
//   }*/

//   /*Future<void> profile() async {
//     print("Card Build Done (${shortUrl.shortUrl.toString()}): ${stopwatch.elapsed}");
//     stopwatch.stop();
//     stopwatch.reset();
//     return;
//   }*/

//   @override
//   Widget build(BuildContext context) {
//     //executeAfterBuild(context);
//     //WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild);
//     //print(Get.width);
//     //Future.delayed(Duration.zero, () => profile());
//     return Container(
//         // border color
//         margin: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//             color: service?.color ?? Colors.red,
//             borderRadius: BorderRadius.circular(4)),
//         child: Container(
//             // Asymetrical border width
//             margin: const EdgeInsetsDirectional.only(
//                 start: 3, end: 3, top: 3, bottom: 6), //margin is stroke
//             decoration: BoxDecoration(
//                 color: Get.theme?.cardColor,
//                 borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(2), bottom: Radius.circular(2))),
//             padding: EdgeInsets.all(16),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Row(
//                 // Top Bit
//                 children: [
//                   Flexible(
//                     child: SelectableText(
//                       shortUrl.shortUrl.toString(),
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontFamily: "Ubuntu",
//                         fontWeight: FontWeight.bold,
//                         color: service?.color ?? Colors.red,
//                       ),
//                     ),
//                   ),
//                   (showShareButton)
//                       ? IconButton(
//                           icon: Icon(Icons.share),
//                           onPressed: () =>
//                               Share.share(shortUrl.shortUrl.toString()))
//                       : IconButton(
//                           icon: Icon(Icons.copy),
//                           onPressed: () => Clipboard.setData(ClipboardData(
//                               text: shortUrl.shortUrl.toString()))),
//                   (showAnalytics)
//                       ? IconButton(
//                           icon: Icon(Icons.analytics),
//                           onPressed: () async {
//                             var visits = await service!.visitStats(shortUrl);
//                             Get.to(() => VisitsMapView(shortUrl, visits));
//                           })
//                       : Container()
//                   /*Flexible(child: Row(children: [
                    
//                   ],)
//                   )*/
//                 ],
//               ),
//               Row(
//                 // Top Bit
//                 children: [
//                   Flexible(
//                       child: SelectableText(
//                     shortUrl.longUrl.toString(),
//                     style: Get.textTheme!.subtitle1,
//                   )),
//                   IconButton(
//                       icon: Icon(Icons.open_in_browser),
//                       onPressed: () => _launchURL(shortUrl.longUrl.toString()))
//                 ],
//               ),

//               //AMAKA's ROW

//               //Info grid
//               LayoutBuilder(builder: (context, constraints) {
//                 //print(constraints.maxWidth);
//                 //print(aspect);

//                 if (constraints.maxWidth > 600) {
//                   // USE smaller design for bigger devices
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         "Created: ${formatter.format(shortUrl.dateCreated)}",
//                         style: TextStyle(fontSize: 14),
//                       ),
//                       Text(
//                           "Clicks: ${(shortUrl.visitCount != null) ? shortUrl.visitCount.toString() : "No Info"}",
//                           style: TextStyle(fontSize: 14)),
//                       CupertinoButton(
//                           child:
//                               Text("See More", style: TextStyle(fontSize: 14, color: service?.color ?? Colors.red)),
//                           onPressed: () {})
//                     ],
//                   );
//                 }

//                 /// DESIGN FOR SMAlL DEVICES
//                 double aspect = 2;
//                 print(constraints.maxWidth);
//                 if (constraints.maxWidth >= 380) {
//                   aspect = 5;
//                 } else if (constraints.maxWidth > 300) {
//                   aspect = 3;
//                 }
//                 //print(aspect);

//                 return SizedBox(
//                     child: GridView.count(
//                         shrinkWrap: true,
//                         //primary: false,
//                         physics: NeverScrollableScrollPhysics(),
//                         padding: const EdgeInsets.all(0),
//                         childAspectRatio: aspect, //width/height
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 0,
//                         crossAxisCount: 3,
//                         children: <Widget>[
//                       Text(
//                         "Visits",
//                         textAlign: TextAlign.center,
//                       ),
//                       Text(
//                         "Created",
//                         textAlign: TextAlign.center,
//                       ),
//                       Text("Created With", textAlign: TextAlign.center),
//                       //Text("Domain", textAlign: TextAlign.center),

//                       // 2nd Row
//                       (shortUrl.visitCount != null)
//                           ? Text(
//                               shortUrl.visitCount.toString(),
//                               textAlign: TextAlign.center,
//                             )
//                           : Text(
//                               "No Info",
//                               textAlign: TextAlign.center,
//                             ),
//                       Text(
//                         formatter.format(shortUrl.dateCreated),
//                         textAlign: TextAlign.center,
//                       ),
//                       Text(shortUrl.serviceName, textAlign: TextAlign.center),
//                       //Text(shortUrl.domain, textAlign: TextAlign.center),

//                       /*Center(
//                       child: Text("Visits"),
//                     ),
//                     Center(
//                       child: Text("Date Created"),
//                     ),
//                     Center(
//                       child: Text("Created With"),
//                     ),
//                     Center(
//                       child: Text("Domain"),
//                     ),*/
//                     ]));
//               }),
//             ])
//             /*Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
                  

//                   children: [
//                     SelectableText(shortUrl.longUrl.toString(),
//                         onTap: () => _launchURL(shortUrl.longUrl.toString())),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     SelectableText(shortUrl.shortUrl.toString(),
//                         onTap: () => _launchURL(shortUrl.shortUrl.toString())),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     (shortUrl.visitCount != null)
//                         ? Text("Visits: ${shortUrl.visitCount}")
//                         : Container(),
//                     Text(
//                         "Date Created: ${formatter.format(shortUrl.dateCreated)}"),
//                     Text("Created With: ${shortUrl.serviceName}"),
//                     Text("Domain: ${shortUrl.domain}")
//                   ],
//                 ),
//               ],
//             )*/
//             ));
//   }
// }




class ShortUrlCard extends StatelessWidget {
  const ShortUrlCard(this.shortUrl, {super.key, this.showShareButton = true, this.showAnalytics = true});
  final ShortUrl shortUrl;
  final bool showShareButton;
  final bool showAnalytics;

//   @override
//   State<ShortUrlCard> createState() => _ShortUrlCardState();
// }

// class _ShortUrlCardState extends State<ShortUrlCard> {

  

  @override
  Widget build(BuildContext context) {
    String longDomain = shortUrl.longUrl.host;
    String longPath = shortUrl.longUrl.path;
    if (longDomain.startsWith("www.")) {
      longDomain = longDomain.substring(4);
    }
    

    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.resolveFrom(context).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        //Top Row
        Flexible(flex: 2, child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          //Favicon
          Flexible(flex: 1, child: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(90),
              ),
            )
          ],),
          ),
          
          //Long Url
          Flexible(flex: 10, child: Center(child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(longDomain, maxLines: 1, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              AutoSizeText(longPath, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
            ],
          ))),
          


        ]),),

        Flexible(flex: 1, child:
        //Bottom Row
        Row(children: [
          SizedBox(),
          // Expanded( child: ,),
           Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: URLSlider(url: shortUrl.shortUrl, slideIcon: CupertinoIcons.link,)),
            SizedBox()
          // Expanded(child: SizedBox.expand(),),
        ]),
        )
         



      ],)
    );
  }
}