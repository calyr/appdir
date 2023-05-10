
class Address {
  String? id;
  String? name;
  String? street;
  String? numberOf;
  String? postalCode;
  String? nameState;
  String? municipality;
  String? settlement;
  String? additional;
  bool? checkedBy;

  Address(
      {this.id, this.name, this.street, this.numberOf, this.postalCode, this.nameState, this.municipality, this.settlement, this.additional, this.checkedBy}) {}

  factory Address.fromJSON(Map<String, dynamic> json) {
    return Address(
        id: json['id'],
        name: json['name'],
        street: json['street'],
        postalCode: json['postal_code'],
        nameState: json['name_state'],
        municipality: json['municipality'],
        settlement: json['settlement'],
        additional: json['additional'],
        checkedBy: json['checked_by'] == 1? true: false,
        numberOf: json['number_of']);
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'street': street,
      'number_of': numberOf,
      'postal_code': postalCode,
      'name_state': nameState,
      'municipality': municipality,
      'settlement': settlement,
      'additional': additional,
      'checked_by': checkedBy == true ? 1 : 0
    };
  }
}