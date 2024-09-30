import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  AnnouncementBloc() : super(AnnouncementInitial()) {
    on<LoadAnnouncements>(_onLoadAnnouncements);
    on<AddAnnouncement>(_onAddAnnouncements);
    on<UpdateAnnouncement>(_onUpdateAnnouncement);
    on<DeleteAnnouncement>(_onDeleteAnnouncement);
  }

  Future<void> _onLoadAnnouncements(
      LoadAnnouncements event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      final allAnnouncements = await Announcement.getAnnouncements();
      await Future.delayed(const Duration(seconds: 2));
      emit(AnnouncementLoaded(allAnnouncements));
    } catch (e) {
      emit(AnnouncementError("Failed to load Announcements"));
    }
  }

  Future<void> _onAddAnnouncements(
      AddAnnouncement event, Emitter<AnnouncementState> emit) async {
    try {
      final Announcement? announcementData =
          await Announcement.addNewAnnouncement(
        title: event.title,
        description: event.description,
        category: event.category,
      );

      if (announcementData != null) {
        final allAnnouncements = await Announcement.getAnnouncements();
        emit(AnnouncementLoaded(allAnnouncements));
      } else {
        emit(AnnouncementError("Failed to add announcement"));
      }
    } catch (e) {
      emit(AnnouncementError("Unexpected error occurred: $e"));
    }
  }

  Future<void> _onUpdateAnnouncement(
      UpdateAnnouncement event, Emitter<AnnouncementState> emit) async {
    final announcementToUpdate = Announcement(
      announcmentId: event.announcmentId,
      title: event.title,
      description: event.description,
    );

    final isSuccess = await announcementToUpdate.updateAnnouncement();

    if (isSuccess) {
      final allAnnouncements = await Announcement.getAnnouncements();
      emit(AnnouncementLoaded(allAnnouncements));
    } else {
      emit(AnnouncementError("Failed to update announcement"));
    }
  }

  Future<void> _onDeleteAnnouncement(
      DeleteAnnouncement event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      final success =
          await Announcement.deleteAnnouncement(event.announcmentId);

      if (success) {
        final allAnnouncements = await Announcement.getAnnouncements();
        emit(AnnouncementLoaded(allAnnouncements));
      } else {
        emit(AnnouncementError("Failed to delete announcement"));
      }
    } catch (e) {
      emit(AnnouncementError("Unexpected error occurred: $e"));
    }
  }
}
