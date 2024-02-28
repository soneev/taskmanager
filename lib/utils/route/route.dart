import 'package:get/get.dart';
import 'package:taskmanager/features/landing_screen/landing_screen.dart';
import 'package:taskmanager/features/splash_screen/splash_screen.dart';
import 'package:taskmanager/features/update_task/update_task_screen.dart';
import 'package:taskmanager/utils/route/route_name.dart';

appRoutes() => [
      GetPage(
        name: AppRoute.splash,
        page: () => SplashScreen(),
      ),
      GetPage(
        name: AppRoute.landing,
        page: () => LandingScreen(),
      ),
      GetPage(
        name: AppRoute.updateTask,
        page: () => const UpdateTask(),
      ),
    ];
