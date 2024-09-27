import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';
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
    _announcementBloc.add(LoadAnnouncements()); // Load announcements on init
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnouncementBloc, AnnouncementState>(
      listener: (context, state) async {
        if (state is AnnouncementError) {
          showSnackbar(context: context, message: "error");
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
              child: Text("No Announcements Available"),
            );
          }

          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.announcements.length,
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.grey,
                thickness: 1,
              );
            },
            itemBuilder: (context, index) {
              final announcement = state.announcements[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ListTile(
                    leading: const Icon(
                      Icons.announcement,
                      color: Colors.blue,
                      size: 30,
                    ),
                    title: Text(
                      announcement.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnnouncementDetailScreen(),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text("Something went wrong!"),
          );
        }
      },
    );
  }
}
