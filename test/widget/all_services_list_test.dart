import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoora_service_listing/core/utils/extensions/custom_theme_extension.dart';
import 'package:hoora_service_listing/data/datasources/local/hive_handler.dart';
import 'package:hoora_service_listing/data/datasources/remote/service_api.dart';
import 'package:hoora_service_listing/data/models/service_model.dart';
import 'package:hoora_service_listing/data/repositories/service_repo_impl.dart';
import 'package:hoora_service_listing/domain/providers/service_provider.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/widgets/all_services.dart';
import 'package:network_image_mock/network_image_mock.dart';

class FakeServiceProvider extends ServiceProvider {
  FakeServiceProvider(ServicesState state) : super(FakeRepo()) {
    this.state = state;
  }
}

// Fake repo just to satisfy constructor
class FakeRepo extends ServiceRepoImpl {
  FakeRepo() : super(FakeServiceApi(), FakeHiveHandler());
}

class FakeServiceApi implements ServiceApi {
  @override
  Future<List<ServiceModel>> fetchServices({required int page, required int limit}) async {
    return [];
  }
}

class FakeHiveHandler extends HiveHandler {
  Future<void> saveFavorite(ServiceModel service) async {}
  Future<List<ServiceModel>> getFavorites() async => [];
}

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

  testWidgets('AllServicesList renders items and shows loader when loading',
          (tester) async {
    final services = [
      ServiceModel(
        id: '1',
        title: 'Plumbing',
        category: 'Home',
        description: 'Fix leaking taps',
        price: 299,
        image: '',
      ),
      ServiceModel(
        id: '2',
        title: 'Painting',
        category: 'Home',
        description: 'Wall painting service',
        price: 1999,
        image: '',
      ),
    ];

    final fakeState = ServicesState(items: services, loading: true);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ServiceProvider.provider.overrideWith((ref) {
              return FakeServiceProvider(fakeState);
            }),
          ],
          child: MaterialApp(
              theme: _testTheme(), home: Scaffold(body: AllServicesList())),
        ),
      );

      expect(find.text('Plumbing'), findsOneWidget);
      expect(find.text('Painting'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
