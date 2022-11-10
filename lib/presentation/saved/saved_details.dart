import 'dart:convert';

import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/saved/saved_chapters.dart';
import 'package:books/presentation/widgets/app_column.dart';
import 'package:books/presentation/widgets/app_icon.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';


class SavedDetailPage extends StatelessWidget {
  FavouriteDAO dao;
  int pindex;
  var data;
   SavedDetailPage({Key? key, required this.dao,required this.pindex,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NovelModel childrenClass = NovelModel.fromJson(data);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: AppHeight.h120,
              pinned: true,
              backgroundColor: ColorManager.primary,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: AppIcon(icon: Icons.arrow_back,iconColor: ColorManager.lightGrey,)),
                  AppIcon(icon: Icons.delete,iconColor: ColorManager.lightGrey,),
                ],
              ),
              bottom: PreferredSize(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppSize.s20,top: AppSize.s10,right: AppSize.s20),
                    child: Column(
                      children: [
                        AppColumn1(text: childrenClass.title.toString(),text1: "Chapters: ${childrenClass.chapters!.length}"),
                      ],
                    ),
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: AppSize.s5,bottom: AppSize.s10),
                ),
                preferredSize: Size.fromHeight(20),
                ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset("assets/images/l1.jpg",
                fit: BoxFit.cover,
                width: double.maxFinite,
                ),
              ),
              expandedHeight: 280,
            ),
            SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: AppSize.s10,right: AppSize.s10,top: AppSize.s5),
              child: ListView.builder(
                shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                          itemCount: childrenClass.chapters!.length,
                                  itemBuilder: ( BuildContext context, index) {
                                    return Card(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                        MaterialPageRoute(builder: (context) =>  SavedChapters(
                                          pageI: index,
                                          chapterIndex: data,
                                        )),
                                    );
                                            },
                                              child: Container(
                                                padding: EdgeInsets.only(left: 5),
                                    height: 50,
                                     child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/4.0,
                                              child: BigText(text: childrenClass.chapters![index].number.toString(),color: Colors.black),
                                          ),
                                 Container(
                                          width: MediaQuery.of(context).size.width/1.6,
                                        child: BigText(text: childrenClass.chapters![index].name.toString(),color: Colors.black,weight: FontWeight.w400,),
                                        ),
                                              ],
                                          ),
                                        ),
                                        ),
                              );
                              }),
            ),    
            )
          ],
        ),
        
      ),
    );
  }
}
