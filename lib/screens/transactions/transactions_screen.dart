import 'package:btg_bank/providers/fund_provider.dart';
import 'package:btg_bank/screens/transactions/widgets/empty_state.dart';
import 'package:btg_bank/widgets/home/transaction_tile.dart';
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
          const Text(
            'Historial de transacciones',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          if (provider.transactions.isEmpty)
            const EmptyState()
          else
            Column(
              children: provider.transactions
                  .map((record) => TransactionTile(record: record))
                  .toList(growable: false),
            ),
        ],
      ),
    );
  }
}
