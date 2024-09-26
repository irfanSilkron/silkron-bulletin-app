import 'package:flutter/material.dart';
import 'package:phone_comparison_app/utils/constant/image_asset.dart';
import 'package:phone_comparison_app/utils/constant/path_route.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';
import '../home_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Silkron Bulletin App',
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Announcement'),
              onTap: () {
                Navigator.pushNamed(context, PathRoute.addAnnouncementScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Manage Announcement'),
              onTap: () {
                Navigator.pushNamed(
                    context, PathRoute.manageAnnouncementScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(ImageAsset().homeBanner),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: announcementsList(context),
            ),
          ],
        ),
      ),
    );
  }
}
