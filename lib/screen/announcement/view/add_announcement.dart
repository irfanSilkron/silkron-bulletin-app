import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import 'package:phone_comparison_app/screen/home/view/home_screen.dart';
import 'package:phone_comparison_app/utils/constant/path_route.dart';
import 'package:phone_comparison_app/widgets/base_app_bar.dart';
import 'package:phone_comparison_app/widgets/app_button.dart';
import 'package:phone_comparison_app/widgets/app_category_dropdown.dart';
import 'package:phone_comparison_app/widgets/app_text_field.dart';
import 'package:phone_comparison_app/widgets/show_snackbar.dart';

class AddAnnouncementScreen extends StatefulWidget {
  const AddAnnouncementScreen({super.key});

  @override
  _AddAnnouncementScreenState createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  late final AnnouncementBloc _announcementBloc;
  String? selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _announcementBloc = BlocProvider.of<AnnouncementBloc>(context);
    super.initState();
  }

  @override
  void dispose() async {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
              AppTextField(
                label: 'Announcement Title',
                controller: _titleController,
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Announcement Description',
                maxLines: 5,
                controller: _descriptionController,
              ),
              const SizedBox(height: 30),
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
                bloc: _announcementBloc,
                listener: (context, state) {
                  if (state is AnnouncementLoaded) {
                    showSnackbar(
                        context: context, message: 'Announcement Added');

                    Navigator.of(context)
                        .pushReplacementNamed(PathRoute.homeScreen);
                  } else if (state is AnnouncementError) {
                    showSnackbar(context: context, message: 'Error');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    onPressed: () {
                      if (selectedCategory != null &&
                          _titleController.text.isNotEmpty &&
                          _descriptionController.text.isNotEmpty) {
                        _announcementBloc.add(
                          AddAnnouncement(
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim(),
                            category: selectedCategory!,
                          ),
                        );
                      } else {
                        showSnackbar(
                            context: context,
                            message: 'Please fill all fields',
                            bgColor: Colors.red);
                      }
                    },
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
