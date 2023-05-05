
import 'dart:async';

import '../data/address_repository.dart';
import '../domain/address.dart';

class AddressBloc {

  final AddressRepository repository = AddressRepository();

  Stream<List<Address>> getListAddress() async* {
    List<Address> list = [];
    list = await repository.getAll();

    // for( Address address in ADDRESS) {
    //   await Future.delayed(Duration(seconds: 2));
    //   list.add(address);
    //   yield list;
    // }
  }

  StreamController<int> _addressCount = new StreamController<int>();
  Stream<int> get addressSizeStream => _addressCount.stream;


  dispose() {
    _addressCount.close();
  }

  // AddressBloc() {
  //   this.getListAddress.listen((list) => this._addressCount.add(list.length) );
  // }
}