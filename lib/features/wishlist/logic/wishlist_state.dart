class WishListState {
  final Set<String> wishListIds;
  final bool loading;

  WishListState({
    required this.wishListIds,
    this.loading = false,
  });
}
