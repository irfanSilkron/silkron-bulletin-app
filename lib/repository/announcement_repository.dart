// import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';

// import '../service/database/database_config.dart';

// class AnnouncementRepository {
//   final DatabaseConfig _databaseConfig = DatabaseConfig();

//   Future<List<Announcement>> getAnnouncements() async {
//     final db = await _databaseConfig.database;
//     final List<Map<String, dynamic>> maps = await db.query('announcements');
//     return List.generate(maps.length, (i) {
//       return Announcement.fromMap(maps[i]);
//     });
//   }

//   Future<int> insertAnnouncement(Announcement announcement) async {
//     final db = await _databaseConfig.database;
//     return await db.insert('announcements', announcement.toMap());
//   }

//   Future<void> updateAnnouncement(Announcement announcement) async {
//     final db = await _databaseConfig.database;
//     await db.update(
//       'announcements',
//       announcement.toMap(),
//       where: 'id = ?',
//       whereArgs: [announcement.id],
//     );
//   }

//   Future<int> removeAnnouncement(int id) async {
//     final db = await _databaseConfig.database;
//     return await db.delete(
//       'announcements',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }
