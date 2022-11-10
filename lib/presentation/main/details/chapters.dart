import 'package:books/presentation/main/details/chapters/chapter_details.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:flutter/material.dart';

class Chapters extends StatelessWidget {
  const Chapters({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 20,
      itemBuilder: ( BuildContext context, index) {
      return Card(
      child: GestureDetector(
        onTap: (){
        // Navigator.push(
        // context,
        // MaterialPageRoute(builder: (context) =>  ChapterDetails()),
        // );
        },
        child: Container(
          height: 50,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/4.0,
                child: BigText(text: "1333: ",color: Colors.black),
                ),
                 Container(
                width: MediaQuery.of(context).size.width/1.5,
                child: BigText(text: "The day I was with you ",color: Colors.black,weight: FontWeight.w400,),
                ),
            ],
          ),
        ),
      ),
      );
    });
  }
}