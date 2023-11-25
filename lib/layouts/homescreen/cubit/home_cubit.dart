import 'dart:developer';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uberapp/models/rideModel.dart';
import 'package:uberapp/models/usermodel.dart';
import 'package:uberapp/shared/compontes/constants.dart';
import 'package:uberapp/shared/compontes/polyline.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  String? mapStyle;
  Set<Marker> markers = Set<Marker>();
  late LatLng source;
  //Set<Polyline> polyline = {};

  GoogleMapController? mapController;

  addMapStyle() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
      emit(MapStyleState());
    });
  }

   bool showIndictor = false;
  showIndicator(bool i){
    showIndictor == showIndictor;
    emit(ShowIndictorState());
  }

  LatLng? currentLocation;
  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLocation = LatLng(position.latitude, position.longitude);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
  
  
    mapController!
        .animateCamera(
      CameraUpdate.newLatLngZoom(currentLocation!, 15.0),
    )
        .then((value) {
      emit(GetCurrentLocationSuccessState());
    });

    showFromController.text = 'From: ${placemarks[0].street!}';
    
  }

  TextEditingController destinationController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController showFromController = TextEditingController();
  bool showField = false;
  fromShow(bool show) async {
    showField = show;
    List<Location> location =
        await locationFromAddress(destinationController.text);

    source = LatLng(location.first.latitude, location.first.longitude);

    if (markers.length >= 2) {
      markers.remove(markers.last);
    }

    markers.add(Marker(
        markerId: MarkerId(
          destinationController.text,
        ),
        infoWindow: InfoWindow(title: destinationController.text),
        position: source));

    markers.add(Marker(
        markerId: MarkerId(
          showFromController.text,
        ),
        infoWindow: InfoWindow(title: showFromController.text),
        position: currentLocation!,
        icon: BitmapDescriptor.fromBytes(startPoint)));

    //drawPolyLine(destinationController.text);

    log(currentLocation!.toString());
    log(source.toString());

    await getPolylines(currentLocation!, source);

    mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: source, zoom: 14)));

    emit(FromTextFieldShowState());
  }

  bool selectFromLocation = false;
  selectFrom(bool show) {
    selectFromLocation = show;
    emit(SelectTextFieldShowState());
  }



  late Uint8List startPoint;
  loadCustomMarker() async {
    startPoint = await loadAsset('assets/startPoint.png', 100);
  }

  Future<Uint8List> loadAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  
  UserModel? user;
  getProfileData(){
    emit(GetProfileDataLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      user = UserModel.fromJson(value.data()!);
      emit(GetProfileDataSuccessState());
    }).onError((error, stackTrace) {
      emit(GetProfileDataErrorState());
    });
  }
  
  createRide({required String  from, required String to, required DateTime date, required String type, required String price}){
    emit(AddRideLoadingState());
   
    RideModel addRide = RideModel(from: from, to: to,date: date, type: type, price: price);
    FirebaseFirestore.instance.collection('Users').doc(uId).collection('Rides').add(addRide.toMap()).then((value) {
      emit(AddRideSuccessState());
    }).onError((error, stackTrace) {
      emit(AddRideErrorState());
    });
  }
  closeAll(bool x){
   showField = x;
   emit(CloseAllState());
  }
}
