import 'package:super_mall/features/home/data/model/home_data_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeDataModel homeData;

  HomeLoaded(this.homeData);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
