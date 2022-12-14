import 'package:books/data/likes/dao/likeDAO.dart';
import 'package:books/data/likes/like_database/likedatabase.dart';
import 'package:books/presentation/liked/likes_page.dart';
import 'package:books/presentation/main/category/category_page.dart';
import 'package:books/presentation/main/drawer/drawer_list.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({ Key? key }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  late LikeDAO _ldao;
  LikeDAO get ldao => _ldao;
  void _likeData() async{
    final database = await $FloorLikeDatabase.databaseBuilder('edmt liked.db').build();
   _ldao = database.likeDAO;
  }
  @override
  void initState() {
    super.initState();
    _likeData();
  }
  @override
  Widget build(BuildContext context) {
    return  ListView(
              padding: EdgeInsets.zero,
              children: [
                 DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 10,
                        spreadRadius: 7,
                      )
                    ]
                  ),
                  child: Image.asset("assets/images/books.png",fit: BoxFit.contain,),
                ),
                SizedBox(height: 10,),
               DrawerList(icon: Icons.all_inbox_outlined,iconColor: ColorManager.primary, text: "All Items",tap: (){
                            Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) =>  CategoryPage()),
                    );
               },),
              DrawerList(icon: Icons.favorite,text: "Favourites",iconColor: ColorManager.primary,
              tap: (){
                Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) =>  LikedPage(
                    dao: ldao,
                   )),
                    );
              },
              ),
               DrawerList(icon: Icons.support, text: "Support",iconColor: ColorManager.primary,),
               DrawerList(icon: Icons.system_security_update_good, text: "Terms and Condition",iconColor: ColorManager.primary,tap: (){},),
              ],
            );
  }
}