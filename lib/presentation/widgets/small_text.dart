import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {

final String text;
double size;
TextOverflow overflow;
Color color;
final height;
FontWeight weight;
int lines;

  SmallText({required this.text,this.lines=1,this.size=12,this.overflow=TextOverflow.ellipsis,this.color=const Color(0xFF32d2b),this.height=1.2,this.weight=FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      style: TextStyle(
        height: height,
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}