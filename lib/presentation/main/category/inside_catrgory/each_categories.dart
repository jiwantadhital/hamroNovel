import 'package:books/constants/app_constants.dart';
import 'package:books/controller/attribute_controller.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/main/details/main_details.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EachCategory extends StatelessWidget {
  int productId;
   EachCategory({super.key,required this.productId});

  @override
  Widget build(BuildContext context) {
    context.read<AttributeController>().fetchData;
   var novels = Provider.of<AttributeController>(context,listen: false).attributeList[productId];
    return SafeArea(
      child: Scaffold(
       body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorManager.primary,
              ColorManager.white,
            ],
            end: Alignment.bottomCenter,
        begin: Alignment.topCenter,
            ),
        ),
         child: Column(
           children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.034,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: ColorManager.white,)),
                BigText(text: novels.name.toString(),color: ColorManager.white,),
                Container(),
              ],
            ),
             Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
              height: MediaQuery.of(context).size.height*0.83,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.white,
                    Colors.white54,
                  ],
                   end: Alignment.bottomCenter,
        begin: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
              ),
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 5),
                child: Consumer<AttributeController>(
                  builder: (
                    (context, value, child) {
                  return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.55,
          ), 
          itemCount: novels.novel!.length,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 25),
              
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainDetailPage(
                                        pageId: novels.novel![index].id!-1,
                                      )),
                            );
                    },
                    child: Container(
                                  height: MediaQuery.of(context).size.height<900?MediaQuery.of(context).size.height*0.190:MediaQuery.of(context).size.height*0.180,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1,color: ColorManager.lightGrey.withOpacity(0.1)),
                                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-2,0),
                      color: ColorManager.lightGrey.withOpacity(0.3),
                      blurRadius: 10
                    ),
                    ],
                      image: DecorationImage(image: NetworkImage(
                        "${AppConstants.BASE_URL}/images/product/${novels.novel![index].image.toString()}",
                        )
                        ,fit: BoxFit.cover)
                                  ),
                                ),
                  ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: SmallText(text:novels.novel![index].title.toString(),color: Colors.black,lines: 2,),
              )
                ],
              )
            );
          }
                );
                }))
              ),
             ),
           ],
         ),
       ),
      ),
    );
  }
}