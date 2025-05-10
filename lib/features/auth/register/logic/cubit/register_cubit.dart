import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/auth/register/data/model/register.dart';
import 'package:super_mall/features/auth/register/data/repository/register_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepositoryBase _repository;

  RegisterCubit(this._repository) : super(RegisterInitial());

  Future<void> register(RegistrationModel registerData) async {
    try {
      emit(RegisterLoading());
      final result = await _repository.register(registerData);
      result.fold(
        (failure) => emit(RegisterError(failure.message)),
        (register) => emit(RegisterLoaded(register)),
      );
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  Future<void> registerWithGoogle() async {
    try {
      emit(RegisterLoading());
      final result = await _repository.registerWithGoogle();
      result.fold(
        (failure) => emit(RegisterError(failure.message)),
        (_) => emit(RegisterInitial()),
      );
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  Future<void> registerWithFacebook() async {
    try {
      emit(RegisterLoading());
      final result = await _repository.registerWithFacebook();
      result.fold(
        (failure) => emit(RegisterError(failure.message)),
        (_) => emit(RegisterInitial()),
      );
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
