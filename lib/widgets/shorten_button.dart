import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/animation.dart';
import 'package:shlink_app/common.dart';

class ShortenButton extends StatefulWidget {
  ShortenButton({Key key}) : super(key: key);

  @override
  _ShortenButtonState createState() => _ShortenButtonState();
}

class _ShortenButtonState extends State<ShortenButton>
    with TickerProviderStateMixin {
  var loading = false;
  Widget _currentWidget;
  AnimationController _controller;
  AnimationController _pulseAnimationController;
  var _buttonRadiusAnimation;
  var _pulseAnimation;

  @override
  void initState() {
    super.initState();
    //_currentWidget = button();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _buttonRadiusAnimation =
        new Tween(begin: 8.0, end: 50.0).animate(_controller);

    _pulseAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _pulseAnimation =
        new Tween(begin: 6.0, end: 16.0).animate(_pulseAnimationController);
    _pulseAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _pulseAnimationController.dispose();
  }

  Widget button() {
    return AnimatedBuilder(
        animation: _pulseAnimationController,
        builder: (BuildContext context, Widget child) {
          return Container(
              child: new CupertinoButton.filled(
                onPressed: () {
                  setState(() {
                    loading = !loading;
                  });
                  showSnackBar(text: "Shortening");
                },
                child: new Text((loading) ? "Loading" : "Shorten"),
                //borderRadius: BorderRadius.all(Radius.circular(_buttonRadiusAnimation.value)),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Get.theme.accentColor.withAlpha(60),
                      blurRadius: 10.0,
                      spreadRadius: _pulseAnimation.value == null
                          ? 6.0
                          : _pulseAnimation.value,
                      offset: Offset(
                        0.0,
                        3.0,
                      ),
                    ),
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return button();
    /*if(loading) {
      _currentWidget = Container(
          height: kMinInteractiveDimensionCupertino,
          width: kMinInteractiveDimensionCupertino,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle
          ),
        );
    } else {
      _currentWidget = button();
    }

    return AnimatedContainer(
      /*decoration: BoxDecoration(
          color: Get.theme.accentColor, 
          borderRadius: BorderRadius.circular(30)
      ),*/
      child: AnimatedSwitcher(
        child: new Container(
          child: _currentWidget,
          key: ValueKey<bool>(loading),
        ),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SizeTransition(child: child, sizeFactor: animation, axis: Axis.horizontal);
        },

        duration: Duration(milliseconds: 400), 
      ),
      duration: Duration(milliseconds: 400),
    );*/

    /*return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        print(_controller.value);
        return Container(
          child: new CupertinoButton.filled(
            onPressed: () {  
              if(loading) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
              loading=!loading;
              
            },
            child: new Text("Shorten"),
            borderRadius: BorderRadius.all(Radius.circular(_buttonRadiusAnimation.value)),
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Get.theme.accentColor.withAlpha(60),
                blurRadius: 10.0,
                spreadRadius: 6.0,
                offset: Offset(
                  0.0,
                  3.0,
                ),
              ),
            ]
          )
        );
      },
    );*/

    /*return Container(
      child: new CupertinoButton.filled(onPressed: () {  }, child: new Text("Shorten"),),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Get.theme.accentColor.withAlpha(60),
            blurRadius: 10.0,
            spreadRadius: 6.0,
            offset: Offset(
              0.0,
              3.0,
            ),
          ),
        ]
      )
    );*/
  }
}
