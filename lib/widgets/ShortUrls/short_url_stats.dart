
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shlink_app/Log.dart';
import 'package:shlink_app/types/ShortUrl.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/widgets/charts/NeumorphicBarChart.dart';
import 'package:shlink_app/widgets/charts/NeumorphicLineGraph.dart';
import 'package:shlink_app/widgets/charts/NeumorphicPieChart.dart';
import 'package:shlink_app/widgets/charts/utils/ChartEntryData.dart';
import 'package:user_agent_analyzer/user_agent_analyzer.dart';

class ShortUrlStats extends StatefulWidget {
  const ShortUrlStats({super.key, required this.shortUrl, required this.controller, this.visits});

  // final List<ShortUrlVisit> visits;

  final ShortUrlStatsController controller;

  final ShortUrl shortUrl;

  final List<ShortUrlVisit>? visits;

  @override
  State<ShortUrlStats> createState() => _ShortUrlStatsState();
}

class _ShortUrlStatsState extends State<ShortUrlStats> {

  var preferences = Hive.box('preferences');

  List<ShortUrlVisit>? visits;
  
  Map<String, double>? groupedLocationCountry;
  Map<String, double>? groupedLocationCity;
  Map<String, double>? groupedLocationRegion;

  Map<String, double>? groupedDeviceType; // desktop mobile tablet
  Map<String, double>? groupedDeviceOs;

  Map<String, double>? groupedBrowserName;

  Map<String, double>? groupedReferrer;

  Map<String, double> groupedDate = {};


  late ValueNotifier<String> locationMode = ValueNotifier(preferences.get("stats_locationMode", defaultValue: "country"));



  late Future<void> ready;


  /// gets the oldest visit date and the newest visit date
  // List<DateTime?> getDateRange(List<ShortUrlVisit> visits) {
  //   // visits
  //   DateTime? minDate;
  //   DateTime? maxDate;

  //   for (ShortUrlVisit visit in visits) {
  //     if (minDate==null || visit.date.isBefore(minDate)) {
  //       minDate = visit.date;
  //     }
  //     if (maxDate==null || visit.date.isAfter(maxDate)) {
  //       maxDate = visit.date;
  //     }
  //   }

  //   return [minDate, maxDate];
  // }


  Future<void> getData() async {
    // var completer = Completer();
    //get visits unless they are already supplied
    if(widget.visits == null ) {
      //get visits
      visits = await widget.shortUrl.visits;
    } else {
      visits = widget.visits!;
    }

    //clean visits
    //remove visits that are not in the date range   
    filterAndProcess();
  }


  /// filters and processes the visits by date
  List<ShortUrlVisit> filterByDate({required List<ShortUrlVisit> visits, DateTime? minDate, DateTime? maxDate}) {
    List<ShortUrlVisit> filteredVisits = [];
    for (ShortUrlVisit visit in visits) {
      if (minDate!=null && visit.date.isBefore(minDate)) {
        continue;
      }
      if (maxDate!=null && visit.date.isAfter(maxDate)) {
        continue;
      }
      filteredVisits.add(visit);
    }
    return filteredVisits;
  }

  


