import 'package:coffeelito/presentation/on_boarding/on_boarding_screen.dart';
import 'package:coffeelito/presentation/splash/splash_screen.dart';
import 'package:coffeelito/presentation/tab_box/home/product_screen.dart';
import 'package:coffeelito/presentation/tab_box/home/widgets/product_detail_screen.dart';
import 'package:coffeelito/presentation/tab_box/tab_box.dart';
import 'package:coffeelito/presentation/tab_box_admin/home/product_screen_admin.dart';
import 'package:coffeelito/presentation/tab_box_admin/home/widgets/edit_screen.dart';
import 'package:coffeelito/presentation/tab_box_admin/tab_box_admin.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String homeScreen = "/home_screen";
  static const String homeScreenAdmin = "/home_screen_admin";
  static const String onBoarding = "/on_boarding";
  static const String tabBox = "/tab_box";
  static const String tabBoxAdmin = "/tab_box_admin";
  static const String detailScreen = "/detail_screen";
  static const String editScreen = "/edit_screen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const ProductScreen(),
        );
      case RouteNames.editScreen:
        return MaterialPageRoute(
          builder: (context) => const EditScreen(),
        );
      case RouteNames.homeScreenAdmin:
        return MaterialPageRoute(
          builder: (context) => const ProductScreenAdmin(),
        );
      case RouteNames.tabBoxAdmin:
        return MaterialPageRoute(
          builder: (context) => TabBoxAdmin(),
        );
      case RouteNames.detailScreen:
        return MaterialPageRoute(
          builder: (context) => const ProductDetailScreen(),
        );
      case RouteNames.tabBox:
        return MaterialPageRoute(
          builder: (context) => TabBox(),
        );
      case RouteNames.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not available!"),
            ),
          ),
        );
    }
  }
}
