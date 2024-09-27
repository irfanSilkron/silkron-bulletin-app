import 'package:flutter/material.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementDetailScreen({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: 'Announcement Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Announcement Title
            Text(
              announcement.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Decorative divider
            Container(
              height: 4,
              width: 50,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            // Announcement Description
            Text(
              announcement.description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700,
                height: 1.5, // line height for better readability
              ),
            ),

            const SizedBox(height: 20),

            // Announcement Date (Optional)
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Published on: ${'Today'}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
