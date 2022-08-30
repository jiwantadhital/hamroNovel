
import 'dart:convert';

import 'package:books/controller/novel_controller.dart';
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/database/database.dart';
import 'package:books/data/model/favourite_model.dart';
import 'package:books/presentation/main/details/chapters/bottom_sheet/bottom_sheet.dart';
import 'package:books/presentation/main/details/chapters/chapter_details.dart';
import 'package:books/presentation/main/details/title_description.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/widgets/app_column.dart';
import 'package:books/presentation/widgets/app_icon.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:books/constants/app_constants.dart';
import 'package:http/http.dart' as http;





class MainDetailPage extends StatefulWidget {
int pageId;
MainDetailPage({required this.pageId});

  @override
  State<MainDetailPage> createState() => _MainDetailPageState();
}

class _MainDetailPageState extends State<MainDetailPage> {
      String words = "Preparing";
      AppIcon icon = AppIcon(icon: Icons.download,iconColor: ColorManager.white,backgroundColor: ColorManager.primary,);
      DownloadContainer cont = DownloadContainer(backgroundColor: ColorManager.white,);
      bool downloaded = false;
      late String _user;
  String get user => _user;

    late FavouriteDAO _dao;
    FavouriteDAO get dao => _dao;

   @override
  void initState() {
    super.initState();
    words;
    downloaded;
    _insertData();
    getDeviceTokenToSendNotification();
  }
   void _insertData() async{
    final database = await $FloorAppDatabase.databaseBuilder('edmt favourite.db').build();
   _dao = database.favouriteDAO;
  }
   Future<void> getDeviceTokenToSendNotification() async {
    		final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    		final token = await _fcm.getToken();
    		_user = token.toString();
  	}

