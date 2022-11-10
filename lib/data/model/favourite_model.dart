import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class Favourite{
  @primaryKey
  final int id;
  final String uid;
  final String all;


  Favourite({required this.id,required this.uid,required this.all});
}