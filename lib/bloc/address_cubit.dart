import 'dart:convert';

import 'package:appdir/bloc/address_state.dart';
import 'package:appdir/domain/address.dart';
import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../db/database_controller.dart';
import '../domain/epomex.dart';
var uuid = Uuid();

class AddressCubit extends Cubit<AddressState> {
  List<Address> list = [];
  Address address = Address();
  AddressCubit(): super(AddressState(false, [], Address() , [], "")){
    loading();
  }

  DatabaseController db = DatabaseController();

  void loading() async {
    final data =  await db.getAllAddress();

    emit(AddressSuccess(list: data, address: this.address, settlementList: [] ));
  }
  List<String> settlementList = [];
  void addAddress() async {
    this.address.id = uuid.v4();
    await db.createAddress(this.address);
    loading();
  }

  void getDataSource(postalCode) async {
    Epomex epomexData = await getEpomex(postalCode);
    this.address.nameState = epomexData.nameState;
    this.address.municipality = epomexData.municipality;
    this.address.settlement = epomexData.settlement[0];
    this.address.postalCode = postalCode;
    this.settlementList = epomexData.settlement;
    emit(AddressSuccess(list: this.list, address: this.address, settlementList: epomexData.settlement));
  }

  Future<Epomex> getEpomex(postalCode) async {
    Epomex epomex;
    final dataResponse = await http.get(
      Uri.parse("https://nowmobile.mx/sepomex-get/${postalCode}"),
      headers: {
        'Content-type': 'application/json; charset=utf-8'
      }
    );
    final stateList = jsonDecode(dataResponse.body);
    List<String> settlementListTemp = [];
    for( Map<String, dynamic> a in stateList) {
      settlementListTemp.add(a["asentamiento"]);
    }
    epomex = Epomex(nameState: stateList[0]["estado"], municipality: stateList[0]["municipio"], settlement: settlementListTemp);

    return epomex;
  }

  void changeSettlementList(value) {
    this.address.settlement = value;
    emit(AddressSuccess(list: this.list, address: this.address, settlementList: this.settlementList));
  }

  void changeName(value) {
    this.address.name = value;
    emit(AddressSuccess(list: this.list, address: this.address, settlementList: this.settlementList));
  }

  void changeStreet(value) {
    this.address.street = value;
    emit(AddressSuccess(list: this.list, address: this.address, settlementList: this.settlementList));
  }

  void changePostalCode(value) {
    address.postalCode = value;
    emit(AddressSuccess(list: list, address: address, settlementList: settlementList));
  }

  void changeNumber(value) {
    address.numberOf = value;
    emit(AddressSuccess(list: list, address: address, settlementList: settlementList));
  }

  void findAddress(String id) async {
    Address? addressDb = await db.findAddress(id);
    this.address = addressDb!;
    Epomex epomexData = await getEpomex(this.address.postalCode);
    this.settlementList = epomexData.settlement;
    emit(AddressSuccess(list: [], address: this.address, settlementList: epomexData.settlement));
  }

  void updateAddress() async {
    await db.updateAddress(this.address);
    final data =  await db.getAllAddress();
    emit(AddressSuccess(list: data, address: this.address, settlementList: [] ));
  }

  void deleteAddres() async {
    await db.deleteAddress(this.address.id.toString());
    final data =  await db.getAllAddress();
    emit(AddressSuccess(list: data, address: this.address, settlementList: [] ));
  }
}