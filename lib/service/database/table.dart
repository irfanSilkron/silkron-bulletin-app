import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'database_config.dart';

@immutable
class Table {
  final String tableName;
  final String idCol;
  final String createdCol;
  final String updatedCol;
  final String isDeletedCol;
  final String remarkCol;
  final String referenceCol;

  const Table({
    required this.tableName,
    this.idCol = "id",
    this.createdCol = "created",
    this.updatedCol = "updated",
    this.isDeletedCol = "is_deleted",
    this.remarkCol = "remark",
    this.referenceCol = "reference",
  });

  static Future<Database>? _database;

  Future<Database> get database async {
    _database ??= DatabaseConfig().database;
    return _database!;
  }

  static String get date =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  static int get recordDeleted => 1;

  String getCreateTableQuery() {
    return '''
      CREATE TABLE IF NOT EXISTS $tableName (
        $idCol INTEGER PRIMARY KEY AUTOINCREMENT,
        $createdCol TEXT NOT NULL,
        $updatedCol TEXT NOT NULL,
        $remarkCol TEXT,
        $referenceCol TEXT,
        $isDeletedCol INTEGER NOT NULL DEFAULT 0
      )
    ''';
  }

  Future<void> createTable(Database db) async {
    debugPrint("========= creating $tableName table ========");

    await db.execute(getCreateTableQuery());
  }

  Future<int> insertRecord(Map<String, dynamic> values) async {
    final Database db = await database;
    values[createdCol] = date;
    values[updatedCol] = date;
    return await db.insert(tableName, values);
  }

  Future<int> updateRecord({
    required Map<String, dynamic> values,
    required int id,
  }) async {
    final Database db = await database;
    values[updatedCol] = date;
    return await db.update(
      tableName,
      values,
      where: '$idCol = ? AND $isDeletedCol != ?',
      whereArgs: [id, isDeletedCol],
    );
  }

  Future<int> deleteRecord(int recordId) async {
    final Database db = await database;

    return await db.update(
      tableName,
      {
        isDeletedCol: recordDeleted,
        updatedCol: date,
      },
      where: "$idCol = ?",
      whereArgs: [recordId],
    );
  }

  Future<Map<String, dynamic>?> getOneRecord(int recordId) async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$idCol = ?',
      whereArgs: [recordId],
    );

    return result.isNotEmpty ? result.first : null;
  }
}
