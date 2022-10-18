import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicBarChart extends StatelessWidget {
  const NeumorphicBarChart({
    super.key,
    this.numberPadding = 0,
    this.width = 20,
    required this.dataMap,
  });

  final double numberPadding;
  final double width;
  final Map<String, double> dataMap;


  



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
    return Row(children: [
      Flexible(fit: FlexFit.tight, child: Transform.rotate(angle: pi/4, alignment: Alignment.centerRight, child: AutoSizeText(label, maxLines: 1, textAlign: TextAlign.right, style: TextStyle(fontSize: 10),)),),
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

        Flexible(fit: FlexFit.tight, child: Transform.rotate(angle: pi/2, child: AutoSizeText(value.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700),)))
    ],);

      
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

    double maxNumber = dataMap.values.reduce(max)+numberPadding;
    double minNumber = dataMap.values.reduce(min)-numberPadding;


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
        String key = dataMap.keys.elementAt(index);
        double value = dataMap[key]!;
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: bar(value: value, maxValue: maxNumber, minValue: minNumber, label: key, color: CupertinoColors.systemBlue, backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context), depth: 10, size: 100),
        ); 
        
      },
    ));

    
  }
}