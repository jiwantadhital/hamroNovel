import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/database/database.dart';
import 'package:books/data/likes/dao/likeDAO.dart';
import 'package:books/data/likes/like_database/likedatabase.dart';
import 'package:books/presentation/liked/likes_page.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/saved/saved_novels.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {


  //for likes
  late LikeDAO _ldao;
  LikeDAO get ldao => _ldao;
  void _likeData() async{
    final database = await $FloorLikeDatabase.databaseBuilder('edmt liked.db').build();
   _ldao = database.likeDAO;
  }
  late FavouriteDAO _dao;
  FavouriteDAO get dao => _dao;
    void _insertData() async{
    final database = await $FloorAppDatabase.databaseBuilder('edmt favourite.db').build();
   _dao = database.favouriteDAO;
  }

  @override
  void initState() {
    super.initState();
    _likeData();
    _insertData();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      backgroundColor: Color(0xFFD3D3D3),
      appBar: AppBar(
                            backgroundColor: ColorManager.white,
                            iconTheme: IconThemeData(
                              color: ColorManager.primary
                            ),
                            elevation: AppSize.s1_5,
                            title: Center(child: BigText(text: "Settings",color: ColorManager.primary,)),
                            systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: ColorManager.white,
                            statusBarBrightness: Brightness.dark,
                            statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            MediaQuery.of(context).size.height<900?
            Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 155,
                    decoration: BoxDecoration(
                      color: Color(0xFF39C7AA),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200),bottomRight: Radius.circular(200))
                    ),
                  ) ,
                  ),
                  Positioned(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 100),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue,
                          border: Border.all(width: 4,color: ColorManager.white),
                          image: DecorationImage(image: AssetImage(
                            "assets/images/prof.jpg",
                          ),
                          fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ), 
                    ),
              ],
            ):Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 355,
                    decoration: BoxDecoration(
                      color: Color(0xFF39C7AA),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100))
                    ),
                  ) ,
                  ),
                  Positioned(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 250),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue,
                          border: Border.all(width: 4,color: ColorManager.white),
                          image: DecorationImage(image: AssetImage(
                            "assets/images/prof.jpg",
                          ),
                          fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ), 
                    ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 50,
              child: BigText(text: "User_0123",color: Colors.black,size: AppSize.s28,),
            ),
            UserOption(option: "Report", icon: Icons.report,tap: (){
              showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('What do you want to report ?'),
          content: Container(
            height: 180,
            child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Problem Type",
                      border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 10,
                    color: Colors.white,
                  ),
            ),
            focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                   maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Problem Description",
                       border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 10,
                    color: Colors.white,
                  ),
            ),
            focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
                    ),
                  )
                ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
            },),
            UserOption(option: "Saved Books",icon: Icons.download,tap: () {
              Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) =>  FavPage(
                    dao: dao,
                   )),
                    );
            },),
            UserOption(option: "Favourites",icon: Icons.favorite_rounded,tap: (){
              Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) =>  LikedPage(
                    dao: ldao,
                   )),
                    );},),
            UserOption(option: "Rate our app",icon: Icons.star ),
            UserOption(option: "Share",icon: Icons.share),
          ],
        ),
      ),
    );
  }
}

class UserOption extends StatelessWidget {
  String option;
  IconData icon;
  void Function()? tap;
   UserOption({
    Key? key,
    required this.option,
    required this.icon,
    this.tap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
   margin: EdgeInsets.only(left: 15,right: 15,top: 2,bottom: 10),
      child: GestureDetector(
        onTap: tap,
        child: Container(
          padding: EdgeInsets.only(left: 20),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 10,),
              BigText(text: option,color: ColorManager.primary,),
            ],
          ),
        ),
      ),
    );
  }
}