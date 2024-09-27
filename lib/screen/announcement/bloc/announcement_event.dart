part of 'announcement_bloc.dart';

abstract class AnnouncementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAnnouncements extends AnnouncementEvent {}

class AddAnnouncement extends AnnouncementEvent {
  final Announcement announcement;

  AddAnnouncement(this.announcement);

  @override
  List<Object?> get props => [announcement];
}

class UpdateAnnouncement extends AnnouncementEvent {
  final Announcement announcement;

  UpdateAnnouncement(this.announcement);

  @override
  List<Object?> get props => [announcement];
}

class DeleteAnnouncement extends AnnouncementEvent {
  final int id;

  DeleteAnnouncement(this.id);

  @override
  List<Object?> get props => [id];
}
