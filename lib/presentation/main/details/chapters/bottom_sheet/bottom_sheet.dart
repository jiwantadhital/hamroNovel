// ignore_for_file: constant_identifier_names

import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.65,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: new BorderRadius.only(
        topLeft: const Radius.circular(25.0),
        topRight: const Radius.circular(25.0),
      ),
      ),
      child: Items(),
    );
  }
}


 
class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  int _value = 1;



  @override
  Widget build(BuildContext context) {
  
    return Column(
        children: [
        Container(
          height: 30,
          width: double.maxFinite,
          child: Center(child: BigText(text: "Write A Review",color: ColorManager.darkGrey,)),
        ),    
        SizedBox(height: 20,),
             Container(
              height: 30,
              width: double.maxFinite,
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width:MediaQuery.of(context).size.width*0.15,
                    child: SmallText(text: "Rate it: ",color: ColorManager.darkGrey,size: 15,)),
                  Container(
                    width:MediaQuery.of(context).size.width*0.80,
                    child: Row(
                      children: [
                        for(int i=1;i<=5;i++)
                        Radio(
                          value: i, groupValue: _value, onChanged:(int? value){
                            setState(() {
                              _value = value!;
                            });
                          })
                      ],
                    ),
                    ),
                  
                  
                ],
              ),
             ),
        ],
      );
  }
}