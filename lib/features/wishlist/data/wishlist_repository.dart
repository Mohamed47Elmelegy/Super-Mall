import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class WishListRepository {
  Future<List<String>> getWishListIds(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'wishlist_user_$userId';
    final ids = prefs.getStringList(key) ?? [];
    log('Getting wishlist ids for user $userId: $ids');
    return ids;
  }

  Future<void> addToWishList(int userId, String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'wishlist_user_$userId';
    final ids = prefs.getStringList(key) ?? [];
    if (!ids.contains(productId)) {
      ids.add(productId);
      await prefs.setStringList(key, ids);
      log('Added product $productId to wishlist for user $userId. New list: $ids');
    }
  }

  Future<void> removeFromWishList(int userId, String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'wishlist_user_$userId';
    final ids = prefs.getStringList(key) ?? [];
    ids.remove(productId);
    await prefs.setStringList(key, ids);
    log('Removed product $productId from wishlist for user $userId. New list: $ids');
  }
}
