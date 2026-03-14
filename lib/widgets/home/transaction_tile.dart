import 'package:btg_bank/helpers/currency_text.dart';
import 'package:btg_bank/models/transaction_record.dart';
import 'package:btg_bank/theme/app_theme.dart';
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

    final String subtitle = isSubscription ? 'Suscripción' : 'Cancelación';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.softShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {}, // For visual feedback
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: tone.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSubscription ? Icons.add_card_rounded : Icons.undo_rounded,
                    color: tone,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.fundName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$subtitle • ${record.timestamp.day.toString().padLeft(2, '0')}/'
                        '${record.timestamp.month.toString().padLeft(2, '0')}/'
                        '${record.timestamp.year}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  formatCop(record.amount),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: tone,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
