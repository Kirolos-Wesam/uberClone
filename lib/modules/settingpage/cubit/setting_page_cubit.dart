import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uberapp/layouts/homescreen/cubit/home_cubit.dart';
import 'package:uberapp/models/usermodel.dart';
import 'package:uberapp/shared/compontes/constants.dart';

part 'setting_page_state.dart';

class SettingPageCubit extends Cubit<SettingPageState> {
  SettingPageCubit() : super(SettingPageInitial());

  static SettingPageCubit get(context) => BlocProvider.of(context);

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

  void uploadProfileImageAndUpdateAccount({
    required String uId,
    required String name,
    required String email,
    required String homeAddress,
    required String businessAddress,
    UserModel? user,
  }) {
    if (profileImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          emit(UpdatingProfileImageSuccessState());
          updateUser(
              name: name,
              email: email,
              homeAddress: homeAddress,
              businessAddress: businessAddress,
              image: value);
        }).catchError((error) {
          emit(UpdatingProfileImageErrorState());
        });
      }).catchError((error) {
        emit(UpdatingProfileImageErrorState());
      });
    }
    if (profileImage == null) {
      updateUser(
          name: name,
          email: email,
          homeAddress: homeAddress,
          businessAddress: businessAddress,
          image: user!.profileImage!);
    }
  }

  updateUser(
      {required String name,
      required String email,
      required String homeAddress,
      required String businessAddress,
       String? image}) {
    emit(UpdateUserLoadingState());

    UserModel updateUser = UserModel(
        name: name,
        email: email,
        uId: uId,
        homeAddress: homeAddress,
        businessAddress: businessAddress,
        profileImage: image);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .update(updateUser.toMap())
        .then((value) {
      emit(UpdateUserSuccessState());
    }).onError((error, stackTrace) {
      emit(UpdateUserErrorState());
    });
  }
}
