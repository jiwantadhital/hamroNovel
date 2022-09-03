import 'package:books/constants/app_constants.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/main/details/main_details.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentItems extends StatelessWidget {
  const RecentItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NovelController>().fetchData;
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Consumer<NovelController>(builder: (context, value, child) {
        return value.novelList.length == 0 && !value.error
            ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.all(10),
                height: 150,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.lightGrey.withOpacity(0.1)
                ),
              );
            })
            : value.error
                ? Text("Opps")
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.novelList.length,
                    itemBuilder: (context, index) {
                      List rating = value.novelList[index].comments!;
                      List<int?> newest = [];
                      for (int i = 0;
                          i < value.novelList[index].comments!.length;
                          i++) {
                        newest.add(
                            value.novelList[index].comments?[i].likes!.toInt());
                      }
                      int sum = newest.fold(
                          0,
                          (previousValue, current) =>
                              previousValue + current!.toInt());
                      double average =
                          sum / value.novelList[index].comments!.length;
                      return Container(
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainDetailPage(
                                        pageId: value.novelList[index].id!-1,
                                      )),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "${AppConstants.BASE_URL}/images/product/${value.novelList[index].image.toString()}",
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          text: value.novelList[index].title
                                              .toString(),
                                          size: AppSize.s18,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        SmallText(
                                          text:
                                              "Last Updated Chapter ${value.novelList[index].chapters![value.novelList[index].chapters!.length - 1].number}",
                                          color: Colors.black54,
                                          size: AppSize.s14,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Wrap(
                                              children: List.generate(
                                                1,
                                                (index) => Icon(
                                                  Icons.star_border_outlined,
                                                  color: Colors.red,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            SmallText(
                                              text:
                                                  "${average.toStringAsFixed(1)}/5",
                                              color: Colors.black38,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SmallText(
                                              text: value.novelList[index]
                                                  .comments!.length
                                                  .toString(),
                                              color: Colors.black38,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SmallText(
                                              text: "comments",
                                              color: Colors.black38,
                                            ),
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
                    });
      }),
    );
  }
}
