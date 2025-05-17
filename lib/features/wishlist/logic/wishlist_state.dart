sealed class WishListState {
  const WishListState();
}

class WishListInitial extends WishListState {
  const WishListInitial();
}

class WishListLoading extends WishListState {
  const WishListLoading();
}

class WishListLoaded extends WishListState {
  final Set<String> wishListIds;

  const WishListLoaded(this.wishListIds);
}

class WishListError extends WishListState {
  final String message;

  const WishListError(this.message);
}
