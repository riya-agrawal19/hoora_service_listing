import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hoora_service_listing/domain/providers/theme_provider.dart';
import 'package:hoora_service_listing/presentation/screens/service_listing/service_listing.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.openBox<String>('favorite_service_ids');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProvider.provider).themeData;

    return MaterialApp(
      title: 'Pras Interiors',
      theme: theme,
      home: ServiceListing(),
    );
  }
}