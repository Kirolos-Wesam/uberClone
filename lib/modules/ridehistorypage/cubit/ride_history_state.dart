part of 'ride_history_cubit.dart';

@immutable
sealed class RideHistoryState {}

final class RideHistoryInitial extends RideHistoryState {}

final class GetRidesLoadingState extends RideHistoryState {}

final class GetRidesSuccessState extends RideHistoryState {}

final class GetRidesErrorState extends RideHistoryState {}
