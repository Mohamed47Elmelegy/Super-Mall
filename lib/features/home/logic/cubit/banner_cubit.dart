import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/banner.dart';
import '../../data/repository/banner_repository.dart';

// States
abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final List<Banner> banners;
  BannerLoaded(this.banners);
}

class BannerError extends BannerState {
  final String message;
  BannerError(this.message);
}

// Cubit
class BannerCubit extends Cubit<BannerState> {
  final BannerRepository _repository;

  BannerCubit(this._repository) : super(BannerInitial());

  Future<void> getBanners() async {
    try {
      emit(BannerLoading());
      final banners = await _repository.getBanners();
      emit(BannerLoaded(banners));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }
}
