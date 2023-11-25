import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uberapp/models/usermodel.dart';

part 'signup_profile_state.dart';

class SignupProfileCubit extends Cubit<SignupProfileState> {
  SignupProfileCubit() : super(SignupProfileInitial());

  static SignupProfileCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  CountryCode countryCode = const CountryCode(name: 'Egypt', code: "EG", dialCode: "+20");
  void countryPicker(context)async{
    const countryPicker = FlCountryCodePicker();
    final code = await countryPicker.showPicker(context: context);
    if(code != null){
      countryCode = code;
      emit(CountryPickerState());
    }            
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }

  File? profileImage;
  var picker = ImagePicker();
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No Image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

   void uploadProfileImageAndCreateAccount(
      {required String name,
      required String email,
      required String phoneNumber,
      required String password,
      required String homeAddress,
      required String businessAddress,}) {
        if(profileImage != null){
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(ProfileImageSuccessState());
        print(value);
        FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((user){
          userCreate(uId: user.user!.uid, name: name, email: email, phoneNumber: phoneNumber, homeAddress: homeAddress, businessAddress: businessAddress, image: value);
        });
      }).catchError((error) {
        emit(ProfileImageErrorState());
      });
    }).catchError((error) {
      emit(ProfileImageErrorState());
    });
        }
        if(profileImage == null){
          FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((user){
          userCreate(uId: user.user!.uid, name: name, email: email, phoneNumber: phoneNumber, homeAddress: homeAddress, businessAddress: businessAddress, image: null);
        });
        }
  }

  userCreate(
      {required String uId,
      required String name,
      required String email,
      required String homeAddress,
      required String phoneNumber,
      required String businessAddress,
      String? image}) {
    emit(UserCreateLoadingState());
    UserModel addUser = UserModel(
        uId: uId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        homeAddress: homeAddress,
        businessAddress: businessAddress,
        profileImage: image  ?? 'https://firebasestorage.googleapis.com/v0/b/uberclone-63e86.appspot.com/o/users%2Fpersonlogo.png?alt=media&token=0dfa0f19-60d8-4fc8-9f49-5768fa86b8b4') ;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(addUser.toMap())
        .then((value) => emit(UserCreateSuccessState(uId)))
        .onError((error, stackTrace) =>
            emit(UserCreateErrorState(error.toString())));
  }
}
