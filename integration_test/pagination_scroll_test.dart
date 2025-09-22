import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hoora_service_listing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Scrolling to bottom loads next page', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Make sure we are on "All" tab
    if (find.text('All').evaluate().isNotEmpty) {
      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();
    }

    // Count initial tiles
    final initialTiles = find.byType(ListTile);
    final initialCount = initialTiles.evaluate().length;

    // Scroll to bottom to trigger loadMore
    await tester.fling(find.byType(ListView), const Offset(0, -800), 1000);
    await tester.pumpAndSettle();

    // After pagination, more tiles should appear (assuming next page succeeds)
    final afterCount = find.byType(ListTile).evaluate().length;
    expect(afterCount, greaterThan(initialCount));
  });
}