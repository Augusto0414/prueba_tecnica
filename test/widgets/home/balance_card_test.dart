import 'package:btg_bank/helpers/currency_text.dart';
import 'package:btg_bank/theme/app_theme.dart';
import 'package:btg_bank/widgets/home/balance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'BalanceCard displays the correct labels and balance formatting',
    (WidgetTester tester) async {
      const int balance = 1250000;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(body: BalanceCard(balance: balance)),
        ),
      );

      // Verify static text (title and subtitle)
      expect(find.text('Saldo disponible'), findsNWidgets(2));

      // Verify formatted balance
      final formattedBalance = formatCop(balance);
      expect(find.text(formattedBalance), findsOneWidget);
    },
  );
}
