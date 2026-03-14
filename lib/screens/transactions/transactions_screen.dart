import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/screens/transactions/widgets/empty_state.dart';
import 'package:btg_bank/widgets/home/transaction_tile.dart';
import 'package:btg_bank/widgets/shared/fade_in_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FundProvider provider = context.watch<FundProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const FadeInWrapper(
            child: Text(
              'Historial de transacciones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (provider.transactions.isEmpty)
            const FadeInWrapper(
              delay: Duration(milliseconds: 100),
              child: EmptyState(),
            )
          else
            Column(
              children: provider.transactions.asMap().entries.map((entry) {
                final index = entry.key;
                final record = entry.value;
                return FadeInWrapper(
                  delay: Duration(milliseconds: 100 + (index * 50)),
                  child: TransactionTile(record: record),
                );
              }).toList(growable: false),
            ),
        ],
      ),
    );
  }
}
