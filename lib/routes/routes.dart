import 'package:btg_bank/models/AppRoute.dart';
import 'package:btg_bank/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static String initialRoute = '/home';

  static final menuOptions = <AppRoute>[
    AppRoute(route: initialRoute, screen: HomeScreen()),
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> routes = {};

    for (var option in menuOptions) {
      routes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return routes;
  }
}
