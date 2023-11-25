import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uberapp/models/rideModel.dart';
import 'package:uberapp/shared/compontes/constants.dart';

part 'ride_history_state.dart';

class RideHistoryCubit extends Cubit<RideHistoryState> {
  RideHistoryCubit() : super(RideHistoryInitial());

  static RideHistoryCubit get(context) => BlocProvider.of(context);

  List<RideModel>? rides;
  getRides() {
    emit(GetRidesLoadingState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Rides')
        .get()
        .then((value) {
      rides = RideModelFromJson(value.docs);
      emit(GetRidesSuccessState());
    }).onError((error, stackTrace) {
      Completer().completeError(error!,stackTrace);
      emit(GetRidesErrorState());
    });
  }
}
