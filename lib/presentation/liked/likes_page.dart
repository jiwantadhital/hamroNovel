
import 'package:books/constants/app_constants.dart';
import 'package:books/data/likes/dao/likeDAO.dart';
import 'package:books/data/likes/like_model.dart';
import 'package:books/presentation/main/details/main_details.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LikedPage extends StatefulWidget {
  LikeDAO dao;
   LikedPage({Key? key,required this.dao}) : super(key: key);

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {

@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Center(child: Text("Favourites")),
      ),
      body: Container(
        color: Colors.white10,
        margin: EdgeInsets.only(left: 10,right: 10,top: 20,),
        child: FutureBuilder<List<UserLike?>>(
          initialData: [],
            future: widget.dao.getAllFav(),
            builder: (BuildContext context, AsyncSnapshot<List<UserLike?>> snapshot){
              var favList = snapshot.data;
                return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.55,
          ), 
          itemCount: favList!.length,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 25),
              
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainDetailPage(
                                        pageId: favList[index]!.id-1,
                                      )),
                            );
                    },
                    child: Stack(
                      children: [
                        Container(
                                    height: MediaQuery.of(context).size.height*0.22,
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1,color: ColorManager.lightGrey.withOpacity(0.1)),
                                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-2,0),
                        color: ColorManager.lightGrey.withOpacity(0.3),
                        blurRadius: 10
                      ),
                      ],
                        image: DecorationImage(image: NetworkImage(
                          "${AppConstants.BASE_URL}/images/product/${favList[index]!.image.toString()}",
                          )
                          ,fit: BoxFit.cover)
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(width: 2,color: ColorManager.white),
                                        color: Colors.red
                                      ),
                                      child: GestureDetector(
                                        onTap: ()async{
                                          var item = snapshot.data as List<UserLike?>;
                                         await widget.dao.deleteFav(item[index]!);
                                           setState(() {
                                           });
                                        },
                                        child: Icon(Icons.delete)),
                                    )
                                    
                                    )
                ]),
                  ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: SmallText(text: favList[index]!.name.toString(),color: Colors.black,lines: 2,),
              )
                ],
              )
            );
          }
                );
            }
              )
              )
            
          
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