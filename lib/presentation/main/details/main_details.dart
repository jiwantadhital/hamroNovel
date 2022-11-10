import 'dart:convert';
import 'dart:ui';

import 'package:books/controller/likes_controller.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/database/database.dart';
import 'package:books/data/likes/dao/likeDAO.dart';
import 'package:books/data/likes/like_database/likedatabase.dart';
import 'package:books/data/likes/like_model.dart';
import 'package:books/data/model/favourite_model.dart';
import 'package:books/presentation/main/details/chapters/bottom_sheet/bottom_sheet.dart';
import 'package:books/presentation/main/details/chapters/chapter_details.dart';
import 'package:books/presentation/main/details/chapters/chapter_list.dart';
import 'package:books/presentation/main/details/extras/attributes.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class MainDetailPage extends StatefulWidget {
  int pageId;
  MainDetailPage({required this.pageId});

  @override
  State<MainDetailPage> createState() => _MainDetailPageState();
}

class _MainDetailPageState extends State<MainDetailPage>
    with SingleTickerProviderStateMixin {


//

  String words = "Preparing";
  AppIcon icon = AppIcon(
    icon: Icons.download,
    iconColor: ColorManager.white,
    backgroundColor: ColorManager.primary,
  );
  DownloadContainer cont = DownloadContainer(
    backgroundColor: ColorManager.white,
  );
  bool downloaded = false;
   late String _user;
  String get user => _user;
      late LikeDAO _ldao;
  LikeDAO get ldao => _ldao;

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    _user = token.toString();
  }

  late FavouriteDAO _dao;
  FavouriteDAO get dao => _dao;

  int number  = 0;
  int chapterIndex = 0;
  int id = 1;
