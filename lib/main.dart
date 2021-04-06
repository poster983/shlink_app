import 'dart:io';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:maps/maps.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shlink_app/AppTheme.dart';
import 'package:shlink_app/common.dart';
import 'package:shlink_app/controllers/AppController.dart';
import 'package:shlink_app/types/services/GenericREST.dart';
import 'package:shlink_app/types/services/ServiceType.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/hive_types/uri_adapter.dart';
import 'package:shlink_app/views/HistoryView.dart';
import 'package:shlink_app/views/HomeView.dart';
import 'package:shlink_app/views/MapTestView.dart';
import 'package:shlink_app/views/SettingsView.dart';
import 'package:shlink_app/views/settings/MapSettingsView.dart';
import 'package:shlink_app/views/settings/ShortishCloud/ShortishCloudSettingsView.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'package:shlink_app/widgets/add_server.dart';

import 'Services.dart';

//types

void main() async {
  //init Hive DB
  await Hive.initFlutter();

  Hive.registerAdapter(ShortUrlAdapter());
  Hive.registerAdapter(UriAdapter());
  Hive.registerAdapter(ServiceTypeAdapter());

  var preferences = await Hive.openBox('preferences');
  var servicesBox = await Hive.openBox('services');
  await Hive.openBox('add_server_autofill');
  await Hive.openBox<ShortUrl>('history');
  await DotEnv.load(fileName: ".env");

  //set default prefrence for maps
  if (preferences.get("mapService") == null) {
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        preferences.put("mapService", "GoogleMaps");
      }
      if (Platform.isIOS) {
        preferences.put("mapService", "AppleMaps");
      }
    } else {
      preferences.put("mapService", "OpenStreetMap");
    }
  }

  //add default services
  if (servicesBox.get("tinyurl.com") == null) {
    GenericREST tinyurl = new GenericREST(
      host: Uri.parse("https://tinyurl.com/api-create.php"),
      name: "tinyurl.com",
      longURLParameter: "url",
      color: new Color.fromRGBO(0, 0, 153, 1),
      httpMethod: HTTPMethod.GET,
    );
    servicesBox.put(tinyurl.name, tinyurl.toJson());
    print("MAIN(): Added tinyurl.com Service");
  }

  if (servicesBox.get("is.gd") == null) {
    GenericREST defaultService = new GenericREST(
      host: Uri.parse("https://is.gd/create.php"),
      name: "is.gd",
      longURLParameter: "url",
      urlParameters: {"format": "json"},
      customSlugParameter: "shorturl",
      shortenedURLParameter: "shorturl",
      color: new Color.fromRGBO(183, 9, 0, 1),
      httpMethod: HTTPMethod.GET,
    );
    servicesBox.put(defaultService.name, defaultService.toJson());
    print("MAIN(): Added is.gd Service");
  }
  if (servicesBox.get("v.gd") == null) {
    GenericREST defaultService = new GenericREST(
      host: Uri.parse("https://v.gd/create.php"),
      name: "v.gd",
      urlParameters: {"format": "json"},
      longURLParameter: "url",
      customSlugParameter: "shorturl",
      shortenedURLParameter: "shorturl",
      color: new Color.fromRGBO(3, 145, 9, 1),
      httpMethod: HTTPMethod.GET,
    );
    servicesBox.put(defaultService.name, defaultService.toJson());
    print("MAIN(): Added v.gd Service");
  }
  //Update history list
  Services.updateHistory();

  //Define MapAdapter
  /*MapAdapter.defaultInstance = MapAdapter.platformSpecific(
    ios: AppleMapsNativeAdapter(),
    //browser: AppleMapsJsAdapter(requestSigner: AppleMapsRequestSigner.withPrivateKey())
    // Bing Maps iframe API does not necessarily require API credentials
    // so we use it in the example.
    otherwise: BingMapsIframeAdapter(),
  );*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shortish',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/', page: () => MyHomePage(title: 'Shortish', pageIndex: 0)),
        GetPage(
            name: '/history',
            page: () => MyHomePage(title: 'Shortish', pageIndex: 1)),
        GetPage(name: '/map', page: () => MapTestView()),
        GetPage(
            name: '/settings',
            page: () => MyHomePage(title: 'Shortish', pageIndex: 2)),
        GetPage(name: '/settings/map', page: () => MapSettingsView()),
        GetPage(name: '/settings/cloud', page: () => ShortishCloudView())
      ],
      /*home: MyHomePage(title: 'Shlink'),
      routes: <String, WidgetBuilder> {
        //'/addserver': (BuildContext context) => AddServerPage(),
      },*/
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, this.pageIndex = 0})
      : super(key: key);
  final AppController controller = Get.put(AppController());

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  int pageIndex;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AppController controller = Get.find();

  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    
    _pageController = PageController(initialPage: widget.pageIndex);
    SharedPreferences.getInstance().then((prefs) {
      print("API KEY from shared storage");
      print(prefs.getString("shortish_cloud_apikey"));
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
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
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        //elevation: 0,
        actions: [
          new IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Hive.box("preferences").deleteFromDisk();
                Hive.box("services").deleteFromDisk();
                Hive.box<ShortUrl>("history").deleteFromDisk();
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
                Services.updateHistory();
              })
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => widget.pageIndex = index);
          },
          children: <Widget>[HomeView(), HistoryView(), SettingsView()],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.center,
        selectedIndex: widget.pageIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          widget.pageIndex = index;
          _pageController?.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
              activeColor: Colors.red,
              textAlign: TextAlign.center,
              title: Text('Home'),
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              title: Text('History'),
              icon: Icon(Icons.history_edu)),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            title: Text('Settings'),
            icon: Icon(Icons.settings),
            activeColor: Colors.green,
          ),
        ],
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
