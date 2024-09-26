import 'package:flutter/material.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';

class ManageAnnouncementsScreen extends StatelessWidget {
  const ManageAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: 'Manage Announcements'),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Announcement $index'),
            subtitle: Text('Description for Announcement $index'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Logic to edit the announcement
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Logic to delete the announcement
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
