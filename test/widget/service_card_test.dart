import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoora_service_listing/data/models/service_model.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/widgets/service_card.dart';
import 'package:hoora_service_listing/core/utils/extensions/custom_theme_extension.dart';

// Transparent 1x1 PNG
final Uint8List kTransparentImage = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8Xw8AAusB9WnJwGsAAAAASUVORK5CYII='
);

ThemeData _testTheme() => ThemeData(
  extensions: [
    CustomThemeExtension(
      primaryColor: Colors.blue,
      backgroundColor: Colors.white,
      cardBackgroundColor: Colors.white,
      textColor: Colors.black,
      subTextColor: Colors.black54,
      outlineColor: Colors.grey,
    ),
  ],
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ServiceCard shows title and triggers favorite callback', (tester) async {
    final fakeImage = MemoryImage(kTransparentImage);

    final s = ServiceModel(
      id: '1',
      title: 'Deep Cleaning',
      category: 'Home',
      description: 'Full house deep cleaning',
      price: 1999,
      image: 'https://example.com/fake.png',
      isFavorite: false,
    );

    ServiceModel? tapped;

    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme(),
        home: Scaffold(
          body: ServiceCard(
            service: s,
            imageProvider: fakeImage, // 👈 use valid PNG bytes
            onFavorite: (svc) => tapped = svc,
          ),
        ),
      ),
    );

    expect(find.text('Deep Cleaning'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(tapped?.id, '1');
  });
}