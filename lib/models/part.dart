// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PartChange {
  final String partName;
  final double cost;

  PartChange({required this.partName, required this.cost});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'partName': partName,
      'cost': cost,
    };
  }

  factory PartChange.fromMap(Map<String, dynamic> map) {
    return PartChange(
      partName: map['partName'] as String,
      cost: map['cost'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PartChange.fromJson(String source) =>
      PartChange.fromMap(json.decode(source) as Map<String, dynamic>);
}
