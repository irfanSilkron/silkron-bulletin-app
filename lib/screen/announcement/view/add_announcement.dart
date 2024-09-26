import 'package:flutter/material.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/app_category_dropdown.dart';
import '../../../widgets/app_text_field.dart';

class AddAnnouncementScreen extends StatefulWidget {
  const AddAnnouncementScreen({super.key});

  @override
  _AddAnnouncementScreenState createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  String? selectedCategory;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: 'Create Announcement'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Title TextField
              AppTextField(
                label: 'Announcement Title',
                controller: titleController,
              ),
              const SizedBox(height: 20),
              // Description TextField
              AppTextField(
                label: 'Announcement Description',
                maxLines: 5,
                controller: descriptionController,
              ),
              const SizedBox(height: 30),
              // Category Dropdown
              CategoryDropdown(
                selectedCategory: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              // Create Button
              AppButton(
                onPressed: () {
                  final newAnnouncement = Announcement(
                    title: titleController.text,
                    description: descriptionController.text,
                    category: selectedCategory ?? 'General',
                  );

                  print(newAnnouncement.toMap());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Create Button Widget
