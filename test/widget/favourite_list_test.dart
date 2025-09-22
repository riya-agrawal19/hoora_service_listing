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

  testWidgets('Tapping favorite icon calls onFavorite', (tester) async {
    final fakeImage = MemoryImage(kTransparentImage);
    bool tapped = false;
    final service = ServiceModel(
      id: '2',
      title: 'AC Repair',
      category: 'Appliance',
      description: 'Fix AC cooling issues',
      price: 799,
      image: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme(),
        home: Scaffold(
          body: ServiceCard(
            service: service,
            imageProvider: fakeImage,
            onFavorite: (_) {
              tapped = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(tapped, true);
  });
}