void _showSaved() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      number = (prefs.getInt('chapterIndex') ?? 0);
      chapterIndex = (prefs.getInt('ChapterNumber')??1);
      id = (prefs.getInt('pageId')??1);
    });
  }
  @override
  void initState() {
    super.initState();
      getDeviceTokenToSendNotification();
    _showSaved();
    downloaded;
    _insertData();
    _insertLike();
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(_handleTabSelection);
  }

  void _insertData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('edmt favourite.db').build();
    _dao = database.favouriteDAO;
  }

  

  TabController? _tabController;

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {});
    }
  }


    //For likes

   void _insertLike() async {
    final database =
        await $FloorLikeDatabase.databaseBuilder('edmt liked.db').build();
        _ldao = database.likeDAO;
  }
    IconData like_icon = Icons.favorite_outline;

  @override
  Widget build(BuildContext context) {
    var getLike = context.read<Token>().ldao;
    context.read<LikeController>().fetchData;
    _apply(int product_id) async {
      var data = {
        'user': user,
        'product_id': product_id,
      };
      var res = await CallApi().postData(data, 'add/data');

      var body = jsonDecode(res.body);
      if (body["success"]) {
        print("hoorrray");
      } else {
        print('error');
      }
    }
       _likes(int product_id,String name, String image) async {
      var data = {
        'name' : name,
        'image' : image,
        'liked': user,
        'product_id': product_id,
      };
      var res = await CallApi().postData(data, 'add/likes');

      var body = jsonDecode(res.body);
      if (body["success"]) {
        print("hoorrray");
      } else {
        print('error');
      }
    }

    var recent = context.read<NovelController>().novelList[widget.pageId];
    List<int?> newest = [];
    for (int i = 0; i < recent.comments!.length; i++) {
      newest.add(recent.comments?[i].likes!.toInt());
    }
    int sum = newest.fold(
        0, (previousValue, current) => previousValue + current!.toInt());
    double average = sum / recent.comments!.length;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: double.maxFinite,
                    height: 255,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "${AppConstants.BASE_URL}/images/product/${recent.image.toString()}",
                      ),
                    )),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.grey.withOpacity(0.09),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 70, top: 30),
                              height: MediaQuery.of(context).size.height * 0.19,
                              width: MediaQuery.of(context).size.height * 0.13,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 2, color: ColorManager.white),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${AppConstants.BASE_URL}/images/product/${recent.image.toString()}"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 50, left: 10),
                              height: 170,
                              width: 220,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Consumer<LikeController>(
                                    builder: (context,value,child){
                                      var arrayLike = value.likeList.where((x) => x.productId==recent.id).toList();
                                      int tlikes = arrayLike.length;
                                      return RichText(
                                    text:  TextSpan(
                                      children: [
                                        const WidgetSpan(
                                            child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )),
                                        TextSpan(
                                          text: tlikes.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  );
                                  }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.orange),
                                    alignment: Alignment.center,
                                    child: SmallText(
                                      text: "Ongoing",
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Attributes(
                                    atributeId: widget.pageId,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  top: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: AppIcon(
                          icon: Icons.arrow_back,
                          iconColor: ColorManager.white,
                          backgroundColor: ColorManager.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          downloaded = true;
                          try {
                            setState(() {
                              downloaded = true;
                            });
                            int product_id = recent.id!.toInt();
                            _apply(product_id);
                            Favourite fav = Favourite(
                              id: recent.id!.toInt(),
                              uid: "User Data",
                              all: json.encode(recent.toJson()),
                            );
                            await dao.insertFav(fav);
                            setState(() {
                              downloaded = false;
                            });
                            downloaded = false;
                            setState(() {});
                            final done = SnackBar(
                              content: Text("Done"),
                              backgroundColor: ColorManager.primary,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(done);
                          } catch (e) {
                            setState(() {
                              downloaded = false;
                            });
                            final done = SnackBar(
                              content: Text("Already downloaded"),
                              backgroundColor: ColorManager.primary,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(done);
                          }
                        },
                        child: downloaded ? cont : icon,
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      top:  MediaQuery.of(context).size.height<900? 237:257,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorManager.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppColumn(
                              text: recent.title.toString(),
                              ratings: average.toStringAsFixed(1),
                              comments: recent.comments!.length,
                            ),
                            SizedBox(
                              height: 10,
                            ),
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
                      top: MediaQuery.of(context).size.height<900?305:325,
                      left: 0,
                      right: 0,
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            Card(
                              shadowColor: Colors.black,
                              child: Container(
                                child: TabBar(
                                    controller: _tabController,
                                    unselectedLabelColor: Colors.black,
                                    indicator: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(5)),
                                    tabs: [
                                      Tab(
                                        child: Text("Details"),
                                      ),
                                      Tab(
                                        child: Text("Chapters"),
                                      ),
                                      Tab(
                                        child: Text("Comments"),
                                      ),
                                    ]),
                              ),
                            ),
                            MediaQuery.removePadding(
                              context: (context),
                              removeTop: true,
                              child: Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                padding: EdgeInsets.only(
                                    left: 10, right: 5, bottom: 55),
                                height:
                                   MediaQuery.of(context).size.height<900? MediaQuery.of(context).size.height * 0.55:MediaQuery.of(context).size.height*0.59,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 11,
                                        offset: Offset(0, 1))
                                  ],
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      TitleAndDescription(
                                          title:
                                              "Author: ${recent.createdBy!.name.toString()}",
                                          description:
                                              recent.description.toString()),
                                      ChapterList(pageId: widget.pageId),
                                      Scaffold(
                                        resizeToAvoidBottomInset: true,
                                        body: ListView.builder(
                                            itemCount: recent.comments!.length,
                                            itemBuilder: (context, mindex) {
                                              return Card(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              image:
                                                                  DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHA3zOkj4DNNVhgEjH4ugNV450Ft0YcOaDNcYWGYNu&s",
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover),
                                                            ),
                                                          ),
                                                          SmallText(
                                                            text: "Guest",
                                                            color: ColorManager
                                                                .darkGrey,
                                                            weight:
                                                                FontWeight.w400,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Center(
                                                            child: Container(
                                                              height: 20,
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: ColorManager
                                                                        .primary,
                                                                  ),
                                                                  SmallText(
                                                                    text:
                                                                        "${recent.comments![mindex].likes}/5",
                                                                    color: ColorManager
                                                                        .darkGrey,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0,
                                                                right: 10),
                                                        child: SmallText(
                                                          text: recent
                                                              .comments![mindex]
                                                              .comments
                                                              .toString(),
                                                          color: ColorManager
                                                              .darkGrey,
                                                          lines: 4,
                                                          weight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                        floatingActionButton:
                                            FloatingActionButton(
                                          backgroundColor: ColorManager.primary,
                                          child: Icon(Icons.chat),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return CommentSheet(
                                                        mindex:
                                                            recent.id!.toInt(),
                                                      );
                                                    })
                                                .whenComplete(
                                                    () => setState(() {}));
                                          },
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: FutureBuilder<List<UserLike?>>(
          initialData: [],
            future: getLike.getAllFav(),
            builder: (BuildContext context, AsyncSnapshot<List<UserLike?>> snapshot){
              List<int> saveLike = [];
              var favList = snapshot.data;
              var getData = favList!.where((x)=>x!.id==recent.id).toList();
              for(int i=0;i<getData.length;i++){
                  saveLike.add(getData[i]!.id);
              }
              int finalLike = saveLike.fold(
                          0,
                          (previousValue, current) =>
                              previousValue + current.toInt());
                              print(finalLike);
              return Container(
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: ColorManager.darkGrey)),
              child: Center(child: BigText(text: "14+",color: ColorManager.white,size: 15,))
            ),
           Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: ColorManager.darkGrey)),
              child: GestureDetector(
                onTap: ()async{
                  UserLike fav = UserLike(
                  id: recent.id!.toInt(),
                  image: recent.image!,
                  name: recent.title!,
                  );
                  await ldao.insertFav(fav);
                  setState(() {
                    
                  });
                  _likes(recent.id!, recent.title!, recent.image!);
                  final likes = SnackBar(
                              content: Text("Saved to Your Favourites"),
                              backgroundColor: ColorManager.primary,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(likes);
                  },
                
                child: Icon(
                 finalLike==recent.id?Icons.favorite:Icons.favorite_outline,
                  color: ColorManager.primary,
                ),
              ),
            ),
            Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.primary),
              child: Center(
                  child: id == widget.pageId?
                  GestureDetector(
                    onTap: (){
                       Navigator.push( context,         
                        MaterialPageRoute(
                        builder: (context) =>
                        ChapterDetails(
                        pageI:
                        id,
                        chapterIndex: number,
                        ),
                        ),
                        );
                    },
                    child: BigText(
                                  text: "Continue Chapter $chapterIndex",
                                  color: ColorManager.white,
                                ),
                  ):
                   GestureDetector(
                    onTap: (){
                       Navigator.push( context,         
                        MaterialPageRoute(
                        builder: (context) =>
                        ChapterDetails(
                        pageI:
                        widget.pageId,
                        chapterIndex: 0,
                        ),
                        ),
                        );
                    },
                    child: BigText(
                                  text: "Continue Chapter 1",
                                  color: ColorManager.white,
                                ),
                  ),
                  ),
            ),
          ],
        ),
      );
            }
    )
    );
  }
}

class CallApi {
  final String _url = "${AppConstants.BASE_URL}/api/";
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }
}

_setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };


