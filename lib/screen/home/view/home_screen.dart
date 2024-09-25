import 'package:flutter/material.dart';

part '../home_helper.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      centerTitle: true,
      ),
      body:  Column(
        children: [
          categoriesSection(context),
          phoneList(context),
        ],
      ),
    );
  }
}