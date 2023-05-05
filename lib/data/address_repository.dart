
import 'package:appdir/db/database_controller.dart';
import 'package:appdir/domain/address.dart';

class AddressRepository {
  final DatabaseController databaseController = DatabaseController();

  Future getAll() => databaseController.getAllAddress();

  Future insertTodo(Address address) => databaseController.createAddress(address);

  Future updateTodo(Address address) => databaseController.updateAddress(address);

  Future deleteTodo(int index) => databaseController.deleteAddress(index);
}