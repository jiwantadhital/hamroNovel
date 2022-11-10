import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Attributes extends StatelessWidget {
  int atributeId;
  Attributes({Key? key, required this.atributeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var attribute = context.read<NovelController>().novelList[atributeId];
    return Container(
      height: 20,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: attribute.attributes!.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: EdgeInsets.only(right: 5),
              height: 10,
              width: 70,
              decoration: BoxDecoration(
                  color: ColorManager.darkGrey,
                  borderRadius: BorderRadius.circular(5)),
              alignment: Alignment.center,
              child: SmallText(
                text: attribute.attributes![index].name.toString(),
                color: ColorManager.white,
              ),
            );
          })),
    );
  }
}