import 'package:btg_bank/helpers/currency_text.dart';
import 'package:btg_bank/models/transaction_record.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.record});

  final TransactionRecord record;

  @override
  Widget build(BuildContext context) {
    final bool isSubscription = record.type == TransactionType.subscription;
    final Color tone = isSubscription
        ? const Color(0xFFDC2626)
        : const Color(0xFF12AC9C);

    final String subtitle = isSubscription ? 'Suscripcion' : 'Cancelacion';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: tone.withValues(alpha: 0.15),
          child: Icon(
            isSubscription ? Icons.add_card_rounded : Icons.undo_rounded,
            color: tone,
          ),
        ),
        title: Text(
          record.fundName,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '$subtitle • ${record.timestamp.day.toString().padLeft(2, '0')}/'
          '${record.timestamp.month.toString().padLeft(2, '0')}/'
          '${record.timestamp.year}',
        ),
        trailing: Text(
          formatCop(record.amount),
          style: TextStyle(fontWeight: FontWeight.w700, color: tone),
        ),
      ),
    );
  }
}
