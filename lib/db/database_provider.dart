import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? database;

  Future<Database> get db async {
    if (database != null) {
      return database!;
    } else {
      database = await createDatabase();
      return database!;
    }
  }

  Future<Database> createDatabase() async {
    // the code below is used to get the location of the application document directory
    Directory docDirectory = await getApplicationDocumentsDirectory();
    // the code below is useed to get the path where our sqlite database will be located
    // by using the join method
    String path =
    join(docDirectory.path, "address.db");

    // in the line of code below we need to use the openDatabase() method to
    // open the database and create the table using raw sql command
    var database = await openDatabase(
      path, // the path where our database is located
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE address ("
            "id TEXT PRIMARY KEY, "
            "name TEXT, "
            "street TEXT, "
            "number_of TEXT, "
            "postal_code TEXT, "
            "name_state TEXT, "
            "municipality TEXT, "
            "settlement TEXT, "
            "additional TEXT, "
            "checked_by INTEGER "
            ")");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {
        if (newVersion > oldVersion) {}
      },
    );

    return database;
  }
}