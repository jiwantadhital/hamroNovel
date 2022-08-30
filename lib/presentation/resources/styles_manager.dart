import 'package:books/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily,FontWeight fontWeight, Color color){
 return TextStyle(fontSize:fontSize,fontFamily: fontFamily,color: color); 
}

//regular style
TextStyle getRegularStyle({double fontSize= FontSize.s12, required Color color}){
return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.regular,color);
}

//light style
TextStyle getLightStyle({double fontSize= FontSize.s12, required Color color}){
return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.light,color);
}

//bold text style
TextStyle getBoldStyle({double fontSize= FontSize.s12, required Color color}){
return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.bold,color);
}

//semibold style
TextStyle getSemiBoldStyle({double fontSize= FontSize.s12, required Color color}){
return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.semibold,color);
}

TextStyle getMediumStyle({double fontSize= FontSize.s12, required Color color}){
return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.medium,color);
}

