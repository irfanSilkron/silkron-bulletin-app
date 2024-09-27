import 'package:flutter/material.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';
import '../widget/announcement_list.dart';
import '../widget/home_banner.dart';
import '../widget/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Silkron Bulletin App',
      ),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HomeBanner(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: AnnouncementsList(),
            ),
          ],
        ),
      ),
    );
  }
}
