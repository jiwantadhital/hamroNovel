
import 'package:books/presentation/forgotPassword/forgot_password.dart';
import 'package:books/presentation/login/login.dart';
import 'package:books/presentation/main/bottomBar/bottom_bar.dart';
import 'package:books/presentation/main/homePages/popular_items.dart';
import 'package:books/presentation/main/homePages/recent%20release.dart';
import 'package:books/presentation/main/main_view.dart';
import 'package:books/presentation/onBoard/on_board.dart';
import 'package:books/presentation/register/register.dart';
import 'package:books/presentation/resources/string_manager.dart';
import 'package:books/presentation/saved/saved_novels.dart';
import 'package:books/presentation/splash/splash.dart';
import 'package:books/presentation/storeDetails/store_details.dart';
import 'package:flutter/material.dart';

class Routes{
  static const String splashRoute = "/";
  static const String onBoardinghRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String bottomBarRoute = "/bottomBar";
  static const String recentRoute = "/recent";
}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.splashRoute:
      return MaterialPageRoute(builder: (_)=>SplashView());
      case Routes.loginRoute:
      return MaterialPageRoute(builder: (_)=>LoginView());
      case Routes.registerRoute:
      return MaterialPageRoute(builder: (_)=>RegisterView());
      case Routes.onBoardinghRoute:
      return MaterialPageRoute(builder: (_)=>OnboardView());
      case Routes.forgotPasswordRoute:
      return MaterialPageRoute(builder: (_)=>ForgotPasswordView());
      case Routes.mainRoute:
      return MaterialPageRoute(builder: (_)=>MainView());
      case Routes.storeDetailsRoute:
      return MaterialPageRoute(builder: (_)=>StoreDetailsView());
      case Routes.bottomBarRoute:
      return MaterialPageRoute(builder: (_)=>BottomBarPage());;
      default:
      return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=>
    Scaffold(
      appBar: AppBar(title: Text(AppStrings.noRouteFound),),
      body: Center(
        child: Text(AppStrings.noRouteFound),
      ),
    ),
    );
  }
}