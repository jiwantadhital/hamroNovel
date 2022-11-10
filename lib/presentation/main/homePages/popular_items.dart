import 'dart:convert';

import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/main/details/main_details.dart';
import 'package:books/presentation/resources/font_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:books/constants/app_constants.dart';
import 'package:sizer/sizer.dart';


class PopularItems extends StatefulWidget {
  const PopularItems({Key? key}) : super(key: key);

  @override
  State<PopularItems> createState() => _PopularItemsState();
}

class _PopularItemsState extends State<PopularItems> {

  @override
  Widget build(BuildContext context) {
    context.read<PopularController>().fetchData;
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: SizedBox(
        height: AppHeight.h250,
        child: Consumer<PopularController>(
          builder: ((context, value, child) {
            
            return
            value.novelList.length == 0 && !value.error?
            ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
              return Container(
                margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.1)
                ),
              );
            })):
             ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: value.novelList.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainDetailPage(
                                        pageId: value.novelList[index].id!-1,
                                      )),
                            );
              },
              child: Container(
                margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 243, 242, 242),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                       child: Container(
                        height: 190,
                        decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                    image: DecorationImage(image: 
                                    NetworkImage(
                      "${AppConstants.BASE_URL}/images/product/${value.novelList[index].image.toString()}",
                      ),
                                    fit: BoxFit.cover
                                    ),
                                  ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                         value.novelList[index].title.toString(),
                         textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      fontSize: FontSize.s12,
                        ),
                  ),
                    )
                  ],
                ),
              ),
            );
          }
          );
          }),
          )
      ),
    );
  }
}