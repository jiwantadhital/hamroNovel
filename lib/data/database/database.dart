
import 'package:books/data/dao/favouriteDAO.dart';
import 'package:books/data/model/favourite_model.dart';
import 'package:floor/floor.dart';



import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version:1, entities:[Favourite])
abstract class AppDatabase extends FloorDatabase{
  FavouriteDAO get favouriteDAO;
}