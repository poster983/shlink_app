import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:pie_chart/pie_chart.dart';

class NeumorphicPieChart extends StatelessWidget {
  const NeumorphicPieChart({super.key, required this.data, this.depth = 10, this.size = 100});
  final Map<String,double> data;
  final double depth;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
      alignment: Alignment.center,  
      children: [


        Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            depth: depth,
            intensity: 1,
            // lightSource: LightSource.topLeft,
            shape: NeumorphicShape.concave,
            color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
          ),
          
          child: PieChart(dataMap: data, legendOptions: LegendOptions(showLegends: false), chartValuesOptions: ChartValuesOptions(showChartValues: false)),
        ),

        Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            shape: NeumorphicShape.concave,
            depth: -depth,
          ),
          child: SizedBox(height: size*0.5, width: size*0.5,),
        ),

        
      ],
    ));
  }
}