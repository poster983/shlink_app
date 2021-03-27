import 'package:flutter/material.dart';
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
            child: Row(
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
            )));
  }
}
