import 'package:flutter/material.dart';
import 'package:phone_comparison_app/screen/announcement/bloc/announcement_bloc.dart';
import 'package:phone_comparison_app/screen/home/view/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_comparison_app/service/database/table/database_config.dart';
import 'package:phone_comparison_app/utils/simple_bloc_delegate.dart';
import 'config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseConfig().initDatabase();
  Bloc.observer = SimpleBlocDelegate();
  runApp(const SilkronBulletinApp());
}

class SilkronBulletinApp extends StatelessWidget {
  const SilkronBulletinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnnouncementBloc(),
      child: MaterialApp(
        home: const HomeScreen(),
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.generatePageList,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
