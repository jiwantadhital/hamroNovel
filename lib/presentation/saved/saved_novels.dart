import 'dart:convert';

import 'package:books/constants/app_constants.dart';
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/database/database.dart';
import 'package:books/data/model/favourite_model.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/saved/saved_details.dart';
import 'package:flutter/material.dart';


class FavPage extends StatefulWidget {
  FavouriteDAO dao;
   FavPage({Key? key,required this.dao}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  

  
  var allData;


  @override
  Widget build(BuildContext context) {
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
              return ListView.builder(
            itemCount: favList!.length,
            itemBuilder: (context,index){
               allData = json.decode(favList[index]!.all);
              // // var newId = allData[0]["id"];
                var childrenClass = NovelModel.fromJson(allData);
              //   print(childrenClass);
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
                          child: GestureDetector(
                             onTap: ()async{
                                         var item = snapshot.data as List<Favourite?>;
                                         await widget.dao.deleteFav(item[index]!);
                                           setState(() {
                                             
                                           });
                                           
                                      },
                            child: Icon(Icons.delete,color: Colors.black45,)),
                        )
                      ],
                    ),
                  ),
                )
              );
          });
            },
          
        ),
      ),
    );
  }
}