import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/data/helper/functions.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/service_listing_view_model.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/widgets/all_services.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/widgets/favourite_list.dart';

class ServiceListing extends ConsumerStatefulWidget {
  const ServiceListing({super.key});

  @override
  ConsumerState<ServiceListing> createState() => _ServiceListingState();
}

class _ServiceListingState extends ConsumerState<ServiceListing> implements ServiceListingView{
  late final ServiceListingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(ServiceListingViewModel.provider);
    _viewModel.attachView(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _viewModel.loader = overlayLoader();
      await _viewModel.initAfterLoad();
    });
  }

  @override
  void dispose() {
    _viewModel.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // All Services + Favorites
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Services"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "All Services"),
              Tab(text: "Favorites"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllServicesList(),
            FavoritesList(),
          ],
        ),
      ),
    );
  }

  @override
  void hideLoader() {
    _viewModel.toggleLoadingOn(false);
    _viewModel.loader.remove();
  }

  @override
  void showLoader() {
    _viewModel.toggleLoadingOn(true);
    FocusScope.of(context).unfocus();
    Overlay.of(context).insert(_viewModel.loader);
  }
}