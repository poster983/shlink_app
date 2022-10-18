import 'package:cached_network_image/cached_network_image.dart';
import 'package:favicon/favicon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shlink_app/Log.dart';
import 'package:shlink_app/widgets/BetterIcon.dart';

class FaviconViewer extends StatefulWidget {
  const FaviconViewer({super.key, required this.url, this.onLoad, this.size = 32, this.color = const Color(0xFF000000)});

  final Uri url;  

  final Function(Uri url)? onLoad;

  final double size;

  final Color color;

  @override
  State<FaviconViewer> createState() => _FaviconViewerState();
}

class _FaviconViewerState extends State<FaviconViewer> {

  // Future<String> getFaviconURL() async {
  //  return "https://www.google.com/s2/favicons?domain=${widget.url.host}";

  // }

  late Future<Favicon?> faviconFuture; // = Future.value();

  @override
  void initState() {
    // if(!kIsWeb) {
    //   faviconFuture = FaviconFinder.getBest(widget.url.toString());
    // } 
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Build favicon");
    // if(kIsWeb) {
      return AspectRatio(aspectRatio: 1, child: Align(
        alignment: Alignment.center, 
        child: BetterIcon(CupertinoIcons.globe, size: widget.size, color: widget.color, )));    
    // }

    // return AspectRatio(aspectRatio: 1, child: FutureBuilder<Favicon?>(future: faviconFuture, builder: (context, snapshot) {
    //   print("${widget.url} : ${snapshot.data}");
    //   if(snapshot.connectionState == ConnectionState.done) {
    //     if(snapshot.hasData) {
    //       if(widget.onLoad != null) widget.onLoad!(widget.url);
    //       Log.i("Favicon found for ${widget.url} : ${snapshot.data!.url}");
    //       return CachedNetworkImage(imageUrl: snapshot.data!.url, width: widget.size, height: widget.size, 
    //         progressIndicatorBuilder: (context, url, loadingProgress) => loadingProgress.totalSize == null
    //         ?CupertinoActivityIndicator.partiallyRevealed(progress: loadingProgress.downloaded / loadingProgress.totalSize!)
    //         :  CupertinoActivityIndicator(),

    //         errorWidget: (context, url, error) => BetterIcon(CupertinoIcons.globe, size: widget.size, color: widget.color, ),
    //       );
    //     } else {
    //       return BetterIcon(CupertinoIcons.globe);
    //     }
    //   } 

    //   return const CupertinoActivityIndicator();
    // } ));

    // return Image.network("https://www.google.com/s2/favicons?domain=${widget.url.host}", width: widget.size, height: widget.size, 
    //   loadingBuilder: (context, child, loadingProgress) => loadingProgress != null 
    //     ?CupertinoActivityIndicator.partiallyRevealed(progress: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!)
    //     :child
    // );
  }
}