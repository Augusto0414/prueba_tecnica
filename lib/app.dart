import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/providers/home_tab_provider.dart';
import 'package:btg_bank/routes/routes.dart';
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
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color(0xFFF8FAFC),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0F766E),
            primary: const Color(0xFF0F766E),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xFFF8FAFC),
            foregroundColor: Color(0xFF0F172A),
            centerTitle: false,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
