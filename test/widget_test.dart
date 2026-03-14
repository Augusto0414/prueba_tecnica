import 'dart:ui';

import 'package:btg_bank/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Muestra la pantalla principal de fondos', (
    WidgetTester tester,
  ) async {
    // Start the app with a large surface to avoid overflow issues in tests
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const App());

    // Pump to handle MultiProvider and InitialRoute
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify "Saldo disponible" exists (at least once in this robust version)
    expect(find.text('Saldo disponible'), findsWidgets);

    // Verify "Fondos disponibles" header
    expect(find.text('Fondos disponibles'), findsWidgets);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
