import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shlink_app/types/ShortUrlVisit.dart';
import 'package:shlink_app/widgets/charts/NeumorphicPieChart.dart';

class VisitDeviceTypeChart extends StatefulWidget {
  const VisitDeviceTypeChart({super.key, required this.visitInfo, this.depth = 10, this.size = 100});

  final List<ShortUrlVisit> visitInfo;

  final double depth;
  final double size;

  @override
  State<VisitDeviceTypeChart> createState() => _VisitDeviceTypeChartState();
}

class _VisitDeviceTypeChartState extends State<VisitDeviceTypeChart> {

  void mapVisits() {
    
  }
  
  Map<String, double> dataMap = {};
  
  // var chartType = ValueNotifier("pie");
  var chartType = "pie";



   @override
  void initState() {
    mapVisits();
    super.initState();
  } 

  @override
  void dispose() {
    // chartType.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [],
    );
    // return ValueListenableBuilder(
    //   valueListenable: chartType,
    //   builder: (context, value, child) {


    //     //return NeumorphicPieChart(data: dataMap, depth: widget.depth, size: widget.size);
    //   },
    // );
    //return NeumorphicPieChart(data: dataMap, depth: widget.depth, size: widget.size);
  }
}