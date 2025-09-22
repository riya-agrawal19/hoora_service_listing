import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/domain/providers/selector.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/service_listing_view_model.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/widgets/service_card.dart';

class AllServicesList extends ConsumerWidget {
  const AllServicesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ServiceListingViewModel _viewModel = ref.read(
      ServiceListingViewModel.provider,
    );
    final items = ref.watch(allServicesProvider);
    final state = ref.watch(servicesStateProvider);

    return ListView.separated(
      controller: _viewModel.scrollCtrl,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.all(12),
      itemCount: items.length + (state.loading ? 1 : 0),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index >= items.length) {
          // bottom loader during pagination
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final s = items[index];
        return ServiceCard(
          service: s,
          onFavorite: (s) => _viewModel.onFavoriteTap(s)
        );
      },
    );
  }
}
