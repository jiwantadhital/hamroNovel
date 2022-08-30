import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatelessWidget {

final String text;
ExpandableTextWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
      child: Column(
        children: [
        Text(
          text,style: TextStyle(fontSize: 16,color: Colors.black45),
        )],
        ),
    );
  }
}

