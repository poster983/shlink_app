import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  final String text;
  /*final double? fontSize;
  final FontWeight? fontWeight;*/
  final TextStyle? style;
  final Color? color;
  final Color? strokeColor;
  final double? strokeWidth;

  const StrokeText(
    this.text, {
    Key? key,
    /*this.fontSize,
    this.fontWeight,*/
    this.style,
    this.color,
    this.strokeColor,
    this.strokeWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(

            foreground: Paint()..color = color ?? Colors.black,
          ).merge(style),
        ),
        (strokeWidth != null && strokeWidth != 0)?Text(
          text,
          style: TextStyle(
            foreground: Paint()
              ..strokeWidth = strokeWidth ?? 0
              ..color = strokeColor ?? Colors.white
              ..style = PaintingStyle.stroke,
          ).merge(style),
        ):Container(),
      ],
    );
  }
}
