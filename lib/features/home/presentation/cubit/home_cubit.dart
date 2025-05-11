import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/home/data/repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepositoryBase _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  Future<void> getHomeData() async {
    try {
      emit(HomeLoading());
      final homeData = await _repository.getHomeData();
      emit(HomeLoaded(homeData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
