import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/screens/home/widgets/error_view.dart';
import 'package:btg_bank/screens/home/widgets/funds_grid.dart';
import 'package:btg_bank/widgets/home/balance_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FundProvider provider = context.watch<FundProvider>();

    return RefreshIndicator(
      onRefresh: provider.loadFunds,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BalanceCard(balance: provider.balance),
            const SizedBox(height: 20),
            const Text(
              'Fondos disponibles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),
            if (provider.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (provider.error != null)
              ErrorView(message: provider.error!, onRetry: provider.loadFunds)
            else
              const FundsGrid(),
          ],
        ),
      ),
    );
  }
}
