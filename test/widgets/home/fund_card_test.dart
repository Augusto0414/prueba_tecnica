import 'package:btg_bank/models/fund.dart';
import 'package:btg_bank/theme/app_theme.dart';
import 'package:btg_bank/widgets/home/fund_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FundCard displays fund details and handles callbacks', (
    WidgetTester tester,
  ) async {
    bool subscribePressed = false;

    final fund = Fund(
      id: 1,
      name: 'Fondo Prueba',
      minimumAmount: 50000,
      category: 'FPV',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: FundCard(
            fund: fund,
            subscribed: false,
            onSubscribe: () => subscribePressed = true,
            onCancel: () {},
          ),
        ),
      ),
    );

    // Verify fund name is displayed as Title and Subtitle
    expect(find.text(fund.name), findsNWidgets(2));
    expect(find.textContaining('50.000'), findsOneWidget);

    final subscribeButton = find.widgetWithText(FilledButton, 'Suscribirme');
    expect(subscribeButton, findsOneWidget);

    final cancelButton = find.widgetWithText(OutlinedButton, 'Cancelar');
    expect(cancelButton, findsOneWidget);

    // Tap subscribe
    await tester.tap(subscribeButton);
    expect(subscribePressed, isTrue);
  });

  testWidgets(
    'FundCard disables subscribe and enables cancel when subscribed',
    (WidgetTester tester) async {
      bool cancelPressed = false;

      final fund = Fund(
        id: 2,
        name: 'Fondo Suscrito',
        minimumAmount: 100000,
        category: 'FIC',
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: FundCard(
              fund: fund,
              subscribed: true,
              onSubscribe: () {},
              onCancel: () => cancelPressed = true,
            ),
          ),
        ),
      );

      final subscribeButton = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Suscribirme'),
      );
      expect(subscribeButton.onPressed, isNull); // disabled

      final cancelButtonWidget = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, 'Cancelar'),
      );
      expect(cancelButtonWidget.onPressed, isNotNull); // enabled

      await tester.tap(find.widgetWithText(OutlinedButton, 'Cancelar'));
      expect(cancelPressed, isTrue);
    },
  );
}
