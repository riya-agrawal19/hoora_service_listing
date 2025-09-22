import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hoora_service_listing/main.dart' as app;

void main() {
  // Initialize integration test binding
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Favorite persists across app restart', (tester) async {
    // 1) Start app
    app.main();
    await tester.pumpAndSettle();

    // 2) Tap heart on first card
    final heartButton = find.byIcon(Icons.favorite_border).first;
    await tester.tap(heartButton);
    await tester.pumpAndSettle();

    // 3) Go to Favorites tab
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite), findsWidgets);

    // 4) Restart app
    app.main();
    await tester.pumpAndSettle();

    // 5) Navigate to Favorites again
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    // 6) Favorite should still be there (Hive persisted)
    expect(find.byIcon(Icons.favorite), findsWidgets);
  });
}