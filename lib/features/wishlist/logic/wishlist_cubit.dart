import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/wishlist_repository.dart';
import 'wishlist_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final WishListRepository repo;
  final int userId;

  WishListCubit(this.repo, this.userId) : super(WishListState(wishListIds: {}));

  Future<void> loadWishList() async {
    emit(WishListState(wishListIds: state.wishListIds, loading: true));
    final ids = await repo.getWishListIds(userId);
    emit(WishListState(wishListIds: ids.toSet()));
  }

  Future<void> toggleWish(String productId) async {
    log('toggleWish called for productId: $productId');
    final isFav = state.wishListIds.contains(productId);
    if (isFav) {
      log('Removing from wishlist');
      await repo.removeFromWishList(userId, productId);
      emit(WishListState(
          wishListIds: {...state.wishListIds}..remove(productId)));
    } else {
      log('Adding to wishlist');
      await repo.addToWishList(userId, productId);
      emit(WishListState(wishListIds: {...state.wishListIds}..add(productId)));
    }
  }
}
