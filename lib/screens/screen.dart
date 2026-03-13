import 'package:btg_bank/providers/home_tab_provider.dart';
import 'package:btg_bank/widgets/navigation/custom_bottom_navigation.dart';
import 'package:btg_bank/widgets/navigation/page_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Screens extends StatelessWidget {
  const Screens({super.key});

  static const List<String> _titles = <String>[
    'Fondos BTG Pactual',
    'Movimientos',
    'Resumen',
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<HomeTabProvider>().currentIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[currentIndex],
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: const PageSwitcher(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
