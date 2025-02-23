import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/user/payment_info/logic/cubit/payment_info_state.dart';

class PaymentInfoCubit extends Cubit<PaymentInfoState> {
  PaymentInfoCubit() : super(PaymentInfoInitial());

  // Add your logic here
}