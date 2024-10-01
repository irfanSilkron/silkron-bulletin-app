part of 'announcement_bloc.dart';

@immutable
abstract class AnnouncementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAnnouncements extends AnnouncementEvent {}

class AddAnnouncement extends AnnouncementEvent {
  final String title;
  final String description;
  final String category;

  AddAnnouncement({
    required this.title,
    required this.description,
    required this.category,
  });

  @override
  List<Object?> get props => [title, description, category];
}

class UpdateAnnouncement extends AnnouncementEvent {
  final Announcement announcement;

  UpdateAnnouncement({
    required this.announcement,
  });

  @override
  List<Object?> get props => [announcement];
}

class DeleteAnnouncement extends AnnouncementEvent {
  final int announcmentId;

  DeleteAnnouncement(this.announcmentId);

  @override
  List<Object?> get props => [announcmentId];
}