  @override
  Widget build(BuildContext context) {

     _apply(int product_id)async{
      var data = {
    
        'user' : user,
        'product_id' : product_id,
      };
      var res = await CallApi().postData(data, 'add/data');

      var body = jsonDecode(res.body);
      if(body["success"]){
        print("hoorrray");
      }
      else{
        print('error');
      }
      
    }
    var recent = context.read<NovelController>().novelList[widget.pageId];
    var list = context.read<NovelController>().novelList;
    return Scaffold(
      body: Column(
        children: 
          [
            Expanded(
            child: Stack(
              children: 
                [
                  Positioned(
                        child: Container(
                  width: double.maxFinite,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "${AppConstants.BASE_URL}/images/product/${recent.image.toString()}",
                      ),
                      )
                  ),
                        ),
                        ),
                    Positioned(
                      left: 20,right: 20,top: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: AppIcon(icon: Icons.arrow_back,iconColor: ColorManager.white,backgroundColor: ColorManager.primary,),),
                              GestureDetector(
                            onTap: () async{
                              downloaded = true;
                              try{
                                setState(() {
                                    downloaded = true;
                                });
                              int product_id = recent.id!.toInt();
                              _apply(product_id);
                              Favourite fav =  Favourite(
                                id: recent.id!.toInt(),
                                uid: "User Data",
                                all: json.encode(recent.toJson()),
                                );
                                await dao.insertFav(fav);
                                setState(() {
                                downloaded = false;
                                });
                                downloaded = false;
                                setState(() {
                                  
                                });
                                 final done = SnackBar(content: Text("Done"),backgroundColor: ColorManager.primary,);
                              ScaffoldMessenger.of(context).showSnackBar(done);
                            
                              }
                              catch(e){
                                setState(() {
                                  downloaded = false;
                                });
                                final done = SnackBar(content: Text("Already downloaded"),backgroundColor: ColorManager.primary,);
                              ScaffoldMessenger.of(context).showSnackBar(done);
                              }
                            },
                            child: downloaded?cont:icon,),
                            
                        ],
                      ),
                      ),
                 Stack(
                   children: 
                        [
                          Positioned(
                          top: 210,left: 0,right: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorManager.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppColumn(text: recent.title.toString()),
                                  SizedBox(height: 10,),
                                   const Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    endIndent: 0,
                                    color: Colors.black38,
                                    ),
                                  ],
                                  ),
                                    ),
                        ),
                        Positioned(
                          top: 290,left: 0,right: 0,
                          child:  DefaultTabController(
                          length: 3,
                         child: Column(
                           children: [
                             Card(
                               shadowColor: Colors.black,
                               child: Container(
                                 child: TabBar
                                 (
                                   unselectedLabelColor: Colors.black,
                                   indicator: BoxDecoration(
                                     color: ColorManager.primary,
                                     borderRadius: BorderRadius.circular(5)
                                   ),
                                   tabs: [
                                     Tab(child: Text("Details"),),
                                      Tab(child: Text("Chapters"),),
                                       Tab(child: Text("Comments"),),
                                 ]
                                 ),
                               ),
                             ),
                             MediaQuery.removePadding(
                              context: (context),
                              removeTop: true,
                             child : Container(
                               margin: EdgeInsets.only(left: 5,right: 5),
                               padding: EdgeInsets.only(left: 10,right: 5,bottom: 50),
                               height: 400,
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                   boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 11,
                            offset: Offset(0, 1)
                          )
                        ],
                               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                               ),
                               child: TabBarView(
                                 children: [
                                   TitleAndDescription(title: recent.createdBy!.name.toString(), description: "Author : ${recent.createdBy!.name}"),
                                    ListView.builder(
                                    physics: BouncingScrollPhysics(),
                          itemCount: recent.chapters!.length,
                                  itemBuilder: ( BuildContext context, index) {
                                    return Card(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                        MaterialPageRoute(builder: (context) =>  ChapterDetails(
                                          pageI: widget.pageId,
                            
                                        )),
                                    );
                                            },
                                              child: Container(
                                    height: 50,
                                     child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/4.0,
                                              child: BigText(text: recent.chapters![index].number.toString(),color: Colors.black),
                                          ),
                                 Container(
                                          width: MediaQuery.of(context).size.width/1.5,
                                        child: BigText(text: recent.chapters![index].name.toString(),color: Colors.black,weight: FontWeight.w400,),
                                        ),
                                              ],
                                          ),
                                        ),
                                        ),
                              );
                              }),
                                   Scaffold(
                                    body: ListView.builder(
                                      itemCount: 5,
                                      itemBuilder: (context,index){
                                      return Container(
                                        padding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 5),
                                        margin: EdgeInsets.only(right: 30,top: 10),
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ColorManager.darkGrey.withOpacity(0.1)
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    image: DecorationImage(image: NetworkImage(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHA3zOkj4DNNVhgEjH4ugNV450Ft0YcOaDNcYWGYNu&s",
                                                    ),
                                                    fit: BoxFit.cover
                                                    ),
                                                    ),
                                                  ),
                                                  SmallText(text: "Guest",color: ColorManager.darkGrey,
                                                  weight: FontWeight.w400,
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Center(
                                                    child: Container(
                                                      height: 20,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.star,color: ColorManager.primary,),
                                                          SmallText(text: "4.5/5",color: ColorManager.darkGrey,)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.6,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:10.0,right: 10),
                                                child: SmallText(text: "This novel is not that good in a sense that there are a lot of plot holes in here as well the MC is raciest  here as well the MC is raciest  here as well the MC is raciest",color: ColorManager.darkGrey,lines: 4,
                                                weight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    floatingActionButton: FloatingActionButton(
                                      backgroundColor: ColorManager.primary,
                                      child: Icon(Icons.chat),
                                      onPressed: (){
                                        showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context, builder: (context){
                                      return CommentSheet();
                                      });
                                      },
                                    ),
                                   ),
                               ]
                               ),
                             ),),
                             SizedBox(height: 5,),
                           ],
                         ),
                       ),)
                      ],
                 ),
              ],
            ),
          ),
         

        ],
      ),
      bottomNavigationBar: Container(
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 2,color: ColorManager.darkGrey)
              ),
              child: Icon(Icons.share,color: ColorManager.primary,),
            ),
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 2,color: ColorManager.darkGrey)
              ),
              child: Icon(Icons.star_border_outlined,color: ColorManager.primary,),
            ),
            Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.primary
              ),
              child: Center(child: BigText(text:"Give Your Review",color: ColorManager.white,)),
            ),
          ],
        ),
      ),
      
         );
  }
}


class CallApi{

  final String _url = "http://10.0.2.2:8000/api/";
  postData(data,apiUrl)async{
    var fullUrl = _url+apiUrl;
    return await http.post(Uri.parse(fullUrl),
    body: jsonEncode(data),
    headers: _setHeaders(),
    );
  }
}
_setHeaders()=>{
'Content-type':'application/json',
'Accept':'application/json',
};