import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import '../../../widgets/show_snackbar.dart';
import '../../announcement/view/announcement_detail_screen.dart';

class AnnouncementsList extends StatefulWidget {
  const AnnouncementsList({super.key});

  @override
  _AnnouncementsListState createState() => _AnnouncementsListState();
}

class _AnnouncementsListState extends State<AnnouncementsList> {
  late final AnnouncementBloc _announcementBloc;

  @override
  void initState() {
    super.initState();
    _announcementBloc = BlocProvider.of<AnnouncementBloc>(context);
    _announcementBloc.add(LoadAnnouncements());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnouncementBloc, AnnouncementState>(
      listener: (context, state) async {
        if (state is AnnouncementError) {
          showSnackbar(
              context: context, message: "Error loading announcements");
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
              child: Text(
                "No Announcements Available",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            itemCount: state.announcements.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemBuilder: (context, index) {
              final announcement = state.announcements[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnnouncementDetailScreen(
                          announcement: announcement,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.announcement,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                announcement.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                announcement.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text("Failed to fetch Announcements!"),
          );
        }
      },
    );
  }
}
