import 'package:btg_bank/widgets/navigation/custom_bottom_navigation.dart';
import 'package:btg_bank/widgets/navigation/page_switcher.dart';
import 'package:flutter/material.dart';

class Screens extends StatelessWidget {
  const Screens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: PageSwitcher(),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
