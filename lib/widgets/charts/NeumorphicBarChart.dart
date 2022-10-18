import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart' show BarChart, BarChartData, BarChartGroupData, BarChartRodData, FlTitlesData, AxisTitles, SideTitles, TitleMeta;
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shlink_app/widgets/charts/utils/ChartEntryData.dart';

class NeumorphicBarChart extends StatelessWidget {
  const NeumorphicBarChart({
    super.key,
    this.numberPadding = 0,
    this.width = 20,
    required this.dataMap,
  });

  final double numberPadding;
  final double width;
  final List<ChartEntryData> dataMap;


  



  Widget bar({required double value, required double maxValue,required double minValue , required String label, required Color color, required Color backgroundColor, required double depth, required double size}) {
    double percent = 0;
    Color color = CupertinoColors.systemBlue;
    double outOf = max(minValue.abs(), maxValue.abs());
    bool rotate = false;
    if(value > 0) {
      percent = value / outOf;
    } else if(value < 0) {
      color = CupertinoColors.systemRed;
      percent = value.abs() / outOf;
      rotate = true;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 5),
      Flexible(flex: 2, fit: FlexFit.tight, child: 
      Transform.rotate(angle: pi/4, alignment: Alignment.centerRight, child:

        Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,  textAlign: TextAlign.right, style: TextStyle(fontSize: 15),)),),
      // AutoSizeText(label, maxLines: 1, style: TextStyle(fontSize: 10),),
      SizedBox(width: 5),
      Expanded( flex: 3, child: Transform.rotate(angle: rotate?pi:0, alignment: Alignment.center, child: 
        Transform(
          alignment: Alignment.center,
          transform: rotate?Matrix4.rotationX(pi):Matrix4.identity(),
          child: 
              NeumorphicProgress(
                height: width,
                percent: percent,
                style: ProgressStyle(
                  accent: color ,
                  variant: color.withOpacity(0.7),
                  depth: -3,
                  // lightSource: rotaLightSource.topLeft,
                )
                // height: height      
              ),),),),

        Flexible(fit: FlexFit.tight, child: Transform.rotate(angle: pi/2, child: AutoSizeText(value.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700),))),
        SizedBox(width: 5),
    ],);
  }


  Widget findXValueTitles(double index, TitleMeta meta) {

    return Transform.rotate(angle: -pi/2, alignment: Alignment.topRight, child: 
      Text(dataMap.elementAt(index.toInt()).label, maxLines: 1, style: TextStyle(fontSize: 10),));
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

    List<double> values = dataMap.map((e) => e.value).toList();

    double maxNumber = values.reduce(max)+numberPadding;
    double minNumber = values.reduce(min)-numberPadding;


    // return Column(children: [
    //   bar(5, maxNumber, minNumber),
    //   bar(3, maxNumber, minNumber),
    //   bar(6, maxNumber, minNumber),
    //   bar(2, maxNumber, minNumber),
    //   bar(0, maxNumber, minNumber),
    //   bar(-3, maxNumber, minNumber),
    // ],);
    

    return RotatedBox(quarterTurns:-1, child: ListView.builder(
      shrinkWrap: true,
      itemCount: dataMap.length,
      itemBuilder: (context, index) {
        String key = dataMap.elementAt(index).label;
        double value = dataMap.elementAt(index).value;
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: bar(value: value, maxValue: maxNumber, minValue: minNumber, label: key, color: CupertinoColors.systemBlue, backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context), depth: 10, size: 100),
        ); 
        
      },
    ));
  


    // return BarChart(
    //   BarChartData(
    //     titlesData: FlTitlesData(
    //     show: true,
    //     bottomTitles: AxisTitles(
    //       sideTitles: SideTitles(
    //         showTitles: true,
    //         getTitlesWidget: findXValueTitles,
    //         reservedSize: 38,
    //         // interval: 1000,
    //       ),
    //     ),
    //     leftTitles: AxisTitles(
    //       sideTitles: SideTitles(
    //         showTitles: true,
    //       ),
    //     ),
    //     topTitles: AxisTitles(
    //       sideTitles: SideTitles(
    //         showTitles: false,
    //       ),
    //     ),
    //     rightTitles: AxisTitles(
    //       sideTitles: SideTitles(
    //         showTitles: false,
    //       ),
    //     ),
    //   ),
    //     barGroups: dataMap.map((e) => BarChartGroupData(
    //       x: dataMap.indexOf(e),
    //       barRods: [
    //         BarChartRodData(
    //           toY: e.value,
    //           color: e.color,
    //           // width: width,
    //         )
    //       ],
    //     )).toList(),
    //     // read about it in the BarChartData section
    //   ),
    //   swapAnimationDuration: Duration(milliseconds: 150), // Optional
    //   swapAnimationCurve: Curves.linear, // Optional
    // );



    
    
  }
}