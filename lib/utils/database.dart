import 'dart:async';

import 'file:///D:/Dev/Flutter/first_project_login_and_register/lib/models/user_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  // what is this ?
  DBProvider._();
  // what is this :( ?
  static final DBProvider db = DBProvider._();
  static Database _database;

  // what is this ?
  Future<Database> get database async {
    print('_database: ${_database}');
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'users_database.db'),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY,  username TEXT, password TEXT)");
    }, version: 1);
  }

  // Future<void> ?
  Future<void> newUser(User newUser) async {
// Get a reference to the database.
    final Database db = await database;
    print('database: ${db}');
    // Insert the User into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'users',
      newUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the users from the users table.
  Future<List<User>> users() async {
    //Functions marked 'async' must have a return type assignable to 'Future'
    //
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Users.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
      );
    });
  }

  Future<void> deleteUser(int id) async {
    // Get a reference to the database.
    final Database db = await database;

    // Remove the User from the database.
    await db.delete(
      'users',
      // Use a `where` clause to delete a specific user.
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    /* Always use whereArgs to pass arguments to a where statement. This helps safeguard against SQL injection attacks.
    Do not use string interpolation, such as where: "id = ${dog.id}"!
*/
  }

  Future<void> updateUser(User user) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given User.
    await db.update(
      'users',
      user.toMap(),
      // Ensure that the User has a matching id.
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }
}
