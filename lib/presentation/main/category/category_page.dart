import 'package:books/presentation/main/homePages/recent%20release.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        margin: EdgeInsets.only(left: 20,right: 20,top: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
          ), 
          itemCount: 30,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                 Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                            backgroundColor: ColorManager.white,
                            iconTheme: IconThemeData(
                              color: ColorManager.primary,
                            ),
                            elevation: AppSize.s1_5,
                            title: Center(child: BigText(text: "Science Fiction",color: ColorManager.primary,)),
                            systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: ColorManager.white,
                            statusBarBrightness: Brightness.dark,
                            statusBarIconBrightness: Brightness.dark,
        ),
      ),
                            body: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: SingleChildScrollView(child: RecentItems())),
                          );
                        }),
                        );
              },
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(96, 49, 43, 20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2,3),
                      color: Colors.black87.withOpacity(0.8)
                    )
                  ],
                ),
                child: Center(child: BigText(text: "Science Fiction",color: ColorManager.white,)),
              ),
            );
          },
          ),
      )
    );
  }
}