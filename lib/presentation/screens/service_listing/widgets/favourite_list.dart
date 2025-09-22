import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/domain/providers/selector.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/service_listing_view_model.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/widgets/service_card.dart';

class FavoritesList extends ConsumerWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favs = ref.watch(favoriteServicesProvider);
    final ServiceListingViewModel _viewModel = ref.read(
      ServiceListingViewModel.provider,
    );

    if (favs.isEmpty) {
      return const Center(
        child: Text('No favorites yet'),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.all(12),
      itemCount: favs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final s = favs[index];
        return ServiceCard(
          service: s,
          onFavorite: (s) => _viewModel.onFavoriteTap(s)
        );
      },
    );
  }
}