
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:shlink_app/types/Shlink.dart';
import "../common.dart";

class AddServerSheet extends StatefulWidget {
  AddServerSheet({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  
  @override
  _AddServerSheetState createState() => _AddServerSheetState();
}

class _AddServerSheetState extends State<AddServerSheet> {
  final _formKey = GlobalKey<FormState>();
  var autofill = Hive.box("add_server_autofill");
  var serverBox = Hive.box("services");


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  String stringValidator(value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    
    return null;
  }

  String urlValidator(value) {
    if(!value.isEmpty) {
      var url = Uri.parse(value);
      if(!url.hasScheme) {
        return "Please include https:// or http://";
      }
      if(url.hasAbsolutePath) {
        return "Only include the base URL";
      }

      if(!GetUtils.isURL(url.host)) {
        return "Invalid URL";
      }
      return null;
    } 
    return "URL cannot be empty";
  }

  void submitForm(context) {
    if (_formKey.currentState.validate()) {
      
      showSnackBar(text: "Processing Data");
      //get form data
      String name = autofill.get("name");
      Uri host = Uri.parse(autofill.get("host") as String);
      String apiKey = autofill.get("apiKey");
      //delete all the keys
      autofill.deleteAll(["host", "name", "apiKey"]);

      //save to server box
      var newServer = new Shlink(host: host, name: name, apiKey: apiKey);
      var key = Uuid().v4();
      serverBox.put(key, newServer.toJson());

      
      
      Get.back(closeOverlays: true);
    } else {
      showSnackBar(text: "Invalid Form");
      
    }
  }

  
  
  @override
  Widget build(BuildContext context) {
    //print(Get.previousRoute);
    return new SingleChildScrollView( 
      child: Container(
       /* decoration: new BoxDecoration(
          color: 
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))
        ),*/
        
        padding: EdgeInsets.only(
          top: 50,
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Padding(
        
        padding: const EdgeInsets.symmetric(horizontal:18 ),
        child: Form(
          key: _formKey,
          
          //color: Colors.amber,
          
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text("Add a Shlink Server", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                new SizedBox(height: 25), //padding
                //First the Name of the server
                new TextFormField(validator: stringValidator, 
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    
                    labelText: 'Server Name',
                  ),
                  onChanged: (val) {
                    autofill.put('name', val);
                  },
                  //autofocus: true,
                  initialValue: autofill.get("name"),
                  //autovalidate: true
                ),
                new SizedBox(height: 15), //padding
                new TextFormField(validator: urlValidator, 
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Host',
                  ),
                  onChanged: (val) {
                    autofill.put('host', val);
                  },
                  autocorrect: false,
                  initialValue: (autofill.get("host")!=null)?autofill.get("host"):"https://",
                  autovalidate: true
                ),
                new SizedBox(height: 15),
                new TextFormField(validator: stringValidator, 
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'API Key',
                  ),
                  onChanged: (val) {
                    autofill.put('apiKey', val);
                  },
                  autocorrect: false,
                  enableSuggestions: false,
                  //autovalidate: true
                ),
                new SizedBox(height: 15),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Cancel Buttom
                    new OutlineButton(
                      onPressed: (){
                        //whipe autofill
                        autofill.deleteAll(["host", "name", "apiKey"]);
                        Get.back(closeOverlays: true);
                      },
                      child: Text('Cancel'),
                    ),
                    new SizedBox(width: 20),
                    // SUBMIT BUTTON
                    new RaisedButton(
                      onPressed: ()=>submitForm(context),
                      child: Text('Add'),
                    ),
                  ],
                ),
                
                
                new SizedBox(height: 45), //padding

              ],
            ),
          )
        )
        )
      )
    );

    /*const Text('Modal BottomSheet'),
            RaisedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () => Navigator.pop(context),
            ) */
    /*return Scaffold(
      appBar: AppBar(
        leading: (Navigator.canPop(context))?IconButton(
          icon: new Icon(Icons.arrow_back, semanticLabel: "Go Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ): new Container(),
        title: Text("Add a Shlink server"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );*/
  }


}

/// Shows Add server sheet as a dialog or bottom sheet depending on context
/// 
/// 
void showAddServerDialog() {
  if(Get.context.isLargeTablet) {
    Get.dialog(new Dialog(
      child: AddServerSheet()
    ));
  } else {
    showModalBottomSheet<void>(
        context: Get.context,
        isScrollControlled: true,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        builder: (BuildContext context) {
          return new Container(
              child: AddServerSheet(),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Get.theme.cardColor, 
                borderRadius: BorderRadius.circular(30)
              ),
            );
        }
    );
    /*Get.bottomSheet(
      /*new Container(
        child: AddServerSheet(),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Get.theme.cardColor, 
          borderRadius: BorderRadius.circular(30)
        ),
      ),*/
      /*BottomSheet(
        animationController: ,
          enableDrag: false,
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          onClosing: () {},
          builder: (BuildContext context) {
            return new Container(
              child: AddServerSheet(),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Get.theme.cardColor, 
                borderRadius: BorderRadius.circular(30)
              ),
            ); 
          }
      ),*/
      isScrollControlled: true,
      
      
      
      
    );*/
  }
}//https://stackoverflow.com/questions/55929366/implementing-transitions-in-a-bottomsheet