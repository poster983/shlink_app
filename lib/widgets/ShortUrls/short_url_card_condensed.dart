import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/widgets/ShortUrls/favicon_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class ShortUrlCardCondensed extends StatefulWidget {
  const ShortUrlCardCondensed(this.shortUrl, {super.key, this.openGroup, this.opened=false});

  final ShortUrl shortUrl;

  final String? openGroup;

  final bool opened;

  @override
  State<ShortUrlCardCondensed> createState() => _ShortUrlCardCondensedState();
}

class _ShortUrlCardCondensedState extends State<ShortUrlCardCondensed> {

  final transitionDuration = const Duration(milliseconds: 200);
  bool isOpen = false;

  @override
  void initState() {
    isOpen = widget.opened;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.easeInOut,
      margin: isOpen? EdgeInsets.symmetric(vertical: 10, horizontal: 10) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
        borderRadius: isOpen?BorderRadius.circular(10):BorderRadius.zero,
        boxShadow: isOpen?[
          BoxShadow(
            color: CupertinoColors.systemGrey.resolveFrom(context).withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]:[],
      )
      ,
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
        crossFadeState: isOpen?CrossFadeState.showSecond:CrossFadeState.showFirst,
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
            const SizedBox(width: 10,),
          //Service color indicator
          Container(
            width: 5,
            height: 10,
            decoration: BoxDecoration(
              // color: widget.shortUrl.serviceType.color,
              color: CupertinoColors.activeBlue,
              borderRadius: BorderRadius.circular(90),
            ),
          ),
            
          //Favicon
          FaviconViewer(url: widget.shortUrl.longUrl),
        ],),),
        Expanded(flex: 5,child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: 8,
          physics: NeverScrollableScrollPhysics(),

          
          children: [
          
          
          
          

          //long URL
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            AutoSizeText(longDomain, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            if(longPath.length> 0)AutoSizeText(longPath, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12,),),
          ],),
          

          

          // SizedBox(width: 10,),

          //short URL
          Center(child: AutoSizeText(shortDomain + shortPath, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),),
          
          // //visit button
          // CupertinoButton(child: Icon(CupertinoIcons.link), onPressed: () {
          //   launchUrl(widget.shortUrl.longUrl);
          // }),
          // //copy button
          // CupertinoButton(child: Icon(CupertinoIcons.doc_on_clipboard), onPressed: () {
          //   Clipboard.setData(ClipboardData(text: widget.shortUrl.shortUrl.toString()));
          
          // }),

          
        ]),
        ),

        //view count
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            
            AutoSizeText((widget.shortUrl.visitCount ?? 0).toString(), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            const SizedBox(width: 5,),
            Icon(CupertinoIcons.eye, size: 20,),
            

        ],),

        //action button
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
                title: 'View Stats',
                icon: CupertinoIcons.chart_bar_alt_fill,
                onTap: () {},
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
              onPressed: showMenu,
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.ellipsis_circle),
            ),
          )
      
        ]))
      
      
    ;
  }


  Widget expandedView(BuildContext context) {
    String longDomain = widget.shortUrl.longUrl.host;
    String longPath = widget.shortUrl.longUrl.path;
    if (longDomain.startsWith("www.")) {
      longDomain = longDomain.substring(4);
    }
    return Container(child: Column(children: [

      //favicon
      Container(
          decoration: BoxDecoration(
            color: CupertinoColors.systemBlue,
            borderRadius: BorderRadius.circular(90),
          ),
          child: FaviconViewer(url: widget.shortUrl.longUrl, size: 50,),
        ),
      //title
      Center(child: AutoSizeText("TITLE", maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),),


      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        
        children: [
        //Favicon
        
        //Long URL
        AutoSizeText(widget.shortUrl.longUrl.toString(), maxLines: 1, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
        
      ],),
      //Long URL
      //Center(child: AutoSizeText(widget.shortUrl.longUrl.toString(), maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),),
      
      const SizedBox(height: 10,),
      //Short URL
      AutoSizeText(widget.shortUrl.shortUrl.toString(), maxLines: 1,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
      
      //Stat Preview

    ],));
  }

}