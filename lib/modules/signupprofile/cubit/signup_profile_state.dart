part of 'signup_profile_cubit.dart';

@immutable
sealed class SignupProfileState {}

final class SignupProfileInitial extends SignupProfileState {}

final class CountryPickerState extends SignupProfileState {}

final class ChangePasswordVisibilityState extends SignupProfileState {}

final class ProfileImagePickedSuccessState extends SignupProfileState {}

final class ProfileImagePickedErrorState extends SignupProfileState {}

final class ProfileImageSuccessState extends SignupProfileState {}

final class ProfileImageErrorState extends SignupProfileState {}

final class UserCreateLoadingState extends SignupProfileState {}

final class UserCreateSuccessState extends SignupProfileState {
  final String uId;

  UserCreateSuccessState(this.uId);

}

final class UserCreateErrorState extends SignupProfileState {
  final String error;

  UserCreateErrorState(this.error);
}