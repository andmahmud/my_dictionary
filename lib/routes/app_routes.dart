import 'package:get/get.dart';
import 'package:my_dictionary/feature/home/screen/home_screen.dart';
import 'package:my_dictionary/feature/nav_bar/screen/nav_bar.dart';
import 'package:my_dictionary/feature/splash/presentation/screen/splash_screen.dart';

class AppRoute {
  static String init = "/";
  static String splashScreen = "/splashScreen";
  static String Homescreen = "/Homescreen";
  static String navbar = "/navbar";

  static List<GetPage> routes = [
    GetPage(name: init, page: () => SplashScreen()),
    GetPage(name: Homescreen, page: () => HomeScreen()),
    GetPage(name: navbar, page: () => NavBar()),
  ];
}
