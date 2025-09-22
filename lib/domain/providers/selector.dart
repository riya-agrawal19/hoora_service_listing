import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/domain/providers/providers.dart';
import 'package:hoora_service_listing/data/models/service_model.dart';
import 'package:hoora_service_listing/domain/providers/service_provider.dart';

/// Full services state
final servicesStateProvider = Provider<ServicesState>(
      (ref) => ref.watch(AppState.serviceListing),
);

/// All items
final allServicesProvider = Provider<List<ServiceModel>>(
      (ref) => ref.watch(servicesStateProvider).items,
);

/// Favorites only
final favoriteServicesProvider = Provider<List<ServiceModel>>((ref) {
  final s = ref.watch(servicesStateProvider);
  return s.items.where((e) => e.isFavorite).toList();
});