import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uberapp/modules/loginpage/cubit/login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageInitial());

  static LoginPageCubit get(context) => BlocProvider.of(context);


  TextEditingController phoneNumberController = TextEditingController();
  CountryCode countryCode = const CountryCode(name: 'Egypt', code: "EG", dialCode: "+20");
  void countryPicker(context)async{
    const countryPicker = FlCountryCodePicker();
    final code = await countryPicker.showPicker(context: context);
    if(code != null){
      countryCode = code;
      emit(CountryPickerState());
    }            
  }


  String userUid = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;
  phoneAuth(String phone) async {
    emit(VerificationSendLoadingState());
    try {
      credentials = null;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          emit(VerificationSendSuccessState());
          credentials = credential;
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        forceResendingToken: resendTokenId,
        verificationFailed: (FirebaseAuthException e) {
          emit(VerificationSendErrorState());
          if (e.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          log('Code sent');
          verId = verificationId;
          resendTokenId = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      log("Error occured $e");
      emit(VerificationSendErrorState());
    }
  }
}