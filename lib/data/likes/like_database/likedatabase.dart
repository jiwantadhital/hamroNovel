
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/likes/dao/likeDAO.dart';
import 'package:books/data/likes/like_model.dart';
import 'package:books/data/model/favourite_model.dart';
import 'package:floor/floor.dart';



import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'likedatabase.g.dart';

@Database(version:1, entities:[UserLike])
abstract class LikeDatabase extends FloorDatabase{
  LikeDAO get likeDAO;
}