import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:uberapp/shared/compontes/constants.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(LoginFormInitial());

  static LoginFormCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }

  userSignIn({required String email, required String password}){
    emit(UserSignInLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(UserSignInSuccessState(value.user!.uid));
    }).onError((error, stackTrace) {emit(UserSignInErrorState(error.toString()));});
  }

  signinWithGoogle() async{
    // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
    checkUser(value.user!.uid);
  });
  }

  verifyOtp(String otpNumber, var verId) async {
    emit(OtpLoadingState());

    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: otpNumber);

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      
      emit(OtpSuccessState());
      checkUser(value.user!.uid);
      print('ok');
    }).catchError((e) {
      emit(OtpErrorState());
      print("Error while sign In $e");
    });
    
  }

  checkUser(String id){
    FirebaseFirestore.instance.collection('Users').doc(id).get().then((value) {
      if(value.exists){
        emit(UserSignInSuccessState(uId));
      }else{
        emit(UserRegisterState());
        uId = id;
      }
    });
  }
}
