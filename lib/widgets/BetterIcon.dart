import 'package:flutter/widgets.dart';

class BetterIcon extends StatelessWidget {
  const BetterIcon(this.icon, {Key? key, this.size, this.color, this.shadows, this.fit = BoxFit.none}) : super(key: key);

  final IconData icon;
  final double? size;
  final Color? color;
  final List<Shadow>? shadows;
  final BoxFit fit;


  @override
  Widget build(BuildContext context) {
    return  FittedBox(
    fit: fit,
    child: Text(
      String.fromCharCode(icon.codePoint),
      // textAlign: TextAlign.center,
      style: TextStyle(
        inherit: false,
        shadows: shadows,
        fontSize: size,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
        color: color
      ),
    ));
  }
}