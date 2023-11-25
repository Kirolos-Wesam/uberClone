part of 'login_form_cubit.dart';

@immutable
sealed class LoginFormState {}

final class LoginFormInitial extends LoginFormState {}

class OtpLoadingState extends LoginFormState {}
 
 class OtpSuccessState extends LoginFormState {}

 class ChangePasswordVisibilityState extends LoginFormState {}
 
 class OtpErrorState extends LoginFormState {}

 class UserSignInLoadingState extends LoginFormState {}
 
 class UserSignInSuccessState extends LoginFormState {
  final String uId;

  UserSignInSuccessState(this.uId);
 }

 class UserSignInErrorState extends LoginFormState {
  final String error;

  UserSignInErrorState(this.error);
 }

class UserAlreadyRegisteredState extends LoginFormState {}

class UserRegisterState extends LoginFormState {}
