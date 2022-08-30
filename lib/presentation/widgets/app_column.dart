import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/icon_and_text_widget.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'big_text.dart';

class AppColumn extends StatelessWidget {

final String text;
AppColumn({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: text,color: Colors.black),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Wrap(
                            children: 
                              List.generate(5, (index) => Icon(Icons.star_border_outlined,color: Colors.pink,size: 15,),),
                          ),
                           SizedBox(width: 10,),
                           SmallText(text: "4.5",color: Colors.black38,),
                           SizedBox(width: 20,),
                           SmallText(text: "1287",color: Colors.black38,),
                           SizedBox(width: 5,),
                           SmallText(text: "comments",color: Colors.black38,),
                        ],
                      ),
                      // SizedBox(height: 20,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     IconAndTextWidget(icon: Icons.circle_sharp, iconcolor: ColorManager.primary, text: "Normal"),
                      //     IconAndTextWidget(icon: Icons.location_on, iconcolor: Colors.pink.shade400, text: "1.7km"),
                      //     IconAndTextWidget(icon: Icons.access_time_rounded, iconcolor: ColorManager.primary, text: "32min"),
                      //   ],
                      //   )
                    ],
                  );
  }
}




class AppColumn1 extends StatelessWidget {

final String text;
final String text1;
AppColumn1({required this.text, required this.text1});

  @override
  Widget build(BuildContext context) {
    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: text,color: Colors.black),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText(text: text1,weight: FontWeight.w500,color: ColorManager.primary,),
                           SizedBox(width: 10,),
                          Container(
                            height: AppHeight.h25,
                            width: AppWidth.w100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.darkPrimary,
                            ),
                            child: Center(child: SmallText(text: "Ongoing",color: ColorManager.white,)),
                          ),
                        ],
                      ),

                    ],
                  );
  }
}