import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/data/models/service_model.dart';
import 'package:hoora_service_listing/data/repositories/service_repo_impl.dart';
import 'package:hoora_service_listing/domain/providers/providers.dart';

final _serviceProvider = StateNotifierProvider<ServiceProvider, ServicesState>(
  (ref) => ServiceProvider(ref.read(Repository.service)),
);

class ServiceProvider extends StateNotifier<ServicesState> {
  final ServiceRepoImpl _serviceRepoImpl;

  ServiceProvider(this._serviceRepoImpl) : super(ServicesState());

  static StateNotifierProvider<ServiceProvider, ServicesState> get provider =>
      _serviceProvider;

  static const _limit = 10;
  bool _loadingMore = false;

  Future<void> loadFirstPage() async {
    state = state.copyWith(loading: true, error: null, page: 1, items: []);
    try {
      final data = await _serviceRepoImpl.getPage(1, _limit);
      state = state.copyWith(
        items: data,
        loading: false,
        hasMore: data.length == _limit,
        page: 1,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    _loadingMore = true;
    state = state.copyWith(loading: true);
    try {
      final next = state.page + 1;
      final data = await _serviceRepoImpl.getPage(next, _limit);
      state = state.copyWith(
        items: [...state.items, ...data],
        loading: false,
        page: next,
        hasMore: data.length == _limit,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    } finally {
      _loadingMore = false;
    }
  }

  Future<void> toggleFavorite(ServiceModel s) async {
    await _serviceRepoImpl.toggleFavorite(s);
    final updated = s.copyWith(isFavorite: !s.isFavorite);
    final newList = state.items
        .map((item) => item.id == s.id ? updated : item)
        .toList();
    state = state.copyWith(items: newList);
  }

  bool get _canLoadMore => !_loadingMore && !state.loading && state.hasMore;
}

class ServicesState {
  final List<ServiceModel> items;
  final bool loading;
  final String? error;
  final int page;
  final bool hasMore;

  const ServicesState({
    this.items = const [],
    this.loading = false,
    this.error,
    this.page = 1,
    this.hasMore = true,
  });

  ServicesState copyWith({
    List<ServiceModel>? items,
    bool? loading,
    String? error,
    int? page,
    bool? hasMore,
  }) => ServicesState(
    items: items ?? this.items,
    loading: loading ?? this.loading,
    error: error,
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
  );
}
