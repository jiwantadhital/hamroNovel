
import 'package:books/controller/attribute_controller.dart';
import 'package:books/controller/novel_controller.dart';
import 'package:books/presentation/routesManager/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();  
  static final MyApp instance = MyApp._internal();
  int appState = 0;

  factory MyApp()=>instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){
          return NovelController();
        },
        ),
        ChangeNotifierProvider(create: (context){
          return PopularController();
        },
        ),
       
        ChangeNotifierProvider(create: (context){
          return RecommendedController();
        },
        ),
        ChangeNotifierProvider(create: (context){
          return AttributeController();
        },
        ),
      ],
      child: MaterialApp(
              builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}