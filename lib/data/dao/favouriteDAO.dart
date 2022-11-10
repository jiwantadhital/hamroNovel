
import 'package:books/data/model/favourite_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class FavouriteDAO{

   @Query('SELECT * FROM Favourite')
   Future<List<Favourite?>> getAllFav();

   @Query('SELECT * FROM Favourite WHERE uid=:uid AND id=:id')
   Future<Favourite?> getFavByUid(String uid, int id);

   @insert
   Future<void> insertFav(Favourite fav);

   @delete
   Future<int> deleteFav(Favourite fav);

}
