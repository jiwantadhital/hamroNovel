import 'dart:convert';

import 'package:books/constants/app_constants.dart';
import 'package:books/controller/favourite_controller.dart';
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/database/database.dart';
import 'package:books/data/model/favourite_model.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/saved/saved_details.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class FavPage extends StatefulWidget {
  FavouriteDAO dao;
   FavPage({Key? key,required this.dao}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
   late String _user;
  String get user => _user;
  Widget delete = Icon(Icons.delete,color: Colors.black45);

Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    _user = token.toString();
  }  
  var allData;

@override
  void initState() {
    super.initState();
    getDeviceTokenToSendNotification();
  }
  @override
  Widget build(BuildContext context) {
           _apply(int sum) async {
                            var res = await DeleteApi().postData('favourite/${sum}');

                            var body = jsonDecode(res.body);
                            if (body[1]) {
                            print("hoorrray");
                            } else {
                            print('error');
                            }
                           }
        context.read<FavouriteController>().fetchData;
        var want =  context.read<FavouriteController>().fetchData;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Center(child: Text("Downloaded")),
      ),
      body: Container(
        color: Colors.white10,
        margin: EdgeInsets.only(left: 10,right: 10,top: 20,),
        child: FutureBuilder<List<Favourite?>>(
          initialData: [],
            future: widget.dao.getAllFav(),
            builder: (BuildContext context, AsyncSnapshot<List<Favourite?>> snapshot){
              var favList = snapshot.data;
              return Consumer<FavouriteController>(builder: ((context, value, child)  {
                return ListView.builder(
            itemCount: favList!.length,
            itemBuilder: (context,index){
               allData = json.decode(favList[index]!.all);
                var childrenClass = NovelModel.fromJson(allData);
              var delFav = value.favouriteList.where((x) => x.productId==childrenClass.id).where((y) => y.user==user).toList();
                List<int?> newest = [];
                  for (int i = 0; i < delFav.length; i++) {
                 newest.add(delFav[i].id);
                     }
                  int sum = newest.fold(
                          0,
                          (previousValue, current) =>
                              previousValue + current!.toInt());
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SavedDetailPage(
                                              pindex: index,
                                              dao: widget.dao,
                                              data : json.decode(favList[index]!.all),
                                            )),
                                  );
                          
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                              BoxShadow(
                                offset: Offset(0,2),
                                color: Colors.black12,
                                blurRadius: 4
                              )
                            ],
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 100,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          height: 90,
                          width: MediaQuery.of(context).size.width*0.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: NetworkImage(
                              "${AppConstants.BASE_URL}/images/product/${childrenClass.image.toString()}",
                              ),
                            fit: BoxFit.cover
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Column(
                            children: [
                              Text(
                              childrenClass.title.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(childrenClass.description.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                              ),
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width*0.15,
                          child: value.favouriteList.length!=0? GestureDetector(
                             onTap: ()async{
                              delete = Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: ColorManager.white,),
                              );
                                        _apply(sum);
                                        setState(() {
                                          
                                        });
                                         var item = snapshot.data as List<Favourite?>;
                                         await widget.dao.deleteFav(item[index]!);
                                           setState(() {
                                           });
                                           
                                      },
                            child: delete,
                            ):Container(),
                        )
                      ],
                    ),
                  ),
                )
              );
          });
              }));
            },
          
        ),
      ),
    );
  }
}



class DeleteApi {
  final String _url = "${AppConstants.BASE_URL}/api/";
  postData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.delete(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }
}

_setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };