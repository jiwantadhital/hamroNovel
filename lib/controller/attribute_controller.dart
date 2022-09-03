import 'dart:convert';

import 'package:books/constants/app_constants.dart';
import 'package:books/domain/models/attribute_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AttributeController with ChangeNotifier{

   List<AttributeModel> _attributeList=[];
   bool _error = false;
   String _errorMessage = "";

   
  List<AttributeModel> get attributeList => _attributeList;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchData async{

    final response = await http.get(Uri.parse("${AppConstants.BASE_URL}/api/backend/attribute/all"));

    if(response.statusCode == 200){
      try{
        _attributeList = [];
        _attributeList.addAll(List<AttributeModel>.from(jsonDecode(response.body.toString()).map((x) => AttributeModel.fromJson(x))));
        _error = false;
      }
      catch(e){
        _error = true;
        _errorMessage = e.toString();
      }
      notifyListeners();
    }
    else{
      _error = true;
      _attributeList = [];
    }
    notifyListeners();
  }

  void initialValue(){
    _attributeList =[];
    _error = false;
    _errorMessage = "";
    notifyListeners();
  }

}