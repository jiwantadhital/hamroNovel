import 'package:books/controller/attribute_controller.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/main/category/inside_catrgory/each_categories.dart';
import 'package:books/presentation/main/homePages/recent%20release.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AttributeController>().fetchData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s1_5,
        title: Center(child: BigText(text: "Categories",color: ColorManager.primary,)),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10,right: 20,top: 20),
        child: Consumer<AttributeController>(
          builder: ((context, value, child) {
          return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
          ), 
          itemCount: value.attributeList.length,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.only(left: 10,bottom: 10),
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: ColorManager.lightGrey.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2,1),
                    color: ColorManager.grey.withOpacity(0.05),
                    blurRadius: 5
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                      context,
                  MaterialPageRoute(builder: (context) =>  EachCategory(productId: index,)),
                  );
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(width: 4,color: ColorManager.white),
                        image: DecorationImage(image: AssetImage("assets/images/l1.jpg"),
                        fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SmallText(text: value.attributeList[index].name.toString(),color: ColorManager.darkGrey,)
                ],
              ),
            );
          },
          );
        }))
      )
    );
  }
}