import 'dart:async';

import 'package:books/controller/likes_controller.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/resources/asset_manager.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/routesManager/routes_manager.dart';
import 'package:books/presentation/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin{


  

  late Animation<double> animation;
  late AnimationController controller;
  Timer? _timer;

  
  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  _startDelay(){
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2),)..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    _timer = Timer(Duration(seconds: 4), _goNext);
  }
  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoardinghRoute);
  }

  @override
  Widget build(BuildContext context) {
    context.read<RecommendedController>().fetchData;
    context.read<NovelController>().fetchData;
    context.read<PopularController>().fetchData;
        context.read<NovelController>().fetchData;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: ScaleTransition(
        scale: animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: Image(
                  image: AssetImage(
                    ImageAssets.splashLogo,
                    ),
                    ),
              ),
            ),
            SizedBox(height: 10,),
            BigText(text: "Read All You Want",color: ColorManager.darkGrey,)

          ],
        ),
      ),
    );
  }
}