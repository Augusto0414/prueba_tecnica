import 'package:btg_bank/providers/home_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeTabProvider tabProvider = context.watch<HomeTabProvider>();

    return NavigationBar(
      selectedIndex: tabProvider.currentIndex,
      onDestinationSelected: tabProvider.setIndex,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.account_balance_rounded),
          label: 'Fondos',
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt_long_rounded),
          label: 'Transacciones',
        ),
        NavigationDestination(
          icon: Icon(Icons.space_dashboard_rounded),
          label: 'Resumen',
        ),
      ],
    );
  }
}
