import 'package:flutter/material.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: BaseAppBar(title: "Announcement Details"));
  }
}
