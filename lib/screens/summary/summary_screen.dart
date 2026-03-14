import 'package:btg_bank/helpers/currency_text.dart';
import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/screens/summary/widgets/info_card.dart';
import 'package:btg_bank/widgets/shared/fade_in_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FundProvider provider = context.watch<FundProvider>();
    final int activeCount = provider.funds
        .where((fund) => provider.isSubscribed(fund.id))
        .length;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const FadeInWrapper(
            child: Text(
              'Mi resumen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FadeInWrapper(
            delay: const Duration(milliseconds: 100),
            child: InfoCard(
              title: 'Saldo actual',
              value: formatCop(provider.balance),
              icon: Icons.account_balance_wallet_rounded,
            ),
          ),
          const SizedBox(height: 10),
          FadeInWrapper(
            delay: const Duration(milliseconds: 200),
            child: InfoCard(
              title: 'Fondos activos',
              value: activeCount.toString(),
              icon: Icons.stacked_bar_chart_rounded,
            ),
          ),
          const SizedBox(height: 10),
          FadeInWrapper(
            delay: const Duration(milliseconds: 300),
            child: InfoCard(
              title: 'Movimientos',
              value: provider.transactions.length.toString(),
              icon: Icons.receipt_long_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
