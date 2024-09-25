import 'package:flutter/material.dart';
import '../../announcement_details/view/announcement_detail_screen.dart';
import '../home_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for announcements

    // Get today's date

    return Scaffold(
      appBar: AppBar(
        title: const Text('Silkron Bulletin App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/Announcements.png'),
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
