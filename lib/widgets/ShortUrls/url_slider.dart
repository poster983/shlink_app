

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shlink_app/widgets/BetterIcon.dart';



class URLSlider extends StatefulWidget {
  const URLSlider({super.key, required this.url, this.onSlideEnd, this.onSlideTap, this.onTap, this.slideMessage, this.color = const Color(0xFFFF3B30), this.slideIcon});

  final Uri url;
  final VoidCallback? onSlideEnd;
  final VoidCallback? onSlideTap;
  final VoidCallback? onTap;
  final String? slideMessage;
  final Color color;
  final IconData? slideIcon;

  


  @override
  State<URLSlider> createState() => _URLSliderState();
}

class _URLSliderState extends State<URLSlider> {
  bool _isSliding = false;


  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(90),
            
          ),

          padding: EdgeInsets.symmetric(horizontal: Theme.of(context).textTheme.bodyText1!.fontSize! * 2, vertical: 5),

          child: Center(
            child: AutoSizeText(
              widget.url.toString(),
              maxLines: 1,
              style: TextStyle(
                color: widget.color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ) 
            
        ),
          
          
        

        Positioned(
            right: 0,
            child:GestureDetector(
          
          child: FittedBox(
            fit: BoxFit.cover,
            child: Container(
            
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: widget.color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(90),
              ),
              child: BetterIcon(_isSliding? 
                  CupertinoIcons.arrow_left
                  : widget.slideIcon ?? CupertinoIcons.arrow_left, 
                color: widget.color.computeLuminance() > 0.5 ? Colors.white : Colors.black),
            ),
            )
          ))
      ],
    );
    
    
  }
}


