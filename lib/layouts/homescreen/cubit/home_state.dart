part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class MapStyleState extends HomeState {}

final class GetCurrentLocationSuccessState extends HomeState {}

final class FromTextFieldShowState extends HomeState {}

final class SelectTextFieldShowState extends HomeState {}

final class GetProfileDataLoadingState extends HomeState {}

final class GetProfileDataSuccessState extends HomeState {}

final class GetProfileDataErrorState extends HomeState {}

final class ShowIndictorState extends HomeState {}

final class AddRideLoadingState extends HomeState {}

final class AddRideSuccessState extends HomeState {}

final class AddRideErrorState extends HomeState {}

final class CloseAllState extends HomeState {}




