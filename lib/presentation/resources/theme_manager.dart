import 'package:books/presentation/resources/color_manager.dart';
import 'package:books/presentation/resources/font_manager.dart';
import 'package:books/presentation/resources/styles_manager.dart';
import 'package:books/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData(

//main colors of App
primaryColor: ColorManager.primary,
primaryColorLight: ColorManager.primary.withOpacity(0.7),
primaryColorDark: ColorManager.darkPrimary,
splashColor: ColorManager.primary.withOpacity(0.7),
disabledColor: ColorManager.grey1,


//card view theme
cardTheme: CardTheme(
  color: ColorManager.white,
  shadowColor: ColorManager.grey,
  elevation: AppSize.s4,
),

//App bar theme
appBarTheme: AppBarTheme(
  centerTitle: true,
  color: ColorManager.primary,
  elevation: AppSize.s4,
  shadowColor: ColorManager.primary.withOpacity(0.7),
  titleTextStyle: getRegularStyle(
    color: ColorManager.white,
    fontSize: FontSize.s16,
    ),
    ),




//Button theme

buttonTheme: ButtonThemeData(
  shape: StadiumBorder(),
  disabledColor: ColorManager.grey1,
  buttonColor: ColorManager.primary,
  splashColor: ColorManager.primary.withOpacity(0.7),
),

//elevated button theme
elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    textStyle: getRegularStyle(color: ColorManager.white),
    primary: ColorManager.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12),),
  ),
),


//Text theme
textTheme: TextTheme(
  headline2: getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),
  subtitle1: getMediumStyle(color: ColorManager.lightGrey,fontSize: FontSize.s14),
  subtitle2: getMediumStyle(color: ColorManager.primary,fontSize: FontSize.s14),
  caption: getRegularStyle(color: ColorManager.grey1),
  bodyText1: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s16)
),


//Input decoration theme(text from theme)

inputDecorationTheme: InputDecorationTheme(
  contentPadding: EdgeInsets.all(AppPadding.p8),
  //hintStyle
  hintStyle: getRegularStyle(color: ColorManager.grey1),
  //labelStyle
  labelStyle: getMediumStyle(color: ColorManager.darkGrey),
  //errorStyle
  errorStyle: getRegularStyle(color: ColorManager.error),

  //enabledBorder
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorManager.grey,width: AppSize.s1_5),
    borderRadius: BorderRadius.all(Radius.circular(AppSize.s8),),
  ),

  //focusedBorder
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
    borderRadius: BorderRadius.all(Radius.circular(AppSize.s8),),
  ),

  //error border
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorManager.error,width: AppSize.s1_5),
    borderRadius: BorderRadius.all(Radius.circular(AppSize.s8),),
  ),

  //focusedError border
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
    borderRadius: BorderRadius.all(Radius.circular(AppSize.s8),),
  ),
),
  );
}