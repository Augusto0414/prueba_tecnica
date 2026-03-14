import 'package:btg_bank/screens/summary/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('InfoCard displays title, value and icon', (
    WidgetTester tester,
  ) async {
    const String title = 'Total Invertido';
    const String value = '\$2,500,000';
    const IconData icon = Icons.savings;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InfoCard(title: title, value: value, icon: icon),
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);
    expect(find.text(value), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);
  });
}
