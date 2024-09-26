import 'package:flutter/material.dart';

class ManageAnnouncementsScreen extends StatelessWidget {
  const ManageAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Announcements'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with dynamic count of announcements
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                'Announcement $index'), // Replace with actual announcement title
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
