import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/home/data/repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepositoryBase _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final homeData = await _homeRepository.getHomeData();
      emit(HomeLoaded(homeData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
