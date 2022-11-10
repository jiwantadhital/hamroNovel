
import 'package:books/data/likes/like_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class LikeDAO{

   @Query('SELECT * FROM UserLike')
   Future<List<UserLike?>> getAllFav();

   @insert
   Future<void> insertFav(UserLike fav);

   @delete
   Future<int> deleteFav(UserLike fav);

}
