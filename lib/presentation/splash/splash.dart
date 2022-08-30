import 'dart:async';

import 'package:books/presentation/resources/asset_manager.dart';
import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/routesManager/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  Timer? _timer;

  _startDelay(){
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2),)..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    _timer = Timer(Duration(seconds: 4), _goNext);
  }
  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoardinghRoute);
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: ScaleTransition(
        scale: animation,
        child: Center(
          child: Image(
            image: AssetImage(
              ImageAssets.splashLogo,
              ),
              ),
        ),
      ),
    );
  }
}