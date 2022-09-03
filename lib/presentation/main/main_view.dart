import 'dart:async';

import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/database/database.dart';
import 'package:books/notification/local_notification.dart';
import 'package:books/presentation/main/drawer/drawer_items.dart';
import 'package:books/presentation/main/homePages/home_page.dart';
import 'package:books/presentation/main/homePages/recent%20release.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/string_manager.dart';
import 'package:books/presentation/resources/styles_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/routesManager/routes_manager.dart';
import 'package:books/presentation/saved/saved_novels.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {


  late FavouriteDAO _dao;
  FavouriteDAO get dao => _dao;
  int number = 0;
  //  void _loadCounter() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     number = (prefs.getInt('notification') ?? 0);
  //   });
  // }
   @override
  void initState() {
    super.initState();
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
           Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecentItems()),
              );
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
      
      

     return Scaffold(
    drawer: Container(
      width: AppWidth.w250,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(90.0)),
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
                    Icons.menu_open,
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
          HomePageBody(),
        ],
      ),
    ),
   );
  }
}