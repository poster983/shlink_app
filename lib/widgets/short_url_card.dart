import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:url_launcher/url_launcher.dart';

class ShortUrlCard extends StatelessWidget {
  final ShortUrl shortUrl;
  final DateFormat formatter = DateFormat.yMd().add_jm(); //('yyyy-MM-dd h:m ');

  ShortUrlCard(this.shortUrl);

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Card(
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
            child:  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                // Top Bit
                children: [
                  SelectableText(
                    shortUrl.shortUrl.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () => Clipboard.setData(
                          ClipboardData(text: shortUrl.shortUrl.toString())))
                ],
              ),
              Row(
                // Top Bit
                children: [
                  SelectableText(
                    shortUrl.longUrl.toString(),
                    style: Get.textTheme.subtitle2,
                  ),
                  IconButton(
                      icon: Icon(Icons.open_in_browser),
                      onPressed: () => _launchURL(shortUrl.longUrl.toString()))
                ],
              ),
              //Meta First Row
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text("Visits", textAlign: TextAlign.center,),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text("Date Created", textAlign: TextAlign.center,),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text("Created With", textAlign: TextAlign.center),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text("Domain",textAlign: TextAlign.center),
                  ),

                ],
              ),
              //2nd Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: (shortUrl.visitCount != null)
                        ? Text(shortUrl.visitCount.toString(), textAlign: TextAlign.center,)
                        : Text("No Info", textAlign: TextAlign.center,),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(formatter.format(shortUrl.dateCreated), textAlign: TextAlign.center,),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(shortUrl.serviceName, textAlign: TextAlign.center),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(shortUrl.domain, textAlign: TextAlign.center),
                  ),

                ],
              ),*/

              SizedBox(
                
                child: GridView.count(
                  shrinkWrap: true,
                  //primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  childAspectRatio: 5, //(5 / 1), //width/height
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 0,
                  crossAxisCount: 4,
                  children: <Widget>[
                    Text("Visits", textAlign: TextAlign.center,),
                    Text("Date Created", textAlign: TextAlign.center,),
                    Text("Created With", textAlign: TextAlign.center),
                    Text("Domain",textAlign: TextAlign.center),
                    
                    // 2nd Row 
                    (shortUrl.visitCount != null)
                        ? Text(shortUrl.visitCount.toString(), textAlign: TextAlign.center,)
                        : Text("No Info", textAlign: TextAlign.center,),
                    Text(formatter.format(shortUrl.dateCreated), textAlign: TextAlign.center,),
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

              
                ])
              )
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
