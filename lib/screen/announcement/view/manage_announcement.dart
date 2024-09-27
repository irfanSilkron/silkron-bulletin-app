import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';
import 'package:phone_comparison_app/service/database/table/database_config.dart';
import 'package:phone_comparison_app/widgets/app_bar.dart';

class ManageAnnouncementsScreen extends StatefulWidget {
  const ManageAnnouncementsScreen({super.key});

  @override
  _ManageAnnouncementsScreenState createState() =>
      _ManageAnnouncementsScreenState();
}

class _ManageAnnouncementsScreenState extends State<ManageAnnouncementsScreen> {
  final DatabaseConfig _databaseConfig = DatabaseConfig();
  late final AnnouncementBloc _announcementBloc;

  @override
  void initState() {
    _announcementBloc = BlocProvider.of<AnnouncementBloc>(context);
    _announcementBloc.add(LoadAnnouncements());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: 'Manage Announcements'),
      body: BlocConsumer<AnnouncementBloc, AnnouncementState>(
        listener: (context, state) {
          if (state is AnnouncementDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Announcement Deleted')),
            );
          }
        },
        builder: (context, state) {
          if (state is AnnouncementLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AnnouncementLoaded) {
            if (state.announcements.isEmpty) {
              return const Center(
                child: Text("No announcements available"),
              );
            }

            return ListView.builder(
              itemCount: state.announcements.length,
              itemBuilder: (context, index) {
                final announcement = state.announcements[index];
                return ListTile(
                  title: Text(announcement.title),
                  subtitle: Text(announcement.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Logic to edit the announcement
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(
                              context, announcement.id!);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is AnnouncementError) {
            return const Center(
              child: Text("Error loading announcements"),
            );
          }

          return const Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }

  // Function to show delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, int announcementId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Announcement"),
          content:
              const Text("Are you sure you want to delete this announcement?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _announcementBloc.add(DeleteAnnouncement(announcementId));
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
