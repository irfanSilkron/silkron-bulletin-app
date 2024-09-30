import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phone_comparison_app/service/database/table/announcement_table.dart';
import 'package:sqflite/sqflite.dart';
import '../../../screen/announcement/model/announcement_model.dart';
import 'database_exception.dart';

class DatabaseConfig {
  static final DatabaseConfig _singleton = DatabaseConfig._internal();
  Database? _db;

  DatabaseConfig._internal();

  factory DatabaseConfig() {
    return _singleton;
  }

  static const String _dbName = "silkronBulletin.db";
  static const int _dbVersion = 1;

  Future<Database> get database async {
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
        onCreate: _createDb,
      );
    } on MissingPlatformDirectoryException {
      throw ErrorGetDocumentDirectory();
    } catch (e) {
      Logger().e("Failed to open database :$e");
      throw FailedOpenDatabase(e);
    }
  }

  Future<void> _createDb(Database db, int newVersion) async {
    debugPrint("========= creating tables ========");
    await AnnouncementTable.instance.createTable(db);
  }
}
