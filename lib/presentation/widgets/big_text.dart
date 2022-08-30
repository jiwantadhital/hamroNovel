import 'package:flutter/material.dart';

class BigText extends StatelessWidget {

final String text;
double size;
TextOverflow overflow;
FontWeight weight;
Color color;

  BigText({required this.text,this.weight = FontWeight.w600,this.size=20,this.overflow=TextOverflow.ellipsis,this.color=const Color(0xFF32d2b)});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontWeight: weight,
        fontFamily: 'Roboto',
        fontSize: size,
      ),
    );
  }
}