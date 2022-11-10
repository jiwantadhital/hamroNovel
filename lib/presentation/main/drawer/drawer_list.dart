
import 'package:flutter/material.dart';


class DrawerList extends StatelessWidget {

final String text;
final IconData icon;
final Color? iconColor;
final Color? textColor;
VoidCallback? tap;

DrawerList({required this.icon,this.iconColor,required this.text,this.textColor,this.tap});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
                    onTap: tap,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(icon,color: iconColor,),
                      SizedBox(width: 10,),
                      Text(text,style: TextStyle(
                        color: Colors.black,
                      ),)
                    ],
                  ),
                );
  }
}