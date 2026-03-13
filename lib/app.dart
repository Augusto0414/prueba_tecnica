import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/routes/routes.dart';
import 'package:btg_bank/services/mock_fund_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FundProvider>(
          create: (_) =>
              FundProvider(apiService: MockFundApiService())..loadFunds(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initialRoute,
        routes: Routes.getRoutes(),
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo),
        ),
      ),
    );
  }
}
