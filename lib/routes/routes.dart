import 'package:btg_bank/models/app_route.dart';
import 'package:btg_bank/providers/home_tab_provider.dart';
import 'package:btg_bank/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  static const String initialRoute = '/home';
  static const String fundsTabRoute = '/funds';
  static const String transactionsTabRoute = '/transactions';
  static const String summaryTabRoute = '/summary';

  static final List<AppRoute> menuOptions = <AppRoute>[
    AppRoute(route: initialRoute, screen: const Screens()),
    AppRoute(route: fundsTabRoute, screen: const Screens()),
    AppRoute(route: transactionsTabRoute, screen: const Screens()),
    AppRoute(route: summaryTabRoute, screen: const Screens()),
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return <String, Widget Function(BuildContext)>{
      initialRoute: (BuildContext context) => _buildMainRoute(context, 0),
      fundsTabRoute: (BuildContext context) => _buildMainRoute(context, 0),
      transactionsTabRoute: (BuildContext context) =>
          _buildMainRoute(context, 1),
      summaryTabRoute: (BuildContext context) => _buildMainRoute(context, 2),
    };
  }

  static Widget _buildMainRoute(BuildContext context, int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) {
        return;
      }
      context.read<HomeTabProvider>().setIndex(index);
    });
    return const Screens();
  }
}
