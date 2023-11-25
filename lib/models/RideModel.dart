import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<RideModel> RideModelFromJson(List<QueryDocumentSnapshot> list) =>
    List<RideModel>.from(list.map((x) => RideModel.fromJson(x.data() as Map<String, dynamic> )));

class RideModel {
  String? from;
  String? to;
  DateTime? date;
  String? type;
  String? price;
  
 

  RideModel({
    this.from,
    this.to,
    this.date,
    this.type,
    this.price,
});
  RideModel.fromJson(Map<String, dynamic> json){
    from = json['from'];
    to = json['to'];
    date = (json['date'] as Timestamp).toDate();
    type = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'from':from,
      'to':to,
      'date':date,
      'type':type,
      'price': price,
    };
  }
}