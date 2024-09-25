import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'database_exception.dart';

class DatabaseConfig {
  static final DatabaseConfig _singleton = DatabaseConfig._internal();
  Database? _db;


  factory DatabaseConfig() {
    return _singleton;
  }

  DatabaseConfig._internal();


  static const String _dbName = "phone_comparison.db";
  static const int _dbVersion = 1;

  Future<Database> getDb() async {

    if (_db != null) {
      return _db!;
    }

    _db ?? await initDatabase();
    return _db!;
  }


  Future<void> initDatabase() async {
    try {
      final String dbPath = join(
        await getDatabasesPath(),
        _dbName,
      );

      _db = await openDatabase(
        dbPath,
        version: _dbVersion,
        onCreate: _onCreate,
      );
    } on MissingPlatformDirectoryException {
      throw ErrorGetDocumentDirectory();
    } catch (e) {
      Logger().e("Failed to open database :$e");
      throw FailedOpenDatabase(e);
    }
  }

   void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE phones (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        brand TEXT,
        model TEXT,
        price REAL
      )
    ''');
  }

}
