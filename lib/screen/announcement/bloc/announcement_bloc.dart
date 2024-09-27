import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/screen/announcement/model/announcement_model.dart';
import 'package:phone_comparison_app/service/database/table/database_config.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final DatabaseConfig _databaseConfig = DatabaseConfig();

  AnnouncementBloc() : super(AnnouncementInitial()) {
    on<LoadAnnouncements>((event, emit) async {
      emit(AnnouncementLoading());
      try {
        await Future.delayed(const Duration(seconds: 2));
        final announcements = await _databaseConfig.getAnnouncements();
        emit(AnnouncementLoaded(announcements));
      } catch (e) {
        emit(AnnouncementError("Failed to load Announcements"));
      }
    });

    on<AddAnnouncement>((event, emit) async {
      await _databaseConfig.insertAnnouncement(event.announcement);

      final announcements = await _databaseConfig.getAnnouncements();
      emit(AnnouncementLoaded(announcements));
    });

    on<UpdateAnnouncement>((event, emit) async {
      await _databaseConfig.updateAnnouncement(event.updatedAnnouncement);

      final announcements = await _databaseConfig.getAnnouncements();
      emit(AnnouncementLoaded(announcements));
    });

    on<DeleteAnnouncement>((event, emit) async {
      await _databaseConfig.removeAnnouncement(event.id);

      final announcements = await _databaseConfig.getAnnouncements();
      emit(DeleteAnnouncementSuccess(announcements));
    });
  }
}
