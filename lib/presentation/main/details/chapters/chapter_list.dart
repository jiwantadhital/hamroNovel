import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/main/details/chapters/chapter_details.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterList extends StatefulWidget {
  int pageId;
   ChapterList({super.key,required this.pageId});

  @override
  State<ChapterList> createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {

int number = 0;
int chapterIndex = 0;
int id = 1;

   void _saveChapter(int number,int chapterNumber) async {
                final prefs = await SharedPreferences.getInstance();
                  setState(() {
                            prefs.setInt('chapterIndex', number);
                            prefs.setInt('ChapterNumber', chapterNumber);
                            prefs.setInt('pageId',widget.pageId);
                     });
                     print(prefs.getInt('chapterIndex'));
                     print(prefs.getInt('ChapterNumber'));
                    }
  void _showSaved() async {
    final prefs = await SharedPreferences.getInstance();
      number = prefs.getInt('chapterIndex')!.toInt();
      chapterIndex = prefs.getInt('ChapterNumber')!.toInt();
      id = prefs.getInt('pageId')?? -1;
  }

  @override
  void initState() {
    super.initState();
    _showSaved();
    number;
    chapterIndex;
  }

  @override
  Widget build(BuildContext context) {
    print(number);
        var recent = context.read<NovelController>().novelList[widget.pageId];

                                         return ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: recent.chapters!.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Card(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChapterDetails(
                                                              pageI:
                                                                  widget.pageId,
                                                                  chapterIndex: index,
                                                            )
                                                            ),
                                                  );
                                                  setState(() {
                                                    _saveChapter(index,recent.chapters![index].number! );
                                                    print("saved");
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4.0,
                                                        child: BigText(
                                                            text: recent
                                                                .chapters![
                                                                    index]
                                                                .number
                                                                .toString(),
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                        child: BigText(
                                                          text: recent
                                                              .chapters![index]
                                                              .name
                                                              .toString(),
                                                          color: Colors.black,
                                                          weight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
  }
}