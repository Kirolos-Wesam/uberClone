import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_state.dart';
import 'package:uberapp/modules/guestpage/guestpage.dart';
import 'package:uberapp/modules/login/loginform.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  int index = 0;
  List<Widget> pages = [GuestPage(), LoginForm()];

  void changeScreen(int i){
    index = i;
    emit(ChangeScreensState());
  }
   
}