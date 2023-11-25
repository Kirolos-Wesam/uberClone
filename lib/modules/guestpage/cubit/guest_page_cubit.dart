import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uberapp/modules/guestpage/cubit/guest_page_state.dart';

class GuestPageCubit extends Cubit<GuestPageState> {
  GuestPageCubit() : super(GuestPageInitial());

  static GuestPageCubit get(context) => BlocProvider.of(context);


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

   signInWithGoogle() async {
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
    print(value.user!.uid);
  });
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
          emit(VerificationSendSuccessState());
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