
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

class ShortUrlCardCondensedLabels extends StatelessWidget {
  const ShortUrlCardCondensedLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
        // borderRadius: BorderRadius.circular(90),
        
      ),
      // padding: EdgeInsets.symmetric(horizontal: 6),
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
          // Container(
          //   width: 5,
          //   height: 10,
          //   decoration: BoxDecoration(
          //     // color: widget.shortUrl.serviceType.color,
          //     color: CupertinoColors.activeBlue,
          //     borderRadius: BorderRadius.circular(90),
          //   ),
          // ),
            
          //Favicon
          // FaviconViewer(url: widget.shortUrl.longUrl),
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

            AutoSizeText("Original Link", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            // if(longPath.length> 0)AutoSizeText(longPath, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12,),),
          ],),
          

          

          // SizedBox(width: 10,),

          //short URL
          Center(child: AutoSizeText("Short Link", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),),
          
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
            
            
            AutoSizeText("Views", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
            const SizedBox(width: 5,),
            Icon(CupertinoIcons.eye, size: 20,),
            

        ],),

        //action button
        // AutoSizeText("Actions", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        const SizedBox(width: 0,),
        ]));
  }
}