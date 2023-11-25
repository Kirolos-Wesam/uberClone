import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uberapp/layouts/homescreen/cubit/home_cubit.dart';
import 'package:uberapp/modules/settingpage/cubit/setting_page_cubit.dart';
import 'package:uberapp/shared/compontes/constants.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var homeAddressController = TextEditingController();
  var businessAddressController = TextEditingController();
  var phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = HomeCubit.get(context).user!.name!;
    emailController.text = HomeCubit.get(context).user!.email!;
    homeAddressController.text = HomeCubit.get(context).user!.homeAddress!;
    phoneNumberController.text = HomeCubit.get(context).user!.phoneNumber!;
    businessAddressController.text =
        HomeCubit.get(context).user!.businessAddress!;
    return BlocConsumer<SettingPageCubit, SettingPageState>(
      listener: (context, state) {
        if (state is UpdateUserSuccessState) {
          HomeCubit.get(context).getProfileData();
          Fluttertoast.showToast(
              msg: "TUpdated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        var cubit = SettingPageCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                              color: Colors.grey[900]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 80),
                                child: Text(
                                  'Profile Setting',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
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
                                  ? NetworkImage(HomeCubit.get(context)
                                      .user!
                                      .profileImage!) as ImageProvider
                                  : FileImage(cubit.profileImage!),
                              radius: 50,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            controller: nameController,
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
                            controller: emailController,
                            keyboardType: TextInputType.name,
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.name,
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
                      SizedBox(
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
                            textEditingController: homeAddressController,
                            googleAPIKey:
                                "AIzaSyCmxU2kB15GrRl30VBuH9H5X_2ra9jp0Kg",
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
                            countries: const ['EG'],
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: (Prediction prediction) {
                              print("placeDetails" + prediction.lng.toString());
                            },
                            itemClick: (Prediction prediction) {
                              homeAddressController.text =
                                  prediction.description!;
                              homeAddressController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: prediction.description!.length));
                            },
                            itemBuilder:
                                (context, index, Prediction prediction) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child:
                                            Text(prediction.description ?? ""))
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
                      SizedBox(
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
                            textEditingController: businessAddressController,
                            googleAPIKey:
                                "AIzaSyCmxU2kB15GrRl30VBuH9H5X_2ra9jp0Kg",
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
                            countries: const ['EG'],
                            getPlaceDetailWithLatLng: (Prediction prediction) {
                              print("placeDetails" + prediction.lng.toString());
                            },
                            itemClick: (Prediction prediction) {
                              businessAddressController.text =
                                  prediction.description!;
                              businessAddressController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: prediction.description!.length));
                            },
                            itemBuilder:
                                (context, index, Prediction prediction) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child:
                                            Text(prediction.description ?? ""))
                                  ],
                                ),
                              );
                            },
                            seperatedBuilder: const Divider(),
                            isCrossBtnShown: true,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              cubit.uploadProfileImageAndUpdateAccount(
                                  uId: uId,
                                  name: nameController.text,
                                  email: emailController.text,
                                  homeAddress: homeAddressController.text,
                                  businessAddress:
                                      businessAddressController.text,
                                  user: HomeCubit.get(context).user);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[900]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state is UpdateUserLoadingState)
                                  const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                else
                                  const Text(
                                    'Update',
                                    style: TextStyle(color: Colors.white),
                                  ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
