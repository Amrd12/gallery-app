import 'package:flutter/material.dart';
import 'constans/strings.dart';
import 'ui/screens/Explore.dart';
import 'ui/screens/Home.dart';

// Map<String, Widget Function(BuildContext context)> AppRouter = {
//   navigationRoute: (context) => CustomNavigationbar(),
//   homeRoute: (context) => const HomeScreen(),
//   exploreRoute: (context) => const Explore(),
// };

class AppGenerateRouter {
  Route<dynamic>? generateroute(RouteSettings settings) {
    switch (settings.name) {
      // case navigationRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => CustomNavigationbar(), settings: settings);

      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(), settings: settings);

      case exploreRoute:
        return MaterialPageRoute(
            builder: (_) => const Explore(), settings: settings);

      default:
        return null;
    }
  }
}
