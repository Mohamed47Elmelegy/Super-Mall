import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/auth/forget_password/data/repository/forget_password_repository.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepositoryBase _repository;

  ForgetPasswordCubit(this._repository) : super(ForgetPasswordInitial());

  Future<void> resetPassword(String email) async {
    try {
      emit(ForgetPasswordLoading());
      final result = await _repository.resetPassword(email);
      result.fold(
        (failure) => emit(ForgetPasswordError(failure.message)),
        (_) => emit(ForgetPasswordLoaded()),
      );
    } catch (e) {
      emit(ForgetPasswordError(e.toString()));
    }
  }
}
