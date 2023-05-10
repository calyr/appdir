import 'package:appdir/domain/address.dart';

class AddressState {
   AddressState(this.isLoading, this.list, this.address, this.settlementList, this.error);
   final bool isLoading;
   final List<Address> list;
   final dynamic error;
   final Address address;
   final List<String> settlementList;

}

class AddressSuccess extends AddressState {
  AddressSuccess({required this.list, required this.address, required this.settlementList}): super(true, list, address ,[], "");

  final List<Address> list;
  final Address address;
  final List<String> settlementList;
  @override
  List<Object> get props => [
    list, address, settlementList
  ];

}

class AddressListSuccess extends AddressState {
  AddressListSuccess({required this.list}): super(true, list, Address() ,[], "");

  final List<Address> list;
  @override
  List<Object> get props => [
    list
  ];

}