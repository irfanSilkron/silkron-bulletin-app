import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
        onCreate: _onCreate,
      );
    } on MissingPlatformDirectoryException {
      throw ErrorGetDocumentDirectory();
    } catch (e) {
      Logger().e("Failed to open database :$e");
      throw FailedOpenDatabase(e);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE announcements(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      category TEXT,
      created TEXT,  
      updated TEXT   
    )
  ''');
  }

  Future<List<Announcement>> getAnnouncements() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('announcements');

    return List.generate(maps.length, (i) {
      return Announcement.fromMap(maps[i]);
    });
  }

  Future<int> insertAnnouncement(Announcement announcement) async {
    final db = await database;
    return await db.insert('announcements', announcement.toMap());
  }

  Future<void> updateAnnouncement(Announcement announcement) async {
    final db = await database;
    await db.update(
      'announcements',
      announcement.toMap(),
      where: 'id = ?',
      whereArgs: [announcement.id],
    );
  }

  Future<int> removeAnnouncement(int id) async {
    final db = await database;
    return await db.delete(
      'announcements',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
