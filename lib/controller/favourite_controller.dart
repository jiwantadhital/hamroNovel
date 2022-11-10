import 'dart:convert';

import 'package:books/constants/app_constants.dart';
import 'package:books/domain/models/attribute_model.dart';
import 'package:books/domain/models/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FavouriteController with ChangeNotifier{

   List<FavouriteModel> _favouriteList=[];
   bool _error = false;
   String _errorMessage = "";

   
  List<FavouriteModel> get favouriteList => _favouriteList;
  bool get error => _error;
  String get errorMessage => _errorMessage;


  Future<void> get fetchData async{

    final response = await http.get(Uri.parse("${AppConstants.BASE_URL}/api/getFav"));

    if(response.statusCode == 200){
      try{
        _favouriteList = [];
        _favouriteList.addAll(List<FavouriteModel>.from(jsonDecode(response.body.toString()).map((x) => FavouriteModel.fromJson(x))));

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
      _favouriteList = [];
    }
    notifyListeners();
  }

  void initialValue(){
    _favouriteList =[];
    _error = false;
    _errorMessage = "";
    notifyListeners();
  }

}


class SendApi {
  final String _url = "${AppConstants.BASE_URL}/api/";
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }
}
_setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };