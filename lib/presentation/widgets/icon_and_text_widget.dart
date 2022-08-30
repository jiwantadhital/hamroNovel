import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';

class IconAndTextWidget extends StatelessWidget {

  final IconData icon;
  final String text;
  final Color color;
  final Color iconcolor;

   IconAndTextWidget({required this.icon,required this.iconcolor,required this.text,this.color= Colors.black38});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconcolor,),
        SizedBox(width: 5,),
        SmallText(text: text,color: color,)
      ],
    );
  }
}