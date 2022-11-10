import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class TitleAndDescription extends StatelessWidget {

String title;
String description;

TitleAndDescription({required this.title,required this.description});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                children: 
                  [
                    Text(title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Text(description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              ),
      ],
         ),
    );
  }
}