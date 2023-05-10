
import 'package:appdir/domain/address.dart';

import 'database_provider.dart';

class DatabaseController {
  final dbClient = DatabaseProvider.dbProvider;

  Future<int> createAddress(Address address) async {
    final db = await dbClient.db;
    var result = db.insert("address", address.toJSON()); // here todoTable is the name of
    return result;
  }

  Future<List<Address>> getAllAddress({List<String>? columns}) async {
    final db = await dbClient.db;
    var result = await db.query("address",columns: columns);
    List<Address> todos = result.isNotEmpty ? result.map((item) => Address.fromJSON(item)).toList() : [];
    return todos;
  }

  Future<int> updateAddress(Address address) async {
    final db = await dbClient.db;
    var result = await db.update("address", address.toJSON(),where: "id = ?", whereArgs: [address.id]);
    return result;
  }

  Future<int> deleteAddress(String id) async {
    final db = await dbClient.db;
    var result = await db.delete("address", where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<Address?> findAddress(String id) async {
    final db = await dbClient.db;
    var result = await db.query("address",where: "id = ?", whereArgs: [id]);
    List<Address> todos = result.isNotEmpty ? result.map((item) => Address.fromJSON(item)).toList() : [];
    return todos[0];
  }

  Future<int> updateAddressCheckedToFalse() async {
    final db = await dbClient.db;
    var result = await db.update("address", {'checked_by': 0},where: "checked_by = ?", whereArgs: [1]);
    return result;
  }
}