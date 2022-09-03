
import 'package:books/controller/novel_controller.dart';
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:books/presentation/main/details/main_details.dart';
import 'package:books/presentation/main/homePages/popular_items.dart';
import 'package:books/presentation/main/homePages/recent%20release.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/string_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/icon_and_text_widget.dart';
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

  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 150;
  int countItem =5;

  String title = "";
  String desc = "";
  int like = 0;

  @override
  void initState() {
        super.initState();
    pageController.addListener(() { 
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<RecommendedController>().fetchData;
    return Expanded(
      child: RefreshIndicator(
         onRefresh: () async{
              await context.read<NovelController>().fetchData;
              await context.read<NovelController>().novelList;
              await context.read<PopularController>().novelList;
              await context.read<RecommendedController>().novelList;
            },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                child: PageView.builder(
                  controller: pageController,
                  itemCount: value.novelList.length,
                  itemBuilder: (context,position){
                    return _buildPageItem(position,value.novelList[position]);
                  },
                  ),
              );
                  }),),
                  Consumer<RecommendedController>(
                  builder: ((context, value, child) {
                return value.novelList.length == 0 && !value.error?
          Center(child: Container()):
          value.error?Text("Opps"):DotsIndicator(
                 dotsCount: value.novelList.length,
                 position: _currPageValue,
                 decorator: DotsDecorator(
                   activeColor: ColorManager.primary,
                   size: const Size.square(5.0),
                   activeSize: const Size(10.0, 5.0),
                   activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                 ),
                );
                  })),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left:AppPadding.p20,right: AppPadding.p20),
                  height: AppHeight.h40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.popularItems,
                      style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(AppStrings.seeAll,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorManager.primary,
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
                      Text(AppStrings.seeAll,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorManager.primary,
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
  Widget _buildPageItem(int index, NovelModel novelList){
                  List rating = novelList.comments!;
                      List<int?> newest = [];
                      for (int i = 0;
                          i < novelList.comments!.length;
                          i++) {
                        newest.add(
                            novelList.comments?[i].likes!.toInt());
                      }
                      int sum = newest.fold(
                          0,
                          (previousValue, current) =>
                              previousValue + current!.toInt());
                      double average =
                          sum / novelList.comments!.length;
    
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1,currScale,1);
      matrix = Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index == _currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1,currScale,1);
      matrix = Matrix4.diagonal3Values(1,currScale,1)..setTranslationRaw(0, currTrans, 0);
    }
    else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: 
          [
            GestureDetector(
              onTap: (){
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainDetailPage(
                                        pageId: novelList.id!-1,
                                      )),
                            );
              },
              child: Container(
              height: 220,
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
                        color: ColorManager.primary.withOpacity(0.5),
                        offset: Offset(0,1),
                        blurRadius: 2.0,
                      ),
                    ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "${AppConstants.BASE_URL}/images/product/${novelList.image.toString()}",
                    ),
                    ),
              ),
                      ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 105,
                margin: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 15),
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
                                        pageId: novelList.id!-1,
                                      )),
                            );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 14,left: 15,right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: novelList.title.toString(),color: Colors.black,size: AppSize.s14,),
                        SizedBox(height: 10,),
                        SmallText(text: "Last Updated Chapter  ${novelList.chapters![novelList.chapters!.length - 1].number}",color: ColorManager.primary,),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndTextWidget(icon: Icons.star, iconcolor: ColorManager.primary, text: "${average.toStringAsFixed(1)}/5"),
                            IconAndTextWidget(icon: Icons.comment, iconcolor: Colors.pink.shade400, text: "${novelList
                                                    .comments!.length
                                                    .toString()} comments"),
                            IconAndTextWidget(icon: Icons.favorite, iconcolor: ColorManager.primary, text: "33k"),
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
  }
}