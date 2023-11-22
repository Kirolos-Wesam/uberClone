import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  static OtpCubit get(context) => BlocProvider.of(context);

  TextEditingController codeController = TextEditingController();

  verifyOtp(String otpNumber, var verId) async {
    //emit(OtpLoadingState());
    
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: otpNumber);

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      print('ok');
    }).catchError((e) {
      print("Error while sign In $e");
    });
  }
}
