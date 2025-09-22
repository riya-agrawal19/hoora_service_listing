import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/data/datasources/local/hive_handler.dart';
import 'package:hoora_service_listing/data/datasources/remote/service_api.dart';
import 'package:hoora_service_listing/data/models/service_model.dart';
import 'package:hoora_service_listing/domain/repostories/service_repo.dart';

final _serviceRepoProvider = Provider<ServiceRepoImpl>(
  (ref) => ServiceRepoImpl(ref.watch(ServiceApi.provider), ref.watch(HiveHandler.provider)),
);

class ServiceRepoImpl implements ServiceRepo {
  final ServiceApi serviceApi;
  final HiveHandler hiveHandler;

  ServiceRepoImpl(this.serviceApi, this.hiveHandler);

  static Provider<ServiceRepoImpl> get provider => _serviceRepoProvider;

  @override
  Future<List<ServiceModel>> getPage(int page, int limit) async{
    final data = await serviceApi.fetchServices(page: page, limit: limit);
    final favIds = hiveHandler.getAll().toSet();
    return data
        .map((s) => s.copyWith(isFavorite: favIds.contains(s.id)))
        .toList();
  }

  @override
  Future<void> toggleFavorite(ServiceModel service) async {
    if (service.isFavorite) {
      await hiveHandler.remove(service.id);
    } else {
      await hiveHandler.add(service.id);
    }
  }

  @override
  Future<List<String>> getFavorites() async {
    return hiveHandler.getAll();
  }
}
