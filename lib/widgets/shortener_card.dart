import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

/// A Card for shortning URLS
class ShortenerCard extends StatefulWidget {
  ShortenerCard({Key key}) : super(key: key);

  

  

  @override
  _ShortenerCardState createState() => _ShortenerCardState();
}

class _ShortenerCardState extends State<ShortenerCard> {
  final _formKey = GlobalKey<FormState>();
  var longURLControll = new TextEditingController();
  var urlProtocall = "";

  /// Gets the clipboard data from the 
  /// [onlyValid] if set to true it will only paste if the URL is valid
  /// 
  void pasteClipboardURL({bool onlyValid}) {
      Clipboard.getData('text/plain').then((clipboard) {
        var res = validateURL(clipboard.text);
        if(onlyValid != null && onlyValid ) {
          if(res == null ) {
            longURLControll.text = clipboard.text;
            setState((){});
          }
        } else {
            longURLControll.text = clipboard.text;
            setState((){});
        }
        
        
      });
      
  }

  String validateURL(value) {
    if(!value.isEmpty) {
      var url = Uri.parse(value);
      var host = (url.host.isEmpty)?value:url.host; // The parser puts the host in the scheme if no scheme is found. But we need the host all the time
      if(!GetUtils.isURL(host)) {
        urlProtocall = "";
        return "Invalid URL";
      } else {
        //If the url is valid, but has no protocall then add it to the prefix
        if(!url.hasScheme) {
          urlProtocall = "http://";
        } else {
          urlProtocall = "";
        }
      }
      return null;
    } 
    return "URL cannot be empty";
  }

  _ShortenerCardState() {
    pasteClipboardURL(onlyValid: true);

  }
  


  @override
  Widget build(BuildContext context) {
    
    
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(
          color: Theme.of(context).accentColor,
          width: 2,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new TextFormField( 
                  validator: (v) => validateURL(v),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefix: new GestureDetector( // Protocall prefix.  Tap to remove
                      child: new Text(urlProtocall),
                      onTap: () {setState((){ urlProtocall = ""; });},
                    ),
                    suffixIcon: new Row(mainAxisSize: MainAxisSize.min, children: [ // add buttons to input
                      new IconButton(icon: Icon(Icons.clear), onPressed: () { urlProtocall = ""; longURLControll.clear(); setState((){}); }), // clear
                      new IconButton(icon: Icon(Icons.paste), onPressed: () => pasteClipboardURL() ),
                    ]),
                    labelText: 'Long URL',
                  ),
                  onChanged: (val) {
                    
                  },
                  //autofocus: true,
                  controller: longURLControll,
                  autovalidate: true,
                  onFieldSubmitted: (v) { setState((){});}
                ),
                new Row(children: [ // Service picker and custom route textbox
                  new TextFormField(  // Custom Path 
                    decoration: InputDecoration(
                        prefix: new Text("/"),
                        labelText: 'Custom Path (Optional)',
                        //suffixIcon: 
                    )
                  )
                ],)

              ]
            )
          )
        )
      ),
    );
  }

}