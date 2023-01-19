import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:shlink_app/Log.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/views/VisitsMapView.dart';
import 'package:shlink_app/widgets/ShortUrls/short_url_stats.dart';
import 'package:shlink_app/widgets/ShortUrls/statistics/visit_device_type_chart.dart';
import 'package:shlink_app/widgets/ShortUrls/favicon_viewer.dart';
import 'package:shlink_app/widgets/charts/NeumorphicBarChart.dart';
import 'package:url_launcher/url_launcher.dart';

class ShortUrlCardCondensed extends StatefulWidget {
  const ShortUrlCardCondensed(this.shortUrl, {
    super.key,
    this.openGroup,
    this.opened = false
  });

  final ShortUrl shortUrl;

  final String ? openGroup;

  final bool opened;

  @override
  State < ShortUrlCardCondensed > createState() => _ShortUrlCardCondensedState();
}

class _ShortUrlCardCondensedState extends State < ShortUrlCardCondensed > {

  final transitionDuration =
  const Duration(milliseconds: 200);
  bool isOpen = false;

  late Color color = widget.shortUrl.service?.color ?? CupertinoColors.systemBlue.resolveFrom(context);

  @override
  void initState() {
    isOpen = widget.opened;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      // drawSurfaceAboveChild: false,

      duration: transitionDuration,
      curve: Curves.easeInOut,
      margin: isOpen ? EdgeInsets.symmetric(vertical: 10, horizontal: 10) : EdgeInsets.zero,
      style: NeumorphicStyle(
        // border: NeumorphicBorder(
        //   color: color,
        //   width: isOpen?2:0
        // ),
        shape: NeumorphicShape.flat, //NeumorphicShape.convex,//isOpen?NeumorphicShape.convex:NeumorphicShape.concave,
        boxShape: isOpen ? NeumorphicBoxShape.roundRect(BorderRadius.circular(10)) : NeumorphicBoxShape.roundRect(BorderRadius.circular(0)),
        depth: isOpen ? 50 : 0,
      ),
      // decoration: BoxDecoration(
      //   color: CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context),
      //   borderRadius: isOpen?BorderRadius.circular(10):BorderRadius.zero,
      //   boxShadow: isOpen?[
      //     BoxShadow(
      //       color: CupertinoColors.systemGrey.resolveFrom(context).withOpacity(0.2),
      //       spreadRadius: 3,
      //       blurRadius: 5,
      //       offset: const Offset(0, 3), // changes position of shadow
      //     ),
      //   ]:[],
      // ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: AnimatedCrossFade(
          firstChild: condensedView(context),
          secondChild: expandedView(context),
          duration: transitionDuration,
          crossFadeState: isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ));


  }


  Widget condensedView(BuildContext context) {
    String longDomain = widget.shortUrl.longUrl.host;
    String longPath = widget.shortUrl.longUrl.path;
    if (longDomain.startsWith("www.")) {
      longDomain = longDomain.substring(4);
    }
    String shortDomain = widget.shortUrl.shortUrl.host;
    String shortPath = widget.shortUrl.shortUrl.path;
    if (shortDomain.startsWith("www.")) {
      shortDomain = shortDomain.substring(4);
    }

    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Flexible(child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 10, ),
                //Service color indicator
                Container(
                  width: 5,
                  height: 10,
                  decoration: BoxDecoration(
                    // color: widget.shortUrl.serviceType.color,
                    color: color,
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
                const SizedBox(width: 10, ),
                //Favicon
                SizedBox(width: 15, child: FaviconViewer(url: widget.shortUrl.longUrl),)
            ], ), ),
          // Expanded(flex: 5, child: GridView.count(
          //   crossAxisCount: 2,
          //   shrinkWrap: true,
          //   childAspectRatio: 8,
          //   physics: NeverScrollableScrollPhysics(),


          //   children: [





          //     //long URL
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         AutoSizeText(longDomain, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), ),
          //         if (longPath.length > 0) AutoSizeText(longPath, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, ), ),
          //       ], ),




          //     // SizedBox(width: 10,),

          //     //short URL
          //     Center(child: AutoSizeText(shortDomain + shortPath, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), ), ),

          //     // //visit button
          //     // CupertinoButton(child: Icon(CupertinoIcons.link), onPressed: () {
          //     //   launchUrl(widget.shortUrl.longUrl);
          //     // }),
          //     // //copy button
          //     // CupertinoButton(child: Icon(CupertinoIcons.doc_on_clipboard), onPressed: () {
          //     //   Clipboard.setData(ClipboardData(text: widget.shortUrl.shortUrl.toString()));

          //     // }),


          //   ]), ),


            //long URL
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(longDomain, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), ),
                  if (longPath.length > 0) Flexible(child: AutoSizeText(longPath, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, ), ), ),
                ], ),),




              // SizedBox(width: 10,),

              //short URL
              Center(child: AutoSizeText(shortDomain + shortPath, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), ), ),

          //view count
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [


              AutoSizeText((widget.shortUrl.visitCount ?? 0).toString(), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), ),
              const SizedBox(width: 5, ),
                Icon(CupertinoIcons.eye, size: 20, ),


            ], ),

            actionButton(context),

          

        ]))


    ;
  }


  Widget expandedView(BuildContext context) {
    String longDomain = widget.shortUrl.longUrl.host;
    String longPath = widget.shortUrl.longUrl.path;
    if (longDomain.startsWith("www.")) {
      longDomain = longDomain.substring(4);
    }
    // if(!isOpen) {
    //   Log.i("Built before open");
    // }
    Widget? stats;
    if(isOpen && stats ==null) {
      stats = SizedBox(
        // height: 500,
        child: ShortUrlStats(
          shortUrl: widget.shortUrl, controller: ShortUrlStatsController()
      ));
    }
      
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        

        Flexible(child:Row( 
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
          //Long URL
          Flexible(child: AutoSizeText(widget.shortUrl.longUrl.toString(), maxLines: 4, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), ),),


          Flexible(child: Column(children: [
            //favicon
            SizedBox(
              height: 50,
              width: 50,
              
              child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 10,
                  // color: color
                ),
                child: FaviconViewer(url: widget.shortUrl.longUrl, size: 50, color: color,)),
            ),

            //title
            if(widget.shortUrl.title==null)Center(child: AutoSizeText("TITLE", maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), ), ),

          ],),),

          //Short URL
          Flexible(child: AutoSizeText(widget.shortUrl.shortUrl.toString(), maxLines: 1, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), ),)

        ]),),
        
        
        //Stats
        stats==null?Container():Flexible(child: stats),


        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
            
        //     //Left Side
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
                

        //     ],),

        //     //Right Side (Stats)

        //     Column(children: [
                
        //     ],),


        //   ], ),
        //Long URL
        //Center(child: AutoSizeText(widget.shortUrl.longUrl.toString(), maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),),


        //Stat Preview
        // VisitDeviceTypeChart( visitInfo: [
        //   ShortUrlVisit(date: , shortUrlId: shortUrlId)

        // ], size: 150,)
        // SizedBox(
        //   height: 300,
        //   // width: 150,
        //   child: NeumorphicBarChart(),
        // )
        
        

      ], ));
  }


  Widget actionButton(BuildContext context) {
    return //action button
          PullDownButton(
            itemBuilder: (context) => [
              PullDownMenuActionsRow.medium(
                items: [
                  PullDownMenuIconAction(
                    // enabled: false,
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: widget.shortUrl.shortUrl.toString()));
                    },
                    title: 'Copy Short URL',
                    icon: CupertinoIcons.doc_on_clipboard,
                  ),
                  PullDownMenuIconAction(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: widget.shortUrl.longUrl.toString()));

                    },
                    title: 'Copy Long URL',
                    icon: CupertinoIcons.link,
                  ),
                  // PullDownMenuIconAction(
                  //   onTap: () {},
                  //   title: 'Delete',
                  //   isDestructive: true,
                  //   icon: CupertinoIcons.delete,
                  // ),
                ],
              ),
              const PullDownMenuDivider(),

                PullDownMenuItem(
                  title: 'Visit Long URL',
                  icon: CupertinoIcons.link,
                  onTap: () {
                    launchUrl(widget.shortUrl.longUrl);
                  },
                ),
                const PullDownMenuDivider(),
                  PullDownMenuItem(
                    title: 'View Map',
                    icon: CupertinoIcons.chart_bar_alt_fill,
                    onTap: () async {
                      var visits = await widget.shortUrl.service!.visitStats(widget.shortUrl);
                      Get.to(() => VisitsMapView(widget.shortUrl, visits));
                    },
                  ),
                  const PullDownMenuDivider(),
                    PullDownMenuItem(
                      title: 'Get QR Code',
                      icon: CupertinoIcons.qrcode,
                      onTap: () {},
                    ),
                    const PullDownMenuDivider(),
                      PullDownMenuItem(
                        isDestructive: true,
                        title: 'Delete',
                        icon: CupertinoIcons.delete,
                        onTap: () {},
                      ),
            ],
            position: PullDownMenuPosition.under,
            buttonBuilder: (context, showMenu) => CupertinoButton(
              // color: color,
              onPressed: showMenu,
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.ellipsis_circle, color: color, ),
            ),
          );
  }

}