import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';

class EditAnnouncementScreen extends StatefulWidget {
  final Announcement announcement;

  const EditAnnouncementScreen({super.key, required this.announcement});

  @override
  _EditAnnouncementScreenState createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    _title = widget.announcement.title;
    _description = widget.announcement.description;
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final updatedAnnouncement = Announcement(
                      announcmentId: widget.announcement.announcmentId,
                      title: _title,
                      description: _description,
                    );

                    BlocProvider.of<AnnouncementBloc>(context)
                        .add(UpdateAnnouncement(
                      announcmentId: updatedAnnouncement.announcmentId!,
                      title: _title,
                      description: _description,
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
