import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/checkout/logic/cubit/checkout_state.dart';
import '../../../cart/data/model/cart_item.dart';
import '../../../user/address_info/data/models/address_model.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  AddressModel? selectedAddress;
  List<CartItem> cartItems = [];
  double total = 0.0;

  void setAddress(AddressModel address) {
    selectedAddress = address;
    emit(CheckoutAddressSelected(address));
  }

  void setCartItems(List<CartItem> items, double totalPrice) {
    cartItems = items;
    total = totalPrice;
    emit(CheckoutCartUpdated(items, totalPrice));
  }

  void confirmCheckout() {
    if (selectedAddress == null) {
      emit(CheckoutError('يرجى تحديد عنوان الشحن'));
    } else {
      emit(CheckoutConfirmed(selectedAddress!, cartItems, total));
    }
  }
}
