part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class CountryPickerState extends ProfileState {}

class UserCreateLoadingState extends ProfileState {}

class UserCreateSuccessState extends ProfileState {
  final String uId;

  UserCreateSuccessState(this.uId);
}

class UserCreateErrorState extends ProfileState {
  final String error;

  UserCreateErrorState(this.error);
}

class ProfileImagePickedSuccessState extends ProfileState{}

class ProfileImagePickedErrorState extends ProfileState{}

class ProfileImageSuccessState extends ProfileState {}

class ProfileImageErrorState extends ProfileState {}
