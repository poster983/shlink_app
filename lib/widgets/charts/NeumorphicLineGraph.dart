import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart' show LineChart, LineChartData, LineChartBarData, FlSpot,FlTitlesData,AxisTitles,SideTitles,TitleMeta;
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shlink_app/widgets/charts/utils/ChartEntryData.dart';

class NeumorphicLineGraph extends StatelessWidget {
  const NeumorphicLineGraph({
    super.key,
    this.numberPadding = 0,
    this.width = 20,
    required this.dataMap,
  });

  final double numberPadding;
  final double width;
  final List<ChartEntryData> dataMap;


  



  


  Widget findXValueTitles(double index, TitleMeta meta) {

    return AutoSizeText(dataMap.elementAt(index.toInt()).label, maxLines: 1, style: TextStyle(fontSize: 10),);
  }


  @override
  Widget build(BuildContext context) {
    // final Map<String, double> dataMap = {
    //   "Flutter": 5,
    //   "React": 3,
    //   "Xamarin": 2,
    //   "Ionic": -2,
    //   "Vivian": -10,
    //   "test": 0,
    // };

    // double maxNumber = dataMap.values.reduce(max)+numberPadding;
    // double minNumber = dataMap.values.reduce(min)-numberPadding;


    // return Column(children: [
    //   bar(5, maxNumber, minNumber),
    //   bar(3, maxNumber, minNumber),
    //   bar(6, maxNumber, minNumber),
    //   bar(2, maxNumber, minNumber),
    //   bar(0, maxNumber, minNumber),
    //   bar(-3, maxNumber, minNumber),
    // ],);
    

    // return RotatedBox(quarterTurns:-1, child: ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: dataMap.length,
    //   itemBuilder: (context, index) {
    //     String key = dataMap.keys.elementAt(index);
    //     double value = dataMap[key]!;
    //     return Container(
    //       padding: EdgeInsets.symmetric(vertical: 5),
    //       child: bar(value: value, maxValue: maxNumber, minValue: minNumber, label: key, color: CupertinoColors.systemBlue, backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context), depth: 10, size: 100),
    //     ); 
        
    //   },
    // ));


    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        // topTitles: AxisTitles(
        //   sideTitles: SideTitles(showTitles: false),
        // ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: findXValueTitles,
          ),
        ),

      ),
        lineBarsData: [
          LineChartBarData(
            // spots: dataMap.entries.map((e) => FlSpot(e.value, dataMap[e]!)).toList(),
            spots: dataMap.map((e) => FlSpot(dataMap.indexOf(e).toDouble(), e.value)).toList(),
            // spots: [
            //   FlSpot(0,0),
            //   FlSpot(4,0),
            //   FlSpot(2,2),
            //   FlSpot(4,4),
            //   FlSpot(6,2),
            //   FlSpot(4,0),
            //   FlSpot(6,2),
            //   FlSpot(7,10),
            //   FlSpot(8,12),
            //   FlSpot(9,10),
            //   FlSpot(10,2),
            //   FlSpot(12,0),
            //   FlSpot(10,2),
            //   FlSpot(12,4),
            //   FlSpot(14,2),
            //   FlSpot(12,0),
            //   FlSpot(16,0),

            // ],
            isCurved: true,

            

            barWidth: 2,
            isStrokeCapRound: true,
           
          ),
          
        ]
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );

    
  }
}