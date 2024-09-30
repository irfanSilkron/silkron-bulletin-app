import 'package:flutter/material.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';
import '../../../utils/constant/image_asset.dart';
import '../widget/announcement_list.dart';
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

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAsset().homeBanner),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
