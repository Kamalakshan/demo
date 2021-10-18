import 'package:get/get.dart';
import 'package:vidquiz/screens/home/home_bindings.dart';
import 'package:vidquiz/screens/home/home_page.dart';
import 'package:vidquiz/screens/quiz/quiz_bindings.dart';
import 'package:vidquiz/screens/quiz/quiz_page.dart';
import 'package:vidquiz/screens/splash/splash_bindings.dart';
import 'package:vidquiz/screens/splash/splash_page.dart';
import 'package:vidquiz/screens/video/video_bindings.dart';
import 'package:vidquiz/screens/video/video_page.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.VIDEOPLAYER,
      page: () => VideoPage(),
      binding: VideoBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.QUIZ,
      page: () => QuizPage(),
      binding: QuizBindings(),
    ),
  ];
}
