import 'package:books/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class PageColor extends StatelessWidget {
  Color color;
   PageColor({
    Key? key,required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: ColorManager.white),
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
    );
  }
}


//pageFont
class PageFont extends StatelessWidget {
  String text;
   PageFont({
    Key? key,required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: ColorManager.white),
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.white,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}