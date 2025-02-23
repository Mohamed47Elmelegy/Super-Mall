import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/user/user_info/logic/cubit/user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());

  // Add your logic here
}