
import 'dart:ffi';

class Address {
  final int? id;
  final String? name;
  final String? street;
  String? numberOf;
  String? postalCode;
  String? nameState;
  String? municipality;
  String? settlement;
  String? additional;
  bool? checkedBy;

  Address({this.id, this.name, this.street}) {
    this.numberOf = "";
    this.postalCode = "";
    this.nameState = "";
    this.municipality = "";
    this.settlement = "";
    this.additional = "";
    this.checkedBy = false;
  }

  factory Address.fromJSON(Map<String, dynamic> json) {
    return Address(
        id: json['id'],
        name: json['name'],
        street: json['street']);
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'street': street,
      'number_of': numberOf,
      'checked_by': checkedBy == true? 1: 0
    };
  }
}