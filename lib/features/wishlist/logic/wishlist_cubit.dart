import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/wishlist_repository.dart';
import 'wishlist_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final WishListRepository repo;
  final int userId;

  WishListCubit(this.repo, this.userId) : super(const WishListInitial());

  Future<void> loadWishList() async {
    emit(const WishListLoading());
    try {
      final ids = await repo.getWishListIds(userId);
      emit(WishListLoaded(ids.toSet()));
    } catch (e) {
      emit(WishListError(e.toString()));
    }
  }

  Future<void> toggleWish(String productId) async {
    log('toggleWish called for productId: $productId');

    if (state is! WishListLoaded) return;
    final currentState = state as WishListLoaded;
    final isFav = currentState.wishListIds.contains(productId);

    try {
      if (isFav) {
        log('Removing from wishlist');
        await repo.removeFromWishList(userId, productId);
        emit(WishListLoaded({...currentState.wishListIds}..remove(productId)));
      } else {
        log('Adding to wishlist');
        await repo.addToWishList(userId, productId);
        emit(WishListLoaded({...currentState.wishListIds}..add(productId)));
      }
    } catch (e) {
      emit(WishListError(e.toString()));
    }
  }
}
