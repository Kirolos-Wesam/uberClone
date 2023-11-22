import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_state.dart';
import 'package:uberapp/modules/loginpage/loginpage.dart';
import 'package:uberapp/modules/otppage/otppage.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  int index = 0;
  List<Widget> pages = [LoginPage(), OtpPage()];

  void changeScreen(int i){
    index = i;
    emit(ChangeScreensState());
  }
   
}