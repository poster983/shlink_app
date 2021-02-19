import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:get/get.dart';
import 'package:shlink_app/AppTheme.dart';
import 'package:shlink_app/common.dart';
import 'package:shlink_app/controllers/AppController.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/hive_types/uri_adapter.dart';

import 'package:shlink_app/widgets/add_server.dart';
import 'package:shlink_app/widgets/history/history_list.dart';
import 'package:shlink_app/widgets/shortener_card.dart';

import 'Services.dart';

//types

void main() async {
  //init Hive DB
  await Hive.initFlutter();

  Hive.registerAdapter(ShortUrlAdapter());
  Hive.registerAdapter(UriAdapter());
  
  await Hive.openBox('preferences');
  await Hive.openBox('services');
  await Hive.openBox('add_server_autofill');
  await Hive.openBox<ShortUrl>('history');

  new Services().updateHistory();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shlink',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => MyHomePage(title: 'Shlink')),
      ],
      /*home: MyHomePage(title: 'Shlink'),
      routes: <String, WidgetBuilder> {
        //'/addserver': (BuildContext context) => AddServerPage(),
      },*/
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final AppController controller = Get.put(AppController());

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AppController controller = Get.find();
  int _counter = 0;

  void _incrementCounter() {
    GetBar(
      title: "title",
      animationDuration: new Duration(milliseconds: 300),
      messageText: new RaisedButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Dismiss'),
      ),
      duration: Duration(seconds: 3),
    ).show();

    /*Get.rawSnackbar(
                titleText: Text('text'), messageText: Text(_counter.toString()));*/
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: [
          new IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Hive.box("services").deleteFromDisk();
                showSnackBar(text: "Deleted all services");
              }),
          new IconButton(
              icon: Icon(Icons.brightness_medium),
              onPressed: () {
                if (Get.isDarkMode) {
                  Get.changeTheme(AppTheme.lightTheme);
                } else {
                  Get.changeTheme(AppTheme.darkTheme);
                }
              }),
              new IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  controller.services.updateHistory();
              })
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [new ShortenerCard(), new HistoryList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddServerDialog();
        },
        tooltip: 'Add Server',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
