import 'package:hoora_service_listing/data/models/service_model.dart';

abstract class ServiceRepo {
  Future<List<ServiceModel>> getPage(int page, int limit);
  Future<void> toggleFavorite(ServiceModel service);
  Future<List<String>> getFavorites();
}