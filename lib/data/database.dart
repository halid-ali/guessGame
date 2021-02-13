import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:guessGame/data/models/user_model.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider dbProvider = DatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'app.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onOpen: (db) async {},
    );
  }

  void _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys == ON');
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT,
      email TEXT,
      registerDate INTEGER,
      status INTEGER,
      photo BLOB)''');
  }

  // #region User queries

  addUser(User user) async {
    final db = await database;
    var result = await db.insert('user', user.toJson());

    return result;
  }

  getUsers() async {
    final db = await database;
    var result = await db.query('user');

    List<User> users =
        result.isNotEmpty ? result.map((u) => User.fromJson(u)).toList() : [];
    return users;
  }

  getUser(int id) async {
    final db = await database;
    var result = await db.query('user', where: 'id = ?', whereArgs: [id]);

    return result.isNotEmpty ? User.fromJson(result.first) : null;
  }

  getUserByName(String username) async {
    final db = await database;
    var result =
        await db.query('user', where: 'username = ?', whereArgs: [username]);

    return result.isNotEmpty ? User.fromJson(result.first) : null;
  }

  getUserByEmail(String email) async {
    final db = await database;
    var result = await db.query('user', where: 'email = ?', whereArgs: [email]);

    return result.isNotEmpty ? User.fromJson(result.first) : null;
  }

  updateUser(User user) async {
    final db = await database;
    var result = await db
        .update('user', user.toJson(), where: 'id = ?', whereArgs: [user.id]);

    return result;
  }

  deleteUser(int id) async {
    final db = await database;
    var result = await db.delete('user', where: 'id = ?', whereArgs: [id]);

    return result;
  }

  // #endregion
}
