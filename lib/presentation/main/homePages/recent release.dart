import 'package:books/constants/app_constants.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/main/details/main_details.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentItems extends StatelessWidget {
  const RecentItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NovelController>().fetchData;
    // var dao = context.read<LocalController>().data;
    // var all = Provider.of<LocalController>(context, listen: false).dao;
    return MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: Consumer<NovelController>(
        builder: (context, value, child) {
          return value.novelList.length == 0 && !value.error?
          Center(child: CircularProgressIndicator()):
          value.error?Text("Opps"):ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.novelList.length,
                        itemBuilder: (context,index){
                          // print(dao);
                          return Container(
                            margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                            child: GestureDetector(
                               onTap: () {
                        Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) =>  MainDetailPage(pageId: index,)),
                        );
                      },
                              child: Row(
                                children: 
                                  [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white38,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                           "${AppConstants.BASE_URL}/images/product/${value.novelList[index].image.toString()}",
                          ),
                          ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text:value.novelList[index].title.toString(),size: AppSize.s18,color: Colors.black,),
                              SizedBox(height: 15,),
                              SmallText(text: "Last Updated Chapter 1415",color: Colors.black54,size: AppSize.s14,),
                              SizedBox(height: 15,),
                              Row(
                    children: [
                      Wrap(
                        children: 
                          List.generate(1, (index) => Icon(Icons.star_border_outlined,color: ColorManager.primary,size: 15,),),
                      ),
                       SizedBox(width: 10,),
                       SmallText(text: value.novelList[index].likes.toString(),color: Colors.black38,),
                       SizedBox(width: 20,),
                       SmallText(text: "1287",color: Colors.black38,),
                       SizedBox(width: 5,),
                       SmallText(text: "comments",color: Colors.black38,),
                    ],
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                                ],
                              ),
                            ),
                          );
                      });
        }
                  ),
    );
  }
}