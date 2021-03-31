import 'dart:ui';

import 'package:flutter/material.dart';

class OSMMarker extends StatelessWidget {
  final Color color;
  final Widget content;
  final double size;
  final String title;
  final String subtitle;
  final Color textColor;

  OSMMarker(
      {this.color = Colors.red,
      this.content,
      this.size,
      this.title,
      this.subtitle,
      this.textColor = Colors.black}) {}

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
          offset: Offset(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: content,
                width: size - size / 5,
                height: size - size / 5,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 2),
                  color: color,
                ),
              ),
              Transform.translate(
                  offset: Offset(0, -size / 10),
                  child: ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(
                      color: color,
                      height: size / 5,
                      width: size / 4,
                    ),
                  )),
                  Stack(
                  //fit: StackFit.,
                  children: [
                    SizedBox(
                      width: size - size / 5,
                      height: size - size / 5,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: new BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (title != null)
                                          ? Text(
                                              title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: size / 5,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Container(),
                                      (subtitle != null)
                                          ? Text(
                                              subtitle,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: textColor,
                                                fontSize: size / 6,
                                              ),
                                            )
                                          : Container(),
                                    ])))),
                  ],
                )
              
              //title
            ],
          )
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
