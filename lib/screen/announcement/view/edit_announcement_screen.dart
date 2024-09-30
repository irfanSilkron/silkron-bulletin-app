import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';

import '../../../widgets/app_category_dropdown.dart';

class EditAnnouncementScreen extends StatefulWidget {
  final Announcement announcement;
  const EditAnnouncementScreen({super.key, required this.announcement});

  @override
  _EditAnnouncementScreenState createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  late final AnnouncementBloc _announcementBloc;
  late String _title;
  late String _description;
  late String _category;
  String? selectedCategory;

  @override
  void initState() {
    _announcementBloc = BlocProvider.of<AnnouncementBloc>(context);
    _title = widget.announcement.title;
    _description = widget.announcement.description;
    _category = widget.announcement.category;
    selectedCategory = _category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Announcement")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 30),
              CategoryDropdown(
                selectedCategory: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    _category = value ?? _category;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final updatedAnnouncement = Announcement(
                      announcmentId: widget.announcement.announcmentId,
                      title: _title,
                      description: _description,
                      category: _category,
                    );

                    _announcementBloc.add(UpdateAnnouncement(
                      announcmentId: updatedAnnouncement.announcmentId!,
                      title: _title,
                      description: _description,
                      category: _category,
                    ));

                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
