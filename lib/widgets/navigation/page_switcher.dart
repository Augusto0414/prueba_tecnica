import 'package:btg_bank/providers/home_tab_provider.dart';
import 'package:btg_bank/screens/home/home_screen.dart';
import 'package:btg_bank/screens/summary/summary_screen.dart';
import 'package:btg_bank/screens/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageSwitcher extends StatelessWidget {
  const PageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<HomeTabProvider>().currentIndex;

    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TransactionsScreen();
      case 2:
        return const SummaryScreen();
      default:
        return const HomeScreen();
    }
  }
}
