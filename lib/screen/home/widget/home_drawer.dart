import 'package:flutter/material.dart';
import 'package:phone_comparison_app/utils/constant/path_route.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _buildDrawerItem(
            context,
            icon: Icons.add,
            title: 'Add Announcement',
            route: PathRoute.addAnnouncementScreen,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Manage Announcement',
            route: PathRoute.manageAnnouncementScreen,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              // Add logout logic
            },
          ),
        ],
      ),
    );
  }

  // Helper method for Drawer items
  ListTile _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap ??
          () {
            if (route != null) {
              Navigator.pushNamed(context, route);
            }
          },
    );
  }
}
