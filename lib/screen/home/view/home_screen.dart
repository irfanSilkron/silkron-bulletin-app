import 'package:flutter/material.dart';

import '../../add_phone/view/add_phone_screen.dart';

part '../home_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // State variable to track the selected index

  // List of screens to display
  final List<Widget> _screens = [
    // Home screen
    HomeContent(), // A widget that includes categoriesSection and phoneListSection
    const AddPhoneScreen(), // Add phone screen
    // You can add a ComparePhoneScreen here in the future
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Set the current index
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Phone',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            label: 'Compare Phone',
          ),
        ],
      ),
    );
  }
}

// Create a separate widget for Home Content
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          categoriesSection(context),
          phoneListSection(context),
        ],
      ),
    );
  }
}
