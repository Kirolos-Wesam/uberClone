import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:uberapp/layouts/homescreen/cubit/home_cubit.dart';
import 'package:uberapp/layouts/loginscreen/loginscreen.dart';
import 'package:uberapp/models/typesRideModel.dart';
import 'package:uberapp/modules/ridehistorypage/cubit/ride_history_cubit.dart';
import 'package:uberapp/modules/ridehistorypage/ridehistorypage.dart';
import 'package:uberapp/shared/compontes/constants.dart';
import 'package:uberapp/shared/compontes/polyline.dart';
import 'package:uberapp/shared/network/local/cache_helper.dart';

import '../../modules/settingpage/settingpage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(26.8206, 30.8025), // Coordinates for Egypt's center
    zoom: 6.0, // Zoom level
  );

  List<TypesRideModel> rides = [
    TypesRideModel(type: 'Standard', price: '35 EGP', time: '10 Min'),
    TypesRideModel(type: 'Taxi', price: '30 EGP', time: '10 Min'),
    TypesRideModel(type: 'VIP', price: '50 EGP', time: '5 Min')
  ];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddRideSuccessState) {
          RideHistoryCubit.get(context).getRides();
          Fluttertoast.showToast(
              msg: "Thanks for Using Demo App, Have a nice day",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
          HomeCubit.get(context).closeAll(false);
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (cubit.user?.profileImage! != null)
                            CircleAvatar(
                              backgroundColor: Colors.grey[700],
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(cubit.user!.profileImage!),
                            ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textStyle(text: 'Good Morning'),
                              if (cubit.user?.name! != null)
                                textStyle(
                                    text: cubit.user!.name!,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.grey[400],
                        height: .5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, const RideHistoryPage());
                          },
                          child: const Text(
                            'Ride History',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          )),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, SettingPage());
                          },
                          child: const Text(
                            'Settings',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          )),
                      TextButton(
                          onPressed: () {
                            CacheHelper.removeData(key: 'uId').then((value) {
                              uId = '';
                              navigateAndFinish(context, LoginScreen());
                            });
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black),
                          )),
                    ],
                  ),
                )),
            body: Stack(
              children: [
                GoogleMap(
                  myLocationEnabled:
                      cubit.currentLocation != null ? true : false,
                  markers: cubit.markers,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  polylines: polyline,
                  onMapCreated: (GoogleMapController controller) {
                    cubit.mapController = controller;
                    cubit.mapController!.setMapStyle(cubit.mapStyle);
                  },
                  initialCameraPosition: kGooglePlex,
                ),
                Positioned(
                    top: 60,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          if (cubit.user?.profileImage! != null)
                            InkWell(
                              onTap: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[700],
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(cubit.user!.profileImage!),
                              ),
                            ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Good Morning, ',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                                if (cubit.user?.name! != null)
                                  TextSpan(
                                      text: cubit.user!.name!.split(" ")[0],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.bold)),
                              ])),
                              const Text(
                                'Where are you going ?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Positioned(
                  top: 190,
                  right: 20,
                  left: 20,
                  child: Container(
                      padding: const EdgeInsets.only(left: 10),
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
                        textEditingController: cubit.destinationController,
                        countries: ['EG'],
                        googleAPIKey: "AIzaSyCmxU2kB15GrRl30VBuH9H5X_2ra9jp0Kg",
                        textStyle: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                        inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for a destination",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            suffixIcon: const Icon(Icons.search)),
                        debounceTime: 600,
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (Prediction prediction) {
                          print("placeDetails" + prediction.lng.toString());
                        },
                        itemClick: (Prediction prediction) {
                          cubit.destinationController.text =
                              prediction.description!;
                          cubit.destinationController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: prediction.description!.length));
                          cubit.fromShow(
                              cubit.destinationController.text.isNotEmpty);
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
                        isCrossBtnShown: false,
                      )),
                ),
                if (cubit.showField) fromTextFieldShow(context),
                if (cubit.selectFromLocation)
                  getFromTextFieldMap(context, cubit),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 30),
                    child: InkWell(
                      onTap: () {
                        cubit.getCurrentLocation();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        radius: 25,
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                if (cubit.showField)
                  Positioned(
                    bottom: 20,
                    left: 60,
                    child: SizedBox(
                        width: Checkbox.width * 15,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            showRideBottomSheet(context, state);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[900],
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Developed by Ecom-Eg'),
                )
              ],
            ));
      },
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 350.0,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 4,
                      blurRadius: 10)
                ],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Select your location',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Home Address',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          HomeCubit.get(context).showFromController.text =
                              HomeCubit.get(context)
                                  .user!
                                  .homeAddress!
                                  .toString();
                        },
                        child: Text(HomeCubit.get(context)
                                .user
                                ?.homeAddress!
                                .toString() ??
                            ''),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Business Address'),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          HomeCubit.get(context).showFromController.text =
                              HomeCubit.get(context)
                                  .user!
                                  .businessAddress!
                                  .toString();
                        },
                        child: Text(HomeCubit.get(context)
                                .user
                                ?.businessAddress!
                                .toString() ??
                            ''),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      HomeCubit.get(context).selectFrom(true);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[200]),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('Sreach For Address')),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void showRideBottomSheet(context, state) {
    int select = 0;
    showModalBottomSheet(
        context: context,
        builder: (Context) {
          return Container(
            width: double.infinity,
            height: 270,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.grey[200]),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select your option: ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 90,
                    width: double.infinity,
                    child: StatefulBuilder(
                      builder: (context, set) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                set(() {
                                  select = index;
                                });
                              },
                              child: buildDriverCard(select == index, index),
                            );
                          },
                          itemCount: rides.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text('Payment Method: '),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Cash',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          HomeCubit.get(context).createRide(
                              from: HomeCubit.get(context)
                                          .fromController
                                          .text ==
                                      ''
                                  ? HomeCubit.get(context)
                                      .showFromController
                                      .text
                                  : HomeCubit.get(context).fromController.text,
                              to: HomeCubit.get(context)
                                  .destinationController
                                  .text,
                              date: DateTime.now(),
                              type: rides[select].type,
                              price: rides[select].price);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900]),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (state is AddRideLoadingState)
                    LinearProgressIndicator(
                      color: Colors.grey[900],
                    )
                ],
              ),
            ),
          );
        });
  }

  Widget fromTextFieldShow(context) {
    return Positioned(
      top: 130,
      right: 20,
      left: 30,
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
        ),
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
        child: TextFormField(
          controller: HomeCubit.get(context).showFromController,
          readOnly: true,
          onTap: () {
            showBottomSheet(context);
          },
          keyboardType: TextInputType.streetAddress,
          style: GoogleFonts.poppins(fontSize: 16),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "From: ",
              hintStyle: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
              suffixIcon: const Icon(Icons.location_on)),
        ),
      ),
    );
  }

  Widget getFromTextFieldMap(context, cubit) {
    return Positioned(
      top: 130,
      right: 20,
      left: 20,
      child: Container(
          padding: const EdgeInsets.only(left: 10),
          width: double.infinity,
          height: 55,
          child: Focus(
            focusNode: FocusNode(),
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
              textEditingController: cubit.fromController,
              googleAPIKey: "AIzaSyCmxU2kB15GrRl30VBuH9H5X_2ra9jp0Kg",
              textStyle: GoogleFonts.poppins(
                fontSize: 16,
              ),
              inputDecoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for Address",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  suffixIcon: const Icon(Icons.search)),
              debounceTime: 600,
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
                print("placeDetails" + prediction.lng.toString());
              },
              itemClick: (Prediction prediction) {
                cubit.fromController.text = prediction.description!;
                cubit.fromController.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length));
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
                      Expanded(child: Text(prediction.description ?? ""))
                    ],
                  ),
                );
              },
              seperatedBuilder: const Divider(),
              isCrossBtnShown: true,
            ),
          )),
    );
  }

  buildDriverCard(bool selected, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
      height: 85,
      width: 165,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: selected
                    ? Colors.black.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 5),
                blurRadius: 5,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(12),
          color: selected ? Colors.black : Colors.grey),
      child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rides[index].type,
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                Text(
                  rides[index].price,
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                Text(
                  rides[index].time,
                  style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Positioned(
              right: -20,
              top: 0,
              bottom: 0,
              child: Image.asset('assets/carRide.png'))
        ],
      ),
    );
  }
}
