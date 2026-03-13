import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/providers/home_tab_provider.dart';
import 'package:btg_bank/routes/routes.dart';
import 'package:btg_bank/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeTabProvider>(
          create: (_) => HomeTabProvider(),
        ),
        ChangeNotifierProvider<FundProvider>(
          create: (_) => FundProvider()..loadFunds(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initialRoute,
        routes: Routes.getRoutes(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
