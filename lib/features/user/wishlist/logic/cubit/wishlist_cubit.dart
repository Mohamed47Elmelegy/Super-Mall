import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/user/wishlist/logic/cubit/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  // Add your logic here
}