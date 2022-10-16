import 'package:favicon/favicon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FaviconViewer extends StatefulWidget {
  const FaviconViewer({super.key, required this.url, this.onLoad, this.size = 32});

  final Uri url;  

  final Function(Uri url)? onLoad;

  final double size;

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
    if(!kIsWeb) {
      faviconFuture = FaviconFinder.getBest(widget.url.toString());
    } 
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Build favicon");
    if(kIsWeb) {
      return Icon(CupertinoIcons.globe, size: widget.size);
    }

    return FutureBuilder<Favicon?>(future: faviconFuture, builder: (context, snapshot) {
      print("${widget.url} : ${snapshot.data}");
      if(snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasData) {
          if(widget.onLoad != null) widget.onLoad!(widget.url);
          return Image.network(snapshot.data!.url, width: widget.size, height: widget.size, 
            loadingBuilder: (context, child, loadingProgress) => loadingProgress != null 
              ?CupertinoActivityIndicator.partiallyRevealed(progress: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!)
              :child
          );
        } else {
          return Icon(CupertinoIcons.globe);
        }
      } 

      return const CupertinoActivityIndicator();
    } );

    // return Image.network("https://www.google.com/s2/favicons?domain=${widget.url.host}", width: widget.size, height: widget.size, 
    //   loadingBuilder: (context, child, loadingProgress) => loadingProgress != null 
    //     ?CupertinoActivityIndicator.partiallyRevealed(progress: loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!)
    //     :child
    // );
  }
}