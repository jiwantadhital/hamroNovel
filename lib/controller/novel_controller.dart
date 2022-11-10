import 'dart:convert';

import 'package:books/constants/app_constants.dart';
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/database/database.dart';
import 'package:books/domain/models/novels_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class NovelController with ChangeNotifier{

   List<NovelModel> _novelList=[];
   bool _error = false;
   String _errorMessage = "";

   
  List<NovelModel> get novelList => _novelList;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchData async{

    final response = await http.get(Uri.parse("${AppConstants.BASE_URL}/api/backend/product/all"));

    if(response.statusCode == 200){
      try{
        _novelList = [];
        _novelList.addAll(List<NovelModel>.from(jsonDecode(response.body.toString()).map((x) => NovelModel.fromJson(x))));
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
      _novelList = [];
    }
    notifyListeners();
  }

  void initialValue(){
    _novelList =[];
    _error = false;
    _errorMessage = "";
        print("errorrr");

    notifyListeners();
  }

}

class RecommendedController with ChangeNotifier{

   List<NovelModel> _novelList=[];
   bool _error = false;
   String _errorMessage = "";

   
  List<NovelModel> get novelList => _novelList;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchData async{

    final response = await http.get(Uri.parse("${AppConstants.BASE_URL}/api/backend/product/recommended"));

    if(response.statusCode == 200){
      try{
        _novelList = [];
        _novelList.addAll(List<NovelModel>.from(jsonDecode(response.body.toString()).map((x) => NovelModel.fromJson(x))));
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
      _novelList = [];
    }
    notifyListeners();
  }

  void initialValue(){
    _novelList =[];
    _error = false;
    _errorMessage = "";
    notifyListeners();
  }

}


class PopularController with ChangeNotifier{

   List<NovelModel> _novelList=[];
   bool _error = false;
   String _errorMessage = "";

   
  List<NovelModel> get novelList => _novelList;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchData async{

    final response = await http.get(Uri.parse("${AppConstants.BASE_URL}/api/backend/product/recommended"));

    if(response.statusCode == 200){
      try{
        _novelList = [];
        _novelList.addAll(List<NovelModel>.from(jsonDecode(response.body.toString()).map((x) => NovelModel.fromJson(x))));
        print(response);
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
      _novelList = [];
    }
    notifyListeners();
  }

  void initialValue(){
    _novelList =[];
    _error = false;
    _errorMessage = "";
    notifyListeners();
  }

}

class LocalController with ChangeNotifier{
var _dao = "";
 String get dao => _dao;
Future<FavouriteDAO> get data async{
 final database = await $FloorAppDatabase.databaseBuilder('edmt favourite.db').build();
  final dao = database.favouriteDAO;
  return dao;
}

}