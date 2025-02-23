import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/order/logic/cubit/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  // Add your logic here
}