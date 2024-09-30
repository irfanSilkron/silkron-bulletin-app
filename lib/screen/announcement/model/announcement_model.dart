import 'package:phone_comparison_app/service/database/table/announcement_table.dart';

class Announcement {
  final int? announcmentId;
  final String title;
  final String description;
  final String category;

  final DateTime? created;
  final DateTime? updated;
  final String? remark;
  final String? reference;
  final int? isDeleted;

  Announcement({
    this.announcmentId,
    required this.title,
    required this.description,
    required this.category,
    this.created,
    this.updated,
    this.remark,
    this.reference,
    this.isDeleted,
  });

  static Future<Announcement> fromDatabase(Map<String, dynamic> json) async {
    final AnnouncementTable announcementTable = AnnouncementTable.instance;

    return Announcement(
      announcmentId: json[announcementTable.idCol],
      created: DateTime.parse(json[announcementTable.createdCol]),
      updated: DateTime.parse(json[announcementTable.updatedCol]),
      title: json[announcementTable.titleCol],
      description: json[announcementTable.descriptionCol],
      category: json[announcementTable.categoryCol],
      remark: json[announcementTable.remarkCol],
      reference: json[announcementTable.referenceCol],
      isDeleted: json[announcementTable.isDeletedCol],
    );
  }

  static Future<Announcement?> addNewAnnouncement({
    required String title,
    required String description,
    required String category,
  }) async {
    var result = await AnnouncementTable.addAnnouncement(
      title: title,
      description: description,
      category: category,
      catchErrMsg: true,
    );

    if (result == null) {
      return null;
    }

    return await fromDatabase(result);
  }

  static Future<List<Announcement>> getAnnouncements() async {
    final AnnouncementTable announcementTable = AnnouncementTable.instance;

    final List<Map<String, dynamic>> rows =
        await announcementTable.getAllAnnouncements();

    return Future.wait(rows.map((row) async => fromDatabase(row)));
  }

  Future<bool> updateAnnouncement() async {
    if (announcmentId == null) {
      return false;
    }

    final result = await AnnouncementTable.instance.updateAnnouncementRecord(
      values: {
        'title': title,
        'description': description,
        'category': category,
        'updated': DateTime.now().toIso8601String(),
      },
      id: announcmentId!,
    );

    return result > 0;
  }

  static Future<bool> deleteAnnouncement(int id) async {
    final result =
        await AnnouncementTable.instance.deleteAnnouncementRecord(id);

    return result > 0;
  }
}
