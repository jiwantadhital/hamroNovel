import 'package:books/constants/app_constants.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/string_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  List<NovelModel> _searchList = [];

  @override
  void dispose() {
    _controller;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var forSearch = context.read<NovelController>().novelList;
    return Scaffold(
      body: Column(
        children: [
            SizedBox(height: AppMargin.m40,),
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
                      autofocus: true,
                      controller: _controller,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                          shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _searchList.length,
                            itemBuilder: (context,index){
                              return Container(
                                margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                                child: GestureDetector(
                                   onTap: () {
                            
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
                              SmallText(text: "Last Updated Chapter 1415",color: Colors.black54,size: AppSize.s14,),
                              SizedBox(height: 15,),
                              Row(
                    children: [
                      Wrap(
                        children: 
                          List.generate(1, (index) => Icon(Icons.star_border_outlined,color: ColorManager.primary,size: 15,),),
                      ),
                       SizedBox(width: 10,),
                       SmallText(text: _searchList[index].likes.toString(),color: Colors.black38,),
                       SizedBox(width: 20,),
                       SmallText(text: "1287",color: Colors.black38,),
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
                ),
        ],
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