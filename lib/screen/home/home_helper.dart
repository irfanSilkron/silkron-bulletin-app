import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../announcement/view/announcement_detail_screen.dart';

final announcements = [
  {
    'title': 'Company Meeting',
    'content': 'Don\'t forget our meeting tomorrow!',
    'category': 'Meeting',
    'created_at': '2024-09-25T12:00:00' // Example date
  },
  {
    'title': 'New Policy Update',
    'content': 'Please review the new policy document.',
    'category': 'Policy',
    'created_at': '2024-09-24T10:00:00' // Example date
  },
  {
    'title': 'Company Meeting',
    'content': 'Don\'t forget our meeting tomorrow!',
    'category': 'Meeting',
    'created_at': '2024-09-25T12:00:00' // Example date
  },
  {
    'title': 'Company Meeting',
    'content': 'Don\'t forget our meeting tomorrow!',
    'category': 'Meeting',
    'created_at': '2024-09-25T12:00:00' // Example date
  },
  {
    'title': 'Company Meeting',
    'content': 'Don\'t forget our meeting tomorrow!',
    'category': 'Meeting',
    'created_at': '2024-09-25T12:00:00' // Example date
  },
  {
    'title': 'Company Meeting',
    'content': 'Don\'t forget our meeting tomorrow!',
    'category': 'Meeting',
    'created_at': '2024-09-25T12:00:00' // Example date
  },
];

final today = DateTime.now();

String formatDate(String dateString) {
  final DateTime date = DateTime.parse(dateString);
  if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day) {
    return 'Today';
  }
  return DateFormat('dd/MM/yyyy').format(date);
}

ListView announcementsList(BuildContext context) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: announcements.length,
    separatorBuilder: (context, index) {
      return const Divider(
        color: Colors.grey,
        thickness: 1,
        // height: 20,
      );
    },
    itemBuilder: (context, index) {
      final announcement = announcements[index];
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ListTile(
            leading: const Icon(
              Icons.announcement,
              color: Colors.blue,
              size: 30,
            ),
            title: Text(
              announcement['title']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(formatDate(announcement['created_at']!)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnnouncementDetailScreen(),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
