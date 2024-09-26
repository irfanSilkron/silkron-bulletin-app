import 'package:flutter/material.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';
import '../widget/announcement_list.dart';
import '../widget/home_banner.dart';
import '../widget/home_drawer.dart';

// HomeScreen widget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Silkron Bulletin App',
      ),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeBanner(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: AnnouncementsList(),
            ),
          ],
        ),
      ),
    );
  }
}