  filterAndProcess() {
    List<ShortUrlVisit> visits = this.visits ?? [];
    
    // List<DateTime?> dateRange;
    if(widget.controller.minDate != null || widget.controller.maxDate != null) {

      visits = filterByDate(visits: visits);

    } 
    
    //process visits

    //group by Location (country)
    //group by Location (region)
    //group by Location (city)
    //group by device type
    //group by device os
    //group by browser type
    //group by referrer
    //group by date

    for(var visit in visits) {
      //MARK: locations 
      //country
      if(visit.location?.country != null) {
        if(groupedLocationCountry == null) {
          groupedLocationCountry = {};
        }
        if(visit.location!.country! == "") {
          visit.location!.country = "Unknown";
        }
         groupedLocationCountry![visit.location!.country!] = (groupedLocationCountry![visit.location!.country!] ?? 0) + 1;
      }
      //region
      if(visit.location?.region != null) {
        if(groupedLocationRegion == null) {
          groupedLocationRegion = {};
        }
        if(visit.location!.region! == "") {
          visit.location!.region = "Unknown";
        }
         groupedLocationRegion![visit.location!.region!] = (groupedLocationRegion![visit.location!.region!] ?? 0) + 1;
      }
      //city
      if(visit.location?.city != null) {
        if(groupedLocationCity == null) {
          groupedLocationCity = {};
        }
        if(visit.location!.city! == "") {
          visit.location!.city = "Unknown";
        }
         groupedLocationCity![visit.location!.city!] = (groupedLocationCity![visit.location!.city!] ?? 0) + 1;
      }

      //MARK: User Agent
      if(visit.userAgent != null) {
        var ua = UserAgent(visit.userAgent!);
        // init maps
        if(groupedDeviceType == null) {
          groupedDeviceType = {};
        }
        if(groupedDeviceOs ==null) {
          groupedDeviceOs = {};
        }
        if(groupedBrowserName == null) {
          groupedBrowserName = {};
        }

        //TODO: Add potential bot detection

        //device type
        if(ua.isDesktop) {
          groupedDeviceType!['Desktop'] = (groupedDeviceType!['Desktop'] ?? 0) + 1;
        } else if(ua.isMobile) {
          groupedDeviceType!['mobile'] = (groupedDeviceType!['Mobile'] ?? 0) + 1;
        } else if(ua.isTablet) {
          groupedDeviceType!['Tablet'] = (groupedDeviceType!['Tablet'] ?? 0) + 1;
        } else {
          groupedDeviceType!['Unknown'] = (groupedDeviceType!['Unknown'] ?? 0) + 1;
        }

        //device os
        if(ua.isAndroid) {
          groupedDeviceOs!['Android'] = (groupedDeviceOs!['Android'] ?? 0) + 1;
        } else if(ua.isMacOS && ua.isMobile && !ua.isTablet) { // iOS
          groupedDeviceOs!['iOS'] = (groupedDeviceOs!['iOS'] ?? 0) + 1;
        } else if(ua.isMacOS && ua.isTablet) { // iPadOS
          groupedDeviceOs!['iPadOS'] = (groupedDeviceOs!['iPadOS'] ?? 0) + 1;
        } else if(ua.isBlackberry) { // Blackberry
          groupedDeviceOs!['BlackBerry'] = (groupedDeviceOs!['BlackBerry'] ?? 0) + 1;
        } else if(ua.isWindows) { // windows desktop phone and tablet
          groupedDeviceOs!['Windows'] = (groupedDeviceOs!['Windows'] ?? 0) + 1;
        } else if(ua.isMacOS && !ua.isMobile && !ua.isTablet) { // MacOS
          groupedDeviceOs!['macOS'] = (groupedDeviceOs!['macOS'] ?? 0) + 1;
        } else if(!ua.isAndroid && visit.userAgent!.toLowerCase().contains("linux")) { // linux
          groupedDeviceOs!['Linux'] = (groupedDeviceOs!['Linux'] ?? 0) + 1;
        } else {
          groupedDeviceOs!['Unknown'] = (groupedDeviceOs!['Unknown'] ?? 0) + 1;
        }

        //browser name
        if(ua.isSafari) {
          groupedBrowserName!['Safari'] = (groupedBrowserName!['Safari'] ?? 0) + 1;
        } else if(ua.isChrome) {
          groupedBrowserName!['Chrome'] = (groupedBrowserName!['Chrome'] ?? 0) + 1;
        } else if(ua.isFirefox) {
          groupedBrowserName!['Firefox'] = (groupedBrowserName!['Firefox'] ?? 0) + 1;
        } else if(ua.isOpera) {
          groupedBrowserName!['Opera'] = (groupedBrowserName!['Opera'] ?? 0) + 1;
        } else if(ua.isIE) {
          groupedBrowserName!['IE'] = (groupedBrowserName!['IE'] ?? 0) + 1;
        } else {
          groupedBrowserName!['Unknown'] = (groupedBrowserName!['Unknown'] ?? 0) + 1;
        }
      }

      //MARK: referrer
      if(visit.referrer != null) {
        if(groupedReferrer == null) {
          groupedReferrer = {};
        }
        groupedReferrer![visit.referrer!] = (groupedReferrer![visit.referrer!] ?? 0) + 1;
      }

      //MARK: date
      String formattedDate = DateFormat('yyyy-MM-dd').format(visit.date);
      groupedDate[formattedDate] = (groupedDate[formattedDate] ?? 0) + 1;
      
      

    }

    
  }



