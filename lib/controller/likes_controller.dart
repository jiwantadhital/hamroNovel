import 'dart:convert';

import 'package:books/constants/app_constants.dart';
import 'package:books/data/likes/dao/likeDAO.dart';
import 'package:books/data/likes/like_database/likedatabase.dart';
import 'package:books/domain/models/like_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LikeController with ChangeNotifier{

   List<LikeModel> _likeList=[];
   bool _error = false;
   String _errorMessage = "";

   
  List<LikeModel> get likeList => _likeList;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchData async{

    final response = await http.get(Uri.parse("${AppConstants.BASE_URL}/api/show/likes"));
    print(response.body);
    if(response.statusCode == 200){
      
      try{
        _likeList = [];
        _likeList.addAll(List<LikeModel>.from(jsonDecode(response.body.toString()).map((x) => LikeModel.fromJson(x))));

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
      _likeList = [];
    }
    notifyListeners();
  }

  void initialValue(){
    _likeList =[];
    _error = false;
    _errorMessage = "";
    notifyListeners();
  }

}


class Token with ChangeNotifier{
  late String _user;
  String get user => _user;

  Future<void> get getDeviceTokenToSendNotification async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    _user = token.toString();
    notifyListeners();
  }
   late LikeDAO ldao;
   Future<void> get insertLike async {
    final database =
        await $FloorLikeDatabase.databaseBuilder('edmt liked.db').build();
        ldao = database.likeDAO;
        notifyListeners();
  }
}