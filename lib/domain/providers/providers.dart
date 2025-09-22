import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_service_listing/data/repositories/service_repo_impl.dart';
import 'package:hoora_service_listing/domain/providers/service_provider.dart';
import 'package:hoora_service_listing/domain/providers/theme_provider.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/service_listing_view_model.dart';

abstract class Repository {
  static Provider<ServiceRepoImpl> get service => ServiceRepoImpl.provider;
}

abstract class DataProvider {
  static ChangeNotifierProvider<ThemeProvider> get theme =>
      ThemeProvider.provider;
}

abstract class AppState {
  static StateNotifierProvider<ServiceProvider, ServicesState> get serviceListing => ServiceProvider.provider;
}