  @override
  void initState() {
    widget.controller.addListener(filterAndProcess);
    
    ready = getData();

    super.initState();
  }

  @override
  void dispose() {
    // locationMode.
    super.dispose();
  }


  Widget buildLocationCharts(BuildContext context) {
    return ValueListenableBuilder(valueListenable: locationMode, builder: ((context, value, child){ 
      Map<String, double> datamap;

      if(groupedLocationCountry == null && groupedLocationRegion == null && groupedLocationCity == null) {
        return Center(child: Text('No location data available'));
      }

      if(value == 'country') {
        datamap = groupedLocationCountry!;
      } else if(value == 'region') {
        datamap = groupedLocationRegion!;
      } else if(value == 'city') {
        datamap = groupedLocationCity!;
      } else {
        locationMode.value = 'country';
        datamap = groupedLocationCountry!;
      }

      List<ChartEntryData> data = datamap.entries.map((e) => ChartEntryData(
        label: e.key,
        value: e.value,
      ) ).toList();
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoSlidingSegmentedControl< String >(
            onValueChanged: (value) { locationMode.value = value ?? "country"; preferences.put("stats_locationMode", value); }, 
            groupValue: locationMode.value,
            children: {
              'country': Text('Country'),
              'region': Text('Region'),
              'city': Text('City'),
            },
          ),

          Flexible(child: NeumorphicBarChart(dataMap: data))

          //Flexible(child: NeumorphicPieChart(dataMap: data, size: 500,))
          
        ]);
    }));
  }


  Widget buildCharts(BuildContext context) {
    
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        //Date graph
        Flexible(child: NeumorphicLineGraph(dataMap: groupedDate.entries.map((e) => ChartEntryData(
          label: e.key,
          value: e.value,
        ) ).toList())),
        Expanded(child: Flex(
          // mainAxisSize: MainAxisSize.min,
        direction: MediaQuery.of(context).size.width > 600 ? Axis.horizontal : Axis.vertical,
        children: [
          //Left side - device type
          // buildLocationCharts(context),
          Flexible(child: buildLocationCharts(context),),
          // Flexible(child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
            

          // ],))
        ],))
    ],);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: ready,
      builder: ((context, snapshot) {
        bool done = snapshot.connectionState == ConnectionState.done && !snapshot.hasError;

        if(snapshot.hasError) {
          Log.e(snapshot.error);
          return Center(child: Text(snapshot.error.toString()));
        }

        if(done) {
          return Text("PEE");
          // return buildCharts(context);
          // return buildLocationCharts(context);
        }


        //loading 
        return Center(child: CircularProgressIndicator.adaptive());
      }), 
    );
  }
}


class ShortUrlStatsController {

  VoidCallback? onChange;
  
  ShortUrlStatsController({
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    this._minDate = minDate;
    this._maxDate = maxDate;
    // if(minDate == null) {
    //   _minDate = DateTime.now().toUtc().subtract(Duration(days: 30));
    // }
    // if(maxDate == null) {
    //   _maxDate = DateTime.now().toUtc();
    // }
  }

  DateTime? _minDate;
  DateTime? _maxDate;

  DateTime? get minDate => _minDate;
  DateTime? get maxDate => _maxDate;
  set minDate(DateTime? date) {
    _minDate = date;
    onChange?.call();
  }
  set maxDate(DateTime? date) {
    _maxDate = date;
    onChange?.call();
  }

  addListener(VoidCallback listener) {
    onChange = listener;
  }
}