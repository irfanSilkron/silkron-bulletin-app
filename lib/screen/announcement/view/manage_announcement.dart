import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/config/theme/app_pallete.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import 'package:phone_comparison_app/utils/constant/path_route.dart';
import 'package:phone_comparison_app/widgets/base_app_bar.dart';
import 'package:phone_comparison_app/widgets/show_snackbar.dart';

class ManageAnnouncementsScreen extends StatefulWidget {
  const ManageAnnouncementsScreen({super.key});

  @override
  _ManageAnnouncementsScreenState createState() =>
      _ManageAnnouncementsScreenState();
}

class _ManageAnnouncementsScreenState extends State<ManageAnnouncementsScreen> {
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
        bloc: _announcementBloc,
        listener: (context, state) {
          if (state is UpdateAnnouncementSuccess) {
            showSnackbar(
                context: context, message: 'Announcement Updated Successfully');
          }

          if (state is DeleteAnnouncementSuccess) {
            showSnackbar(context: context, message: 'Announcement Deleted');

            _announcementBloc.add(LoadAnnouncements());
          }
        },
        builder: (context, state) {
          if (state is AnnouncementLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AnnouncementLoaded ||
              state is DeleteAnnouncementSuccess ||
              state is UpdateAnnouncementSuccess) {
            final announcements = state is AnnouncementLoaded
                ? state.announcements
                : (state as dynamic).announcements;

            if (announcements.isEmpty) {
              return const Center(
                child: Text(
                  "No announcements available",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  );
                },
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  final announcement = announcements[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        announcement.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            announcement.category,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: AppPallete.blueColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            announcement.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                PathRoute.editAnnouncementScreen,
                                arguments: announcement,
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteConfirmationDialog(
                                  context,
                                  announcement.announcmentId!,
                                  announcement.title);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is AnnouncementError) {
            return const Center(
              child: Text(
                "Error loading announcements",
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            );
          }

          return const Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }

  // Function to show delete confirmation dialog
  void _showDeleteConfirmationDialog(
      BuildContext context, int announcementId, String announcementTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Delete Announcement",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Are you sure you want to delete this announcement? \n\n Title : $announcementTitle",
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _announcementBloc.add(DeleteAnnouncement(announcementId));
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Delete",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
