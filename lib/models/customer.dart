// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanics/models/part.dart';

class Customer {
  final String name;
  final String carModel;
  final Timestamp lastVisitedDate;
  final List<PartChange> partChanges;
  final String plateNumber;

  Customer({
    required this.name,
    required this.carModel,
    required this.lastVisitedDate,
    required this.partChanges,
    required this.plateNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'carModel': carModel,
      'lastVisitedDate': lastVisitedDate,
      'partChanges': partChanges.map((x) => x.toMap()).toList(),
      'plateNumber': plateNumber,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      name: map['name'] as String,
      carModel: map['carModel'] as String,
      lastVisitedDate: map['lastVisitedDate'] as Timestamp,
      partChanges: List<PartChange>.from(
        (map['partChanges']).map<PartChange>(
          (x) => PartChange.fromMap(x as Map<String, dynamic>),
        ),
      ),
      plateNumber: map['plateNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}
