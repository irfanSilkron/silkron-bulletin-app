part of 'announcement_bloc.dart';

abstract class AnnouncementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementLoaded extends AnnouncementState {
  final List<Announcement> announcements;

  AnnouncementLoaded(this.announcements);

  @override
  List<Object?> get props => [announcements];
}

class AnnouncementError extends AnnouncementState {
  final String message;

  AnnouncementError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteAnnouncementSuccess extends AnnouncementState {
  final List<Announcement> announcements;

  DeleteAnnouncementSuccess(this.announcements);

  @override
  List<Object?> get props => [announcements];
}
