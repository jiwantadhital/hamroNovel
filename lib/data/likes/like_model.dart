import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class UserLike{
  @primaryKey
  final int id;
  final String name;
  final String image;


  UserLike({required this.id,required this.name,required this.image});
}