import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/data/models/service_model.dart';
import 'package:hoora_service_listing/domain/providers/providers.dart';
import 'package:hoora_service_listing/domain/providers/service_provider.dart';
import 'package:hoora_service_listing/domain/providers/theme_provider.dart';
import 'package:hoora_service_listing/presentation/base_view_model.dart';

final _serviceListingViewModel =
    ChangeNotifierProvider<ServiceListingViewModel>(
      (ref) => ServiceListingViewModel(
        ref.read(AppState.serviceListing.notifier),
      ),
    );

mixin ServiceListingView {
  void showLoader();

  void hideLoader();
}

class ServiceListingViewModel extends BaseViewModel<ServiceListingView> {
  final ServiceProvider _serviceProvider; // StateNotifier (not the state)

  ServiceListingViewModel(this._serviceProvider);

  static ChangeNotifierProvider<ServiceListingViewModel> get provider =>
      _serviceListingViewModel;

  // Scroll & pagination
  final ScrollController scrollCtrl = ScrollController();
  bool _hasAttachedListener = false;
  bool _loadingMore = false;

  // Overlay loader
  late OverlayEntry loader;

  /// Called from the widget after first frame
  Future<void> initAfterLoad() async {
    view?.showLoader();
    _attachBottomListener();
    onRefresh();
    view?.hideLoader();
    notifyListeners();
  }

  void _attachBottomListener() {
    if (_hasAttachedListener) return;
    _hasAttachedListener = true;

    scrollCtrl.addListener(() async {
      final remaining = scrollCtrl.position.extentAfter;

      if (remaining > 200) return;

      final st = _serviceProvider.state; // ServicesState (items, loading, hasMore)

      if (_loadingMore || st.loading || !st.hasMore) return;
      if (st.items.length < 10) return;

      _loadingMore = true;
      try {
        await _serviceProvider.loadMore(); // fetch next page of 10
      } finally {
        _loadingMore = false;
      }
    });
  }

  Future<void> onFavoriteTap(ServiceModel s) async {
    await _serviceProvider.toggleFavorite(s);
    notifyListeners(); // if your provider already updates state, this is optional
  }

  Future<void> onRefresh() async {
    await _serviceProvider.loadFirstPage();
  }

  // Cleanup
  void disposeControllers() {
    scrollCtrl.dispose();
  }
}
