import 'package:flutter/material.dart';
import 'package:phone_comparison_app/screen/announcement/view/add_announcement.dart';
import 'package:phone_comparison_app/screen/announcement/view/manage_announcement.dart';
import 'package:phone_comparison_app/screen/home/view/home_screen.dart';
import 'package:phone_comparison_app/utils/constant/path_route.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generatePageList(RouteSettings settings) {
    switch (settings.name) {
      case PathRoute.homeScreen:
        return _generatePageRoute(
          settings,
          (context) => const HomeScreen(),
        );
      case PathRoute.addAnnouncementScreen:
        return _generatePageRoute(
          settings,
          (context) => const AddAnnouncementScreen(),
        );

      case PathRoute.manageAnnouncementScreen:
        return _generatePageRoute(
          settings,
          (context) => const ManageAnnouncementsScreen(),
        );

      default:
        return _generatePageRoute(
          settings,
          (context) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _generatePageRoute(
    RouteSettings settings,
    Widget Function(BuildContext context) builder,
  ) =>
      MaterialPageRoute(builder: builder, settings: settings);
}
