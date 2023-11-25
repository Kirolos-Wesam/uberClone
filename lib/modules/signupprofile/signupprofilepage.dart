import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uberapp/layouts/homescreen/homescreen.dart';
import 'package:uberapp/modules/login/cubit/login_form_cubit.dart';
import 'package:uberapp/modules/signupprofile/cubit/signup_profile_cubit.dart';
import 'package:uberapp/shared/compontes/constants.dart';
import 'package:uberapp/shared/network/local/cache_helper.dart';

class SignupProfilePage extends StatelessWidget {
  const SignupProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupProfileCubit, SignupProfileState>(
      listener: (context, state) {
        if(state is UserCreateSuccessState){
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            uId = state.uId;
            navigateAndFinish(context, HomeScreen());
          });
        }
      },
      builder: (context, state) {
        var cubit = SignupProfileCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 375,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        width: double.infinity,
                        height: 350,
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50)),
                            color: Colors.grey[900]),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/caricon.svg',
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Developed by Ecom-Eg',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.getProfileImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[700],
                            backgroundImage: cubit.profileImage == null
                                ? const NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/uberclone-63e86.appspot.com/o/users%2Fpersonlogo.png?alt=media&token=0dfa0f19-60d8-4fc8-9f49-5768fa86b8b4')
                                    as ImageProvider
                                : FileImage(cubit.profileImage!),
                            radius: 50,
                          ),
                        ),
                        if (cubit.profileImage == null)
                          Positioned(
                            bottom: 3,
                            child: InkWell(
                              onTap: () {
                                cubit.getProfileImage();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: Icon(Icons.add),
                              ),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
              // SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textStyle(text: 'Welcome To Our App'),
                    textStyle(text: "Let's set Your Profile", fontSize: 21),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                spreadRadius: 3,
                                blurRadius: 3)
                          ]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: cubit.nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              prefixIcon: const Icon(Icons.person),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                spreadRadius: 3,
                                blurRadius: 3)
                          ]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: cubit.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              prefixIcon: const Icon(Icons.email),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            spreadRadius: 3,
                            blurRadius: 3)
                      ]),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => cubit.countryPicker(context),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  child: cubit.countryCode.flagImage(),
                                ),
                              ),
                              textStyle(text: cubit.countryCode.dialCode),
                              Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 55,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: cubit.phoneNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: 'ُMobile Number',
                                border: InputBorder.none),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: double.infinity,
                        height: 55,
                        child: GooglePlaceAutoCompleteTextField(
                          boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.05),
                                    spreadRadius: 3,
                                    blurRadius: 3)
                              ]),
                          textEditingController: cubit.homeAddressController,
                          googleAPIKey: "AIzaSyCmxU2kB15GrRl30VBuH9H5X_2ra9jp0Kg",
                          textStyle: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                          inputDecoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Home Address",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              prefixIcon: const Icon(Icons.home)),
                          debounceTime: 600,
                          countries: ['EG'],
                          isLatLngRequired: true,
                          getPlaceDetailWithLatLng: (Prediction prediction) {
                            print("placeDetails" + prediction.lng.toString());
                          },
                          itemClick: (Prediction prediction) {
                            cubit.homeAddressController.text =
                                prediction.description!;
                            cubit.homeAddressController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: prediction.description!.length));
                          },
                          itemBuilder: (context, index, Prediction prediction) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(prediction.description ?? ""))
                                ],
                              ),
                            );
                          },
                          seperatedBuilder: const Divider(),
                          isCrossBtnShown: true,
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: double.infinity,
                        height: 55,
                        child: GooglePlaceAutoCompleteTextField(
                          boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.05),
                                    spreadRadius: 3,
                                    blurRadius: 3)
                              ]),
                          textEditingController: cubit.businessAddressController,
                          googleAPIKey: "AIzaSyCmxU2kB15GrRl30VBuH9H5X_2ra9jp0Kg",
                          textStyle: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                          inputDecoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Business Address",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              prefixIcon: const Icon(Icons.business)),
                          debounceTime: 600,
                          isLatLngRequired: true,
                          countries: ['EG'],
                          getPlaceDetailWithLatLng: (Prediction prediction) {
                            print("placeDetails" + prediction.lng.toString());
                          },
                          itemClick: (Prediction prediction) {
                            cubit.businessAddressController.text =
                                prediction.description!;
                            cubit.businessAddressController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: prediction.description!.length));
                          },
                          itemBuilder: (context, index, Prediction prediction) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(prediction.description ?? ""))
                                ],
                              ),
                            );
                          },
                          seperatedBuilder: const Divider(),
                          isCrossBtnShown: true,
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                spreadRadius: 3,
                                blurRadius: 3)
                          ]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          obscureText: cubit.isPassword,
                          controller: cubit.passwordController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              prefixIcon: const Icon(Icons.person),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(cubit.suffix)),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.05),
                                spreadRadius: 3,
                                blurRadius: 3)
                          ]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          obscureText: cubit.isPassword,
                          controller: cubit.rePasswordController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Password Check',
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              prefixIcon: const Icon(Icons.person),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(cubit.suffix)),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.uploadProfileImageAndCreateAccount(name: cubit.nameController.text
                            , email: cubit.emailController.text,
                            password: cubit.passwordController.text,
                             phoneNumber: '${cubit.countryCode.dialCode}${cubit.phoneNumberController.text}', homeAddress: cubit.homeAddressController.text, businessAddress: cubit.businessAddressController.text);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state is UserCreateLoadingState)
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              else
                                const Text(
                                  'Sign in',
                                  style: const TextStyle(color: Colors.white),
                                ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[900]),
                        ))
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
