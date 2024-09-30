import 'package:flutter/material.dart';
import 'package:phone_comparison_app/config/theme/app_pallete.dart';
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
            Text(
              announcement.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppPallete.blackColor,
              ),
            ),
            const SizedBox(height: 16),

            //Divider
            Container(
              height: 4,
              width: 50,
              color: AppPallete.blueColor,
            ),

            const SizedBox(height: 20),

            Text(
              announcement.description,
              style: TextStyle(
                fontSize: 18,
                color: AppPallete.greyColor,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Icon(Icons.calendar_today, color: AppPallete.greyColor),
                const SizedBox(width: 8),
                Text(
                  'Published on: ${announcement.created}',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppPallete.greyColor,
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
