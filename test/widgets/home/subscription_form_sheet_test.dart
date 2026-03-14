import 'package:btg_bank/models/fund.dart';
import 'package:btg_bank/models/transaction_record.dart';
import 'package:btg_bank/widgets/home/subscription_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fund = Fund(
    id: 1,
    name: 'Fondo Test',
    minimumAmount: 10000,
    category: 'FPV',
  );

  testWidgets('SubscriptionFormSheet validates empty fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SubscriptionFormSheet(fund: fund)),
      ),
    );

    expect(find.textContaining('Suscribirse a Fondo Test'), findsOneWidget);

    final confirmButton = find.widgetWithText(
      FilledButton,
      'Confirmar suscripcion',
    );
    await tester.tap(confirmButton);
    await tester.pump();

    // Expect validation error
    expect(find.text('Este campo es obligatorio.'), findsOneWidget);
  });

  testWidgets(
    'SubscriptionFormSheet changes input placeholder and validation based on method',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SubscriptionFormSheet(fund: fund)),
        ),
      );

      // Default is Email
      expect(find.text('Correo electronico'), findsOneWidget);

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField), 'invalid-email');
      await tester.tap(
        find.widgetWithText(FilledButton, 'Confirmar suscripcion'),
      );
      await tester.pump();
      expect(find.text('Ingresa un correo valido.'), findsOneWidget);

      // Switch to SMS
      await tester.tap(
        find.byType(DropdownButtonFormField<NotificationMethod>),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('SMS').last);
      await tester.pumpAndSettle();

      expect(find.text('Numero celular'), findsOneWidget);

      // Enter invalid phone
      await tester.enterText(find.byType(TextFormField), '123'); // too short
      await tester.tap(
        find.widgetWithText(FilledButton, 'Confirmar suscripcion'),
      );
      await tester.pump();
      expect(
        find.text('Ingresa un celular valido (10 a 13 digitos).'),
        findsOneWidget,
      );
    },
  );
}
