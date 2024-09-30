import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../table.dart';

class AnnouncementTable extends Table {
  final String titleCol;
  final String descriptionCol;
  final String categoryCol;

  const AnnouncementTable._internal()
      : titleCol = "title",
        descriptionCol = "description",
        categoryCol = "category",
        super(
          tableName: "announcement",
        );

  static AnnouncementTable instance = const AnnouncementTable._internal();

  @override
  String getCreateTableQuery() {
    return '''
      CREATE TABLE IF NOT EXISTS $tableName (
        $idCol INTEGER PRIMARY KEY AUTOINCREMENT,
        $createdCol TEXT NOT NULL,
        $updatedCol TEXT NOT NULL,
        $descriptionCol TEXT NOT NULL,
        $categoryCol TEXT ,
        $titleCol TEXT,
        $remarkCol TEXT,
        $referenceCol TEXT,
        $isDeletedCol INTEGER NOT NULL DEFAULT 0
      )
    ''';
  }

  static Future<Map<String, dynamic>?> addAnnouncement({
    required String title,
    required String description,
    required String category,
    bool catchErrMsg = false,
  }) async {
    try {
      final AnnouncementTable announcementTable = AnnouncementTable.instance;

      final Database db = await announcementTable.database;

      final int announcementId = await announcementTable.insertRecord({
        announcementTable.titleCol: title,
        announcementTable.descriptionCol: description,
        announcementTable.categoryCol: category,
      });

      if (announcementId == -1) {
        throw Exception("Failed to add announcement.");
      }

      final Map<String, dynamic>? announcementData =
          await announcementTable.getOneRecord(announcementId);

      if (announcementData == null) {
        throw Exception("Announcement not found after insertion");
      }

      return announcementData;
    } catch (e) {
      Logger().f("Failed to register announcement, $e");
      if (catchErrMsg) {
        rethrow;
      }

      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllAnnouncements() async {
    final AnnouncementTable announcementTable = AnnouncementTable.instance;

    final Database db = await announcementTable.database;

    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$isDeletedCol = ?',
      whereArgs: [0],
    );

    return result;
  }

  Future<int> updateAnnouncementRecord({
    required Map<String, dynamic> values,
    required int id,
  }) async {
    final Database db = await database;
    values[updatedCol] = DateTime.now().toIso8601String();

    return await db.update(
      tableName,
      values,
      where: '$idCol = ? AND $isDeletedCol != ?',
      whereArgs: [id, 1],
    );
  }

  Future<int> deleteAnnouncementRecord(int id) async {
    final Database db = await database;

    return await db.update(
      tableName,
      {
        isDeletedCol: 1,
        updatedCol: DateTime.now().toIso8601String(),
      },
      where: '$idCol = ?',
      whereArgs: [id],
    );
  }
}
