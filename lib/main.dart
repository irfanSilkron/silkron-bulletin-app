import 'package:flutter/material.dart';
import 'package:phone_comparison_app/screen/home/view/home_screen.dart';

import 'config/router/app_router.dart';

void main() {
  runApp(const MeetingRoomSchedulerApp());
}

class MeetingRoomSchedulerApp extends StatelessWidget {
  const MeetingRoomSchedulerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silkron Bulletin App',
      navigatorKey: AppRouter.navigatorKey,
      onGenerateRoute: AppRouter.generatePageList,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
