
import 'package:books/controller/likes_controller.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:books/presentation/main/category/category_page.dart';
import 'package:books/presentation/main/details/main_details.dart';
import 'package:books/presentation/main/homePages/popular_items.dart';
import 'package:books/presentation/main/homePages/recent%20release.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/string_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/icon_and_text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:books/constants/app_constants.dart';
import 'package:provider/provider.dart';


class HomePageBody extends StatefulWidget {


  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  
  PageController pageController = PageController(viewportFraction: 0.92);
  int myIndex = 0;
  double _height = 150;
  int countItem =5;

  String title = "";
  String desc = "";
  int like = 0;

  @override
  void initState() {
        super.initState();
    pageController.addListener(() { 
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<LikeController>().fetchData;
    context.read<RecommendedController>().fetchData;
    return Expanded(
      child: RefreshIndicator(
         onRefresh: () async{
              await context.read<NovelController>().fetchData;
              await context.read<NovelController>().novelList;
              await context.read<PopularController>().fetchData;
              await context.read<RecommendedController>().fetchData;
            },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child:  Column(
            children: 
              [
                Consumer<RecommendedController>(
                  builder: ((context, value, child) {
                return value.novelList.length == 0 && !value.error?
          Container(
            margin: EdgeInsets.all(10),
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.withOpacity(0.1)
            ),
          ):
          value.error?Text("Opps"):Container(
                height: 270,
                child:CarouselSlider.builder(
              itemCount: value.novelList.length,
              options: CarouselOptions(
                height: 250,
                autoPlay: false,
                aspectRatio: 2.0,
                viewportFraction: 0.9,
                enlargeCenterPage: false,
                onPageChanged: (index,reason){
                  setState(() {
                    myIndex = index;
                  });
                }
              ),
              itemBuilder: ((context, index, realIndex) {
                    List rating = value.novelList[index].comments!;
                      List<int?> newest = [];
                      for (int i = 0;
                          i < value.novelList[index].comments!.length;
                          i++) {
                        newest.add(
                            value.novelList[index].comments?[i].likes!.toInt());
                      }
                      int sum = newest.fold(
                          0,
                          (previousValue, current) =>
                              previousValue + current!.toInt());
                      double average =
                          sum / value.novelList[index].comments!.length;
                return Container(
            height: 500,
            decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)

            ),
                child: Stack(
              children: 
                [
                  GestureDetector(
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
                    height: 200,
                    margin: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 129, 127, 127),
                              offset: Offset(0,2),
                              blurRadius: 2.0,
                            ),
                             BoxShadow(
                              color: Colors.green.withOpacity(0.5),
                              offset: Offset(0,1),
                              blurRadius: 2.0,
                            ),
                          ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "${AppConstants.BASE_URL}/images/product/${value.novelList[index].image.toString()}",
                          ),
                          ),
                    ),
                            ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 105,
                      margin: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF9e9e9),
                            offset: Offset(0,5),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: GestureDetector(
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
                          margin: EdgeInsets.only(top: 14,left: 15,right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: value.novelList[index].title!,color: Colors.black,size: 14,),
                              SizedBox(height: 10,),
                              SmallText(text: "Last Updated Chapter  ${value.novelList[index].chapters![value.novelList[index].chapters!.length - 1].number}",color: Colors.green,),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndTextWidget(icon: Icons.star, iconcolor: Colors.green, text: "${average.toStringAsFixed(1)}/5"),
                                  IconAndTextWidget(icon: Icons.comment, iconcolor: Colors.pink.shade400, text: "${value.novelList[index]
                                                    .comments!.length
                                                    .toString()} comments"),
                      
                                   Consumer<LikeController>(builder: (context,need,child){
                            var arrayLike = need.likeList.where((x) => x.productId==value.novelList[index].id).toList();
                                      int tlikes = arrayLike.length;
                            return IconAndTextWidget(icon: Icons.favorite, iconcolor: ColorManager.primary, text: tlikes.toString());
                           })
                                ],
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ),
             
              ],
            ),
              );
              }),
            ),
              );
                  }),),
                  Consumer<RecommendedController>(
                  builder: ((context, value, child) {
                return value.novelList.length == 0 && !value.error?
          Center(child: Container()):
          value.error?Text("Opps"): DotsIndicator(
                                      dotsCount: value.novelList.length,
                                      position:myIndex.toDouble(),
                                      decorator: DotsDecorator(
                                        activeColor: Colors.green,
                                        size: const Size.square(5.0),
                                        activeSize: const Size(10.0, 5.0),
                                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                      ),
                                     );
                  })),
                Container(
                  padding: EdgeInsets.only(left:AppPadding.p20,right: AppPadding.p20),
                  height: AppHeight.h40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.popularItems,
                      style: Theme.of(context).textTheme.bodyText1,
                      ),
                      GestureDetector(
                        onTap: (){
                                      Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) =>  CategoryPage()),
                    );
                        },
                        child: Text(AppStrings.seeAll,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorManager.primary,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              PopularItems(),
              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.only(left:AppPadding.p20,right: AppPadding.p20),
                  height: AppHeight.h40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.recentItems,
                      style: Theme.of(context).textTheme.bodyText1,
                      ),
                      GestureDetector(
                        onTap: (){
                                Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) =>  CategoryPage()),
                    );
                        },
                        child: Text(AppStrings.seeAll,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorManager.primary,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
               RecentItems(),
            ],
          ),
                  
                  ),
                  ),
        );
      
  }

}