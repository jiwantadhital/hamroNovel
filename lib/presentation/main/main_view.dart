import 'dart:async';

import 'package:books/constants/app_constants.dart';
import 'package:books/controller/attribute_controller.dart';
import 'package:books/controller/likes_controller.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/database/database.dart';
import 'package:books/data/likes/dao/likeDAO.dart';
import 'package:books/data/likes/like_database/likedatabase.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:books/notification/local_notification.dart';
import 'package:books/presentation/main/details/main_details.dart';
import 'package:books/presentation/main/drawer/drawer_items.dart';
import 'package:books/presentation/main/homePages/home_page.dart';
import 'package:books/presentation/main/homePages/recent%20release.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/string_manager.dart';
import 'package:books/presentation/resources/styles_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/routesManager/routes_manager.dart';
import 'package:books/presentation/saved/saved_novels.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  TextEditingController _controller = TextEditingController();
  List<NovelModel> _searchList = [];

  late FavouriteDAO _dao;
  FavouriteDAO get dao => _dao;
  int number = 0;
@override
  void dispose() {
    super.dispose();
    _controller;
    _searchList;
  }
   @override
  void initState() {
    super.initState();
    context.read<Token>().insertLike;
    _insertData();
    // _loadCounter();

     FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        
        if (message != null) {
          setState(() {
            number+1;
          });
                    print("New Notification");
            if (message.notification!.body != null) {
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => RecentItems()),
              // );
          }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          setState(() {
            number+1;
          });
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );
     FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        
        if (message.notification != null) {
           print("FirebaseMessaging.onMessageOpenedApp.listen");
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

 
   void _insertData() async{
    final database = await $FloorAppDatabase.databaseBuilder('edmt favourite.db').build();
   _dao = database.favouriteDAO;
  }

  

 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
      StreamController<int> _countController = StreamController<int>();
      context.read<AttributeController>().fetchData;
      

     return Scaffold(
    drawer: Container(
      width: AppWidth.w250,
        child: ClipRRect(
          child: Drawer(
          child:DrawerWidget(
          ),
          ),
        ),
    ),
    key: _scaffoldKey,
    body: Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: AppPadding.p20,right: AppPadding.p20),
            margin: EdgeInsets.only(top: AppMargin.m40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Icon(
                    Icons.menu_open_rounded,
                    size: IconSize.i28,
                    color: ColorManager.primary,
                    ),
                ),
                  SizedBox(width: AppWidth.w8,),
                Text(
                  AppStrings.homepage,
                  style: getBoldStyle(color: ColorManager.darkGrey,fontSize: 20),
                ),
                SizedBox(width: AppWidth.w8,),
                Container(
                  width: AppWidth.w30,
                  height: AppHeight.h30,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: ColorManager.primary,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavPage(dao: dao)),
              );
                    },
                    child:   const Icon(
                          Icons.download,
                          color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppMargin.m10,),
          Container(
            padding: EdgeInsets.only(left: AppPadding.p20,right: AppPadding.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white
                    ),
                    child:   TextField(
                      cursorColor: Color.fromRGBO(255, 141, 13, 1),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.search,
                          color: ColorManager.primary,
                          size: IconSize.i25,
                          ),
                          border: InputBorder.none,
                          hintText: AppStrings.searchHint,
                          hintStyle: TextStyle(color: Colors.black26,fontSize: 10)
                      ),
                      onChanged: _onSearchTextChanged,
                    ),
                  ),
                ),
                SizedBox(width: AppWidth.w12,),
                Container(
                  width: AppWidth.w50,
                  height: AppHeight.h50,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: ColorManager.white,
                  ),
                  child:  Icon(
                    Icons.filter_list,
                    color: ColorManager.darkGrey,
                    ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppHeight.h5,),
           const Divider(
            height: 1,
            thickness: 0.5,
            endIndent: 0,
            color: Colors.black38,
          ),
          SizedBox(height: AppHeight.h5,),
            _searchList.length != 0 || _controller.text.isNotEmpty?
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                          shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _searchList.length,
                            itemBuilder: (context,index){
                               List<int?> newest = [];
                      for (int i = 0;
                          i < _searchList[index].comments!.length;
                          i++) {
                        newest.add(
                            _searchList[index].comments?[i].likes!.toInt());
                      }
    int sum = newest.fold(
                          0,
                          (previousValue, current) =>
                              previousValue + current!.toInt());
                      double average =
                          sum / _searchList[index].comments!.length;
                              return Container(
                                margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                                child: GestureDetector(
                                    onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainDetailPage(
                                        pageId: _searchList[index].id!-1,
                                      )),
                            );
                          },
                                  child: Row(
                                    children: 
                                      [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "${AppConstants.BASE_URL}/images/product/${_searchList[index].image.toString()}",
                              ),
                              ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              BigText(text:_searchList[index].title.toString(),size: AppSize.s18,color: Colors.black,),
                              SizedBox(height: 15,),
                              SmallText(text: "Last Updated Chapter ${_searchList[index].chapters![_searchList[index].chapters!.length - 1].number}",color: Colors.black54,size: AppSize.s14,),
                              SizedBox(height: 15,),
                              Row(
                    children: [
                      Wrap(
                        children: 
                          List.generate(1, (index) => Icon(Icons.star_border_outlined,color: ColorManager.primary,size: 15,),),
                      ),
                       SizedBox(width: 10,),
                       SmallText(text: "${average.toStringAsFixed(1)}/5",color: Colors.black38,),
                       SizedBox(width: 20,),
                       SmallText(text: _searchList[index]
                                                  .comments!.length
                                                  .toString(),color: Colors.black38,),
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
                          }),
                    ),
                  ),
                )
          :HomePageBody(),
        ],
      ),
    ),
   );
  }
   _onSearchTextChanged(String text)async{
      var all = Provider.of<NovelController>(context,listen: false).novelList;
      _searchList.clear();
      if(text.isEmpty){
        setState(() {
        });
        return;
      }
      all.forEach((searchDetails) {
        if(searchDetails.title!.toLowerCase().contains(text.toLowerCase())){
          _searchList.add(searchDetails);
        }
       });
       setState(() {
         
       });
    }
}