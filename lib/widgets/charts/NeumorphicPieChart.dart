import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:pie_chart/pie_chart.dart';
import 'package:fl_chart/fl_chart.dart' show PieChart, PieChartData, PieChartSectionData;
import 'package:shlink_app/widgets/charts/utils/ChartEntryData.dart';


class NeumorphicPieChart extends StatelessWidget {
  const NeumorphicPieChart({super.key, required this.dataMap, this.depth = 10, this.size = 200});
  final List<ChartEntryData> dataMap;
  final double depth;
  final double size;

  // Iterable<Color> nextColor() sync* {
  //   int i = 0;
  //   var colors = [
  //     Colors.red,
  //     Colors.blue,
  //     Colors.green,
  //     Colors.yellow,
  //     Colors.orange,
  //     Colors.indigo,
  //     Colors.cyan
  //   ];
  //   while (true) {
  //     yield colors[i % colors.length];
  //     i++;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
      alignment: Alignment.center,  
      children: [


        Neumorphic(
          padding: EdgeInsets.all(10),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            depth: depth,
            intensity: 1,
            
            // lightSource: LightSource.topLeft,
            shape: NeumorphicShape.concave,
            color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
          ),
          
          //child: PieChart(dataMap: data, legendOptions: LegendOptions(showLegends: false), chartValuesOptions: ChartValuesOptions(showChartValues: false)),
          child: PieChart(
              PieChartData(
                sections: dataMap.map((e) => PieChartSectionData(
                  value: e.value,
                  color: e.color,
                  title: e.label,
                  titlePositionPercentageOffset: -1,
                  badgePositionPercentageOffset: 0.98,
                  // radius: size*0.10,
                  // titleStyle: TextStyle(
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.bold,
                  //   color: CupertinoColors.systemGrey.resolveFrom(context),
                  // ),
                )).toList(),
                // centerSpaceRadius: size*0.05,
                // read about it in the PieChartData section
              ),
              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            )

        
        ),

        // Neumorphic(
        //   style: NeumorphicStyle(
        //     boxShape: NeumorphicBoxShape.circle(),
        //     shape: NeumorphicShape.concave,
        //     depth: -depth,
        //   ),
        //   child: SizedBox(height: size*0.5, width: size*0.5,),
        // ),

        
      ],
    ));
  }
}