import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';
import 'package:phone_comparison_app/screen/home/view/home_screen.dart';
import 'package:phone_comparison_app/utils/constant/path_route.dart';
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
  late final AnnouncementBloc _announcementBloc;
  String? selectedCategory;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    _announcementBloc = BlocProvider.of<AnnouncementBloc>(context);
    super.initState();
  }

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
              BlocConsumer<AnnouncementBloc, AnnouncementState>(
                listener: (context, state) {
                  if (state is AnnouncementLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Announcement Added')),
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
                  } else if (state is AnnouncementError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Error")),
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    onPressed: () {
                      if (selectedCategory != null &&
                          titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        final newAnnouncement = Announcement(
                          title: titleController.text,
                          description: descriptionController.text,
                          category: selectedCategory!,
                        );

                        _announcementBloc.add(
                          AddAnnouncement(newAnnouncement),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields')),
                        );
                      }
                    },
                    label: state is AnnouncementLoading
                        ? 'Adding...'
                        : 'Create Announcement',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